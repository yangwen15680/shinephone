//
//  findViewController.m
//  shinelink
//
//  Created by sky on 16/2/15.
//  Copyright © 2016年 sky. All rights reserved.
//

#import "meViewController.h"
#import "meTableViewCell.h"
#import "aboutViewController.h"
#import "userdataViewController.h"
#import "listViewController.h"

#define Kwidth [UIScreen mainScreen].bounds.size.width


@interface meViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITabBarControllerDelegate>

@property (nonatomic, strong) UIImagePickerController *cameraImagePicker;
@property (nonatomic, strong) UIImagePickerController *photoLibraryImagePicker;

@end

@implementation meViewController
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
    
    arrayName=@[@"资料管理",@"客户服务",@"系统设置",@"关于"];
    arrayImage=@[@"about.png",@"client.png",@"setup.png",@"userdata.png"];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    //创建tableView的方法
    [self _createTableView];
    
    //创建tableView的头视图
    [self _createHeaderView];
    
  
    
}

- (void)_createTableView {
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:_tableView];
    _indenty = @"indenty";
    //注册单元格类型
    [_tableView registerClass:[meTableViewCell class] forCellReuseIdentifier:_indenty];
}

- (void)_createHeaderView {
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0,0,Kwidth,200)];
    UIColor *color=[UIColor colorWithRed:130/ 255.0f green:200 / 255.0f blue:250 / 255.0f alpha:1];
 [headerView setBackgroundColor:color];
    double imageSize=150;
    
   UIImageView *userImage= [[UIImageView alloc] initWithFrame:CGRectMake((Kwidth-imageSize)/2, 25, imageSize, imageSize)];
      [userImage setImage:[UIImage imageNamed:@"1.jpg"]];
    userImage.layer.masksToBounds=YES;
    userImage.layer.cornerRadius=imageSize/2.0;
    [userImage setUserInteractionEnabled:YES];
    
    UILongPressGestureRecognizer * longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(pickUpImage)];
    longPressGesture.minimumPressDuration = 1.0f;
     [userImage addGestureRecognizer:longPressGesture];
    
    
    _tableView.tableHeaderView = headerView;
    [headerView addSubview:userImage];

}

- (void)pickUpImage{
    NSLog(@"取照片");
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle: nil
                                                                              message: nil
                                                                       preferredStyle:UIAlertControllerStyleActionSheet];
    //添加Button
    [alertController addAction: [UIAlertAction actionWithTitle: @"拍照" style: UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
         //处理点击拍照
        self.cameraImagePicker = [[UIImagePickerController alloc] init];
        self.cameraImagePicker.allowsEditing = YES;
        self.cameraImagePicker.delegate = self;
        self.cameraImagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:_cameraImagePicker animated:YES completion:nil];

    }]];
    [alertController addAction: [UIAlertAction actionWithTitle: @"从相册选取" style: UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        //处理点击从相册选取
        self.photoLibraryImagePicker = [[UIImagePickerController alloc] init];
        self.photoLibraryImagePicker.allowsEditing = YES;
        self.photoLibraryImagePicker.delegate = self;
        self.photoLibraryImagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:_photoLibraryImagePicker animated:YES completion:nil];
        
    }]];
    [alertController addAction: [UIAlertAction actionWithTitle: @"取消" style: UIAlertActionStyleCancel handler:nil]];
    
    [self presentViewController: alertController animated: YES completion: nil];
    
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



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    meTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:_indenty forIndexPath:indexPath];
    //   cell.textLabel.text = [NSString stringWithFormat:@"Cell:%ld",indexPath.row];
    if (!cell) {
        cell=[[meTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:_indenty];
    }
    
    [cell.imageLog setImage:[UIImage imageNamed:arrayImage[indexPath.row]]];
    cell.tableName.text = arrayName[indexPath.row];
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath

{
    if (indexPath.row==0) {
        userdataViewController *aboutView = [[userdataViewController alloc]init];
        
        [self.navigationController pushViewController:aboutView animated:YES];
    }
    if (indexPath.row==1) {
       listViewController  *listView = [[listViewController alloc]init];
        
        [self.navigationController pushViewController:listView animated:YES];
    }
    if (indexPath.row==3) {
        aboutViewController *aboutView = [[aboutViewController alloc]init];
        
        [self.navigationController pushViewController:aboutView animated:YES];
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
