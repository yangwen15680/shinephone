//
//  deviceViewController.m
//  shinelink
//
//  Created by sky on 16/2/15.
//  Copyright © 2016年 sky. All rights reserved.
//

#import "deviceViewController.h"
#import "TableViewCell.h"
#import "EditStationMenuView.h"
#import "DTKDropdownMenuView.h"

#define ColorWithRGB(r,g,b) [UIColor colorWithRed:r/255. green:g/255. blue:b/255. alpha:1]

@interface deviceViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,EditStationMenuViewDelegate,UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITabBarControllerDelegate>

@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, strong) EditStationMenuView *menuView;
@property (nonatomic, strong) UIActionSheet *uploadImageActionSheet;
@property (nonatomic, strong) UIImagePickerController *cameraImagePicker;
@property (nonatomic, strong) UIImagePickerController *photoLibraryImagePicker;
@property (nonatomic, strong)  NSMutableArray* imageArray;
@property (nonatomic, strong) NSMutableArray *nameArray;
@property (nonatomic, strong) NSMutableArray *statueArray;
@property (nonatomic, strong) NSMutableArray *powerArray;
@property (nonatomic, strong) NSMutableArray *dayArray;

@end

@implementation deviceViewController
{
    UITableView *_tableView;
    UIPageControl *_pageControl;
    UIScrollView *_scrollerView;
    NSString *_indenty;
    
    
    //全局变量 用来控制偏移量
    NSInteger pageName;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    _imageArray=[[NSMutableArray alloc]initWithObjects:@"4.gif", @"2.jpg", @"3.jpg", nil];
    _nameArray=[[NSMutableArray alloc]initWithObjects:@"逆变器", @"储能机", @"采集器", nil];
    _statueArray=[[NSMutableArray alloc]initWithObjects:@"未连接", @"已连接", @"未连接", nil];
    _powerArray=[[NSMutableArray alloc]initWithObjects:@"5000KW", @"5000KW", @"5000KW", nil];
    _dayArray=[[NSMutableArray alloc]initWithObjects:@"500K/h", @"500K/h", @"500K/h", nil];
    // Do any additional setup after loading the view.
  [self.navigationController.navigationBar setTranslucent:YES];
    UIImage *bgImage = IMAGE(@"loginbg.jpg");
    self.view.layer.contents = (id)bgImage.CGImage;
    

    //self.navigationController.navigationBar.tintColor=[UIColor blueColor];
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd  target:self action:@selector(selectRightAction)];
    self.navigationItem.rightBarButtonItem = rightButton;
    
  //  [[UIBarButtonItem appearance] setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14.f],NSForegroundColorAttributeName:[UIColor blueColor]} forState:UIControlStateNormal];
  //  [[UIBarButtonItem appearance] setTintColor:[UIColor blueColor]];
   
    
       [self addTitleMenu];
    //创建tableView的方法
    [self _createTableView];
    
    //创建tableView的头视图
    [self _createHeaderView];
    
    [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(circulate:) userInfo:nil repeats:YES];
}
-(void)selectRightAction{
    NSLog(@"adddevice");

}

- (void)addTitleMenu
{
    DTKDropdownItem *item0 = [DTKDropdownItem itemWithTitle:@"家庭能源系统0" callBack:^(NSUInteger index, id info) {
        NSLog(@"家庭能源系统%lu",(unsigned long)index);
    }];
    DTKDropdownItem *item1 = [DTKDropdownItem itemWithTitle:@"家庭能源系统1" callBack:^(NSUInteger index, id info) {
        NSLog(@"家庭能源系统%lu",(unsigned long)index);
    }];
    DTKDropdownItem *item2 = [DTKDropdownItem itemWithTitle:@"家庭能源系统2" callBack:^(NSUInteger index, id info) {
        NSLog(@"家庭能源系统%lu",(unsigned long)index);
    }];
    DTKDropdownItem *item3 = [DTKDropdownItem itemWithTitle:@"家庭能源系统3" callBack:^(NSUInteger index, id info) {
        NSLog(@"家庭能源系统%lu",(unsigned long)index);
    }];
    DTKDropdownMenuView *menuView = [DTKDropdownMenuView dropdownMenuViewForNavbarTitleViewWithFrame:CGRectMake(0, 0, 200.f, 44.f) dropdownItems:@[item0,item1,item2,item3]];
    menuView.currentNav = self.navigationController;
    menuView.dropWidth = 150.f;
    menuView.titleColor=[UIColor blueColor];
    menuView.titleFont = [UIFont systemFontOfSize:18.f];
    menuView.textColor = [UIColor blueColor];;
    menuView.textFont = [UIFont systemFontOfSize:13.f];
    menuView.cellSeparatorColor =[UIColor blueColor];;
    menuView.textFont = [UIFont systemFontOfSize:14.f];
    menuView.animationDuration = 0.2f;
    menuView.selectedIndex = 0;
    self.navigationItem.titleView = menuView;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)_createTableView {
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:_tableView];
    _indenty = @"indenty";
    //注册单元格类型
    [_tableView registerClass:[TableViewCell class] forCellReuseIdentifier:_indenty];
}

#pragma mark 创建tableView的头视图的方法
- (void)_createHeaderView {
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0,0,Kwidth,200)];
    _tableView.tableHeaderView = headerView;
    
    _scrollerView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,0,Kwidth,headerView.bounds.size.height)];
    
    NSArray *imgArray = @[@"3.jpg",
                          @"2.jpg",
                          @"1.jpg"];
    for (int i=0; i<imgArray.count; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(Kwidth*i,0,Kwidth,_scrollerView.bounds.size.height)];
        imageView.image = [UIImage imageNamed:imgArray[i]];
        [_scrollerView addSubview:imageView];
    }
    _scrollerView.contentSize = CGSizeMake(Kwidth*imgArray.count,headerView.bounds.size.height);
    _scrollerView.pagingEnabled = YES;
    _scrollerView.showsHorizontalScrollIndicator = NO;
    _scrollerView.delegate = self;
    [headerView addSubview:_scrollerView];
    
    //创建分页视图
    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0,headerView.bounds.size.height-20,Kwidth,20)];
    _pageControl.numberOfPages = imgArray.count;
    _pageControl.currentPage = 0;
    [_pageControl addTarget:self action:@selector(pageAction:) forControlEvents:UIControlEventValueChanged];
    [headerView addSubview:_pageControl];
}

#pragma mark tableView的协议方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _imageArray.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
   TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:_indenty forIndexPath:indexPath];
 //   cell.textLabel.text = [NSString stringWithFormat:@"Cell:%ld",indexPath.row];
    if (!cell) {
    cell=[[TableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:_indenty];
    }
   
   [cell.coverImageView  setImage:[UIImage imageNamed:_imageArray[indexPath.row]]];
    cell.titleLabel.text = _nameArray[indexPath.row];
       cell.stateValue.text = _statueArray[indexPath.row];
     cell.powerValue.text = _powerArray[indexPath.row];
     cell.electricValue.text =_dayArray[indexPath.row];
    /*UILongPressGestureRecognizer * longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(cellDidLongPressed:)];
    longPressGesture.minimumPressDuration = 1.0f;
    [cell addGestureRecognizer:longPressGesture];*/
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        //更新数据
        [_imageArray removeObjectAtIndex:indexPath.row];
        [_nameArray removeObjectAtIndex:indexPath.row];
        [_statueArray removeObjectAtIndex:indexPath.row];
        [_powerArray removeObjectAtIndex:indexPath.row];
        [_dayArray removeObjectAtIndex:indexPath.row];
        //更新UI
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
    }else if (editingStyle == UITableViewCellEditingStyleInsert) {
        
    }
}

- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    //添加一个删除按钮
    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:(UITableViewRowActionStyleDestructive) title:@"删除 "handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        NSLog(@"点击了删除");
        
        //1.更新数据
        [_imageArray removeObjectAtIndex:indexPath.row];
        [_nameArray removeObjectAtIndex:indexPath.row];
        [_statueArray removeObjectAtIndex:indexPath.row];
        [_powerArray removeObjectAtIndex:indexPath.row];
        [_dayArray removeObjectAtIndex:indexPath.row];
        //2.更新UI
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:(UITableViewRowAnimationAutomatic)];
        
    }];
    //删除按钮颜色
    deleteAction.backgroundColor = [UIColor cyanColor];
    //添加一个置顶按钮
    UITableViewRowAction *topRowAction =[UITableViewRowAction rowActionWithStyle:(UITableViewRowActionStyleDestructive) title:@"置顶 "handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        NSLog(@"点击了置顶");
        //1.更新数据
        [_imageArray exchangeObjectAtIndex:indexPath.row withObjectAtIndex:0];
        [_nameArray exchangeObjectAtIndex:indexPath.row withObjectAtIndex:0];
        [_statueArray exchangeObjectAtIndex:indexPath.row withObjectAtIndex:0];
        [_powerArray exchangeObjectAtIndex:indexPath.row withObjectAtIndex:0];
        [_dayArray exchangeObjectAtIndex:indexPath.row withObjectAtIndex:0];
        //2.更新UI
        NSIndexPath *firstIndexPath =[NSIndexPath indexPathForRow:0 inSection:indexPath.section];
        [tableView moveRowAtIndexPath:indexPath toIndexPath:firstIndexPath];
    }];
    
    //置顶按钮颜色
    topRowAction.backgroundColor = [UIColor magentaColor];
    
     return @[deleteAction,topRowAction];
    
}


- (void)cellDidLongPressed:(UIGestureRecognizer *)recognizer{
    if(recognizer.state == UIGestureRecognizerStateBegan) {
        CGPoint point = [recognizer locationInView:_tableView];
        self.indexPath = [_tableView indexPathForRowAtPoint:point];
        if(_indexPath == nil) return ;
        //
        self.menuView = [[EditStationMenuView alloc] initWithFrame:self.view.bounds];
        self.menuView.delegate = self;
        self.menuView.tintColor = [UIColor blackColor];
        self.menuView.dynamic = NO;
        self.menuView.blurRadius = 10.0f;
        [[UIApplication sharedApplication].keyWindow addSubview:_menuView];
    }
}

- (void)menuDidSelectAtRow:(NSInteger)row {
    if (row == 0) {
        //取消菜单
        [_menuView removeFromSuperview];
        return;
    }
    if (row == 1) {
        //添加电站
        [_menuView removeFromSuperview];
       // AddStationViewController *asvc = [[AddStationViewController alloc] init];
       // [self.navigationController pushViewController:asvc animated:YES];
    }
    if (row == 2) {
        //删除电站
    }
    if (row == 3) {
        //上传电站图片
        [_menuView removeFromSuperview];
        self.uploadImageActionSheet = [[UIActionSheet alloc] initWithTitle:NSLocalizedString(@"Choice", @"Choice") delegate:self cancelButtonTitle:root_Cancel destructiveButtonTitle:nil otherButtonTitles:NSLocalizedString(@"Shooting", @"Shooting"), NSLocalizedString(@"Album", @"Album"), nil];
        self.uploadImageActionSheet.actionSheetStyle = UIActionSheetStyleAutomatic;
        [self.uploadImageActionSheet showInView:self.view];
    }
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (actionSheet == _uploadImageActionSheet) {
        //拍照
        if (buttonIndex == 0) {
            self.cameraImagePicker = [[UIImagePickerController alloc] init];
            self.cameraImagePicker.allowsEditing = YES;
            self.cameraImagePicker.delegate = self;
            self.cameraImagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self presentViewController:_cameraImagePicker animated:YES completion:nil];
        }
        //从相册选择
        if (buttonIndex == 1) {
            
            self.photoLibraryImagePicker = [[UIImagePickerController alloc] init];
            self.photoLibraryImagePicker.allowsEditing = YES;
            self.photoLibraryImagePicker.delegate = self;
            self.photoLibraryImagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            [self presentViewController:_photoLibraryImagePicker animated:YES completion:nil];
        }
    }
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

@end
