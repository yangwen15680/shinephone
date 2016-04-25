//
//  findViewController.m
//  shinelink
//
//  Created by sky on 16/2/15.
//  Copyright © 2016年 sky. All rights reserved.
//

#import "findViewController.h"
#import "findTableViewCell.h"
#define Kwidth [UIScreen mainScreen].bounds.size.width
#import "listViewController.h"
#import "commonTableViewController.h"
#import "LZPageViewController.h"
#import "qualityTableViewController.h"
#import "moreTableViewController.h"

@interface findViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>
@property(nonatomic,strong)NSMutableArray *imageArray;
@end

@implementation findViewController
{
    UITableView *_tableView;
    UIPageControl *_pageControl;
    UIScrollView *_scrollerView;
    NSString *_indenty;
    
      NSArray *arrayImage;
       NSArray *arrayName;
    
    
    //全局变量 用来控制偏移量
    NSInteger pageName;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationController.navigationBar setTitleTextAttributes:@{
                                                                      NSForegroundColorAttributeName :[UIColor whiteColor]
                                                                      }];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    [self setTitle:@"服务"];
      [self.navigationController.navigationBar setBarTintColor:COLOR(17, 183, 243, 1)];
    arrayName=@[@"客户服务",@"质保查询",@"增值业务",@"更多产品"];
    arrayImage=@[@"客户服务.png",@"质保查询.png",@"增值服务.png",@"更多.png"];
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self netFind];
    //创建tableView的方法
    [self _createTableView];
    

    
    [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(circulate:) userInfo:nil repeats:YES];

}

-(void)netFind{
    
    [self showProgressView];
    [BaseRequest requestImageWithMethodByGet:HEAD_URL paramars:@{@"admin":@"admin"} paramarsSite:@"/newPlantAPI.do?op=getAdvertisingImages" sucessBlock:^(id content) {
        [self hideProgressView];
        NSLog(@"getAdvertisingImages=: %@", content);
        _imageArray=[NSMutableArray arrayWithObject:content];
      
        
        [self _createHeaderView];
        
    } failure:^(NSError *error) {
        [self hideProgressView];
        [self showToastViewWithTitle:root_Networking];
        
    }];

}


- (void)_createTableView {
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0,Kwidth,SCREEN_Height) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:_tableView];
    _indenty = @"indenty";
    //注册单元格类型
    [_tableView registerClass:[findTableViewCell class] forCellReuseIdentifier:_indenty];
}

- (void)_createHeaderView {
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0,NavigationbarHeight,Kwidth,200*NOW_SIZE)];
    _tableView.tableHeaderView = headerView;
    
  _scrollerView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,NavigationbarHeight,Kwidth,headerView.bounds.size.height)];
    
    if (_imageArray) {
        for (int i=0; i<_imageArray.count; i++) {
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(Kwidth*i,0,Kwidth,_scrollerView.bounds.size.height)];
            imageView.image = _imageArray[i];
            [_scrollerView addSubview:imageView];
            
             _scrollerView.contentSize = CGSizeMake(Kwidth*_imageArray.count,headerView.bounds.size.height);
            _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0,headerView.bounds.size.height-20,Kwidth,20)];
            _pageControl.numberOfPages = _imageArray.count;
        }
    }else{
    NSArray *imgArray = @[@"1.jpg",
                          @"2.jpg",
                          @"3.jpg"];
    for (int i=0; i<imgArray.count; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(Kwidth*i,0,Kwidth,_scrollerView.bounds.size.height)];
        imageView.image = [UIImage imageNamed:imgArray[i]];
        [_scrollerView addSubview:imageView];
        
        _scrollerView.contentSize = CGSizeMake(Kwidth*imgArray.count,headerView.bounds.size.height);
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0,headerView.bounds.size.height-20,Kwidth,20)];
        _pageControl.numberOfPages = imgArray.count;
         }
    }
    
   
    _scrollerView.pagingEnabled = YES;
    _scrollerView.showsHorizontalScrollIndicator = NO;
    _scrollerView.delegate = self;
    [headerView addSubview:_scrollerView];
    
    //创建分页视图

    _pageControl.currentPage = 0;
    [_pageControl addTarget:self action:@selector(pageAction:) forControlEvents:UIControlEventValueChanged];
    [headerView addSubview:_pageControl];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 65*NOW_SIZE;
    
}

#pragma mark pageAction的实现方法
- (void)pageAction:(UIPageControl *)control {
    NSInteger page = control.currentPage;
    [_scrollerView setContentOffset:CGPointMake(Kwidth*page,0) animated:YES];
}


#pragma mark _scrollerView的协议方法
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    CGFloat x = scrollView.contentOffset.x / Kwidth;
    _pageControl.currentPage = x;
}

#pragma mark 定时器方法
- (void)circulate:(NSTimer *)timer {
    
    pageName++;
    
    [_scrollerView setContentOffset:CGPointMake(Kwidth*pageName, 0) animated:YES];
    _pageControl.currentPage = pageName;
    
    if (pageName == 2) {
        pageName = -1;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    findTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:_indenty forIndexPath:indexPath];
    //   cell.textLabel.text = [NSString stringWithFormat:@"Cell:%ld",indexPath.row];
    if (!cell) {
        cell=[[findTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:_indenty];
    }
    
    [cell.imageLog setImage:[UIImage imageNamed:arrayImage[indexPath.row]]];
  cell.tableName.text = arrayName[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath

{
    if (indexPath.row==0) {
    
        LZPageViewController *pageVc = [[LZPageViewController alloc] initWithTitles:@[@"我的问题",@"常见问题",] controllersClass:@[[listViewController class],[commonTableViewController class]]];
        [self.navigationController pushViewController:pageVc animated:NO];
    }else if (indexPath.row==1){
        qualityTableViewController *page2 = [[qualityTableViewController alloc] init];
        [self.navigationController pushViewController:page2 animated:NO];
    }else if (indexPath.row==3){
        moreTableViewController *page4 = [[moreTableViewController alloc] init];
        [self.navigationController pushViewController:page4 animated:NO];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
