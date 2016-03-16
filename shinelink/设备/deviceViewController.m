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
#import "addDevice.h"
#import "secondViewController.h"
#import "StationCellectViewController.h"
#import "secondCNJ.h"

#define ColorWithRGB(r,g,b) [UIColor colorWithRed:r/255. green:g/255. blue:b/255. alpha:1]

@interface deviceViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,EditStationMenuViewDelegate,UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITabBarControllerDelegate>

@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, strong) EditStationMenuView *menuView;
@property (nonatomic, strong) UIActionSheet *uploadImageActionSheet;
@property (nonatomic, strong) UIImagePickerController *cameraImagePicker;
@property (nonatomic, strong) UIImagePickerController *photoLibraryImagePicker;

@property (nonatomic, strong) NSMutableArray *stationID;
@property (nonatomic, strong) NSMutableArray *stationName;
@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, strong) NSMutableArray *typeArr;
@property (nonatomic, strong) NSMutableDictionary *plantId;
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation deviceViewController
{
     NSMutableArray* imageArray;
     NSMutableArray *nameArray;
     NSMutableArray *statueArray;
    NSMutableArray *powerArray;
    NSMutableArray *dayArray;
     NSMutableArray* imageArray2;
     NSMutableArray *nameArray2;
     NSMutableArray *statueArray2;
     NSMutableArray *powerArray2;
     NSMutableArray *dayArray2;
    UIPageControl *_pageControl;
    UIScrollView *_scrollerView;
    NSString *_indenty;
    
    
    //全局变量 用来控制偏移量
    NSInteger pageName;
}

- (instancetype)initWithDataDict:(NSMutableArray *)stationID stationName:(NSMutableArray *)stationName{
    if (self = [super init]) {
        if (stationID.count>0) {
        self.stationID = [NSMutableArray arrayWithArray:stationID];
        self.stationName = [NSMutableArray arrayWithArray:stationName];
        }else{
            self.stationID =[NSMutableArray arrayWithObjects:@"1", nil];
             self. stationName =[NSMutableArray arrayWithObjects:@"示范电站", nil];
        }
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _typeArr=[NSMutableArray array];
    nameArray=[NSMutableArray array];
    statueArray=[NSMutableArray array];
    dayArray=[NSMutableArray array];
    imageArray=[NSMutableArray array];
    powerArray=[NSMutableArray array];
    imageArray2=[[NSMutableArray alloc]initWithObjects:@"逆变器.png", @"储能机.png", @"3.jpg", @"1.jpg",@"1.jpg",@"充电桩.png",nil];
    nameArray2=[[NSMutableArray alloc]initWithObjects:@"inverter", @"storage", @"RF", @"BOX",@"switch", @"charge",  nil];
    statueArray2=[[NSMutableArray alloc]initWithObjects:@"未连接", @"未连接", @"未连接", @"未连接",@"未连接",@"未连接",nil];
    powerArray2=[[NSMutableArray alloc]initWithObjects:@"5000KW", @"5000KW", @"5000KW",@"5000KW", @"5000KW", @"5000KW",  nil];
    dayArray2=[[NSMutableArray alloc]initWithObjects:@"500K/h", @"500K/h", @"500K/h", @"500K/h",@"500K/h",@"500K/h",nil];
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
    
    [self addRightItem];
    //创建tableView的方法
    [self _createTableView];
    
    //创建tableView的头视图
    [self _createHeaderView];
    
    [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(circulate:) userInfo:nil repeats:YES];
}

#pragma mark - navigationItem
-(void)selectRightAction{
    addDevice *add=[[addDevice alloc]init];
    [self.navigationController pushViewController:add animated:YES];

}

- (void)addRightItem
{
    DTKDropdownItem *item0 = [DTKDropdownItem itemWithTitle:@"添加设备" iconName:@"DTK_jiangbei" callBack:^(NSUInteger index, id info) {
        NSLog(@"rightItem%lu",(unsigned long)index);
        [self selectRightAction];
    }];
    DTKDropdownItem *item1 = [DTKDropdownItem itemWithTitle:@"采集器列表" iconName:@"DTK_renwu" callBack:^(NSUInteger index, id info) {
        NSLog(@"rightItem%lu",(unsigned long)index);
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"等待接口" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertView show];
    }];
    DTKDropdownMenuView *menuView = [DTKDropdownMenuView dropdownMenuViewWithType:dropDownTypeRightItem frame:CGRectMake(0, 0, 44.f, 44.f) dropdownItems:@[item0,item1] icon:@"DTK_bi"];
    
    menuView.dropWidth = 150.f;
    menuView.titleFont = [UIFont systemFontOfSize:18.f];
    menuView.textColor = ColorWithRGB(102.f, 102.f, 102.f);
    menuView.textFont = [UIFont systemFontOfSize:13.f];
    menuView.cellSeparatorColor = ColorWithRGB(229.f, 229.f, 229.f);
    menuView.textFont = [UIFont systemFontOfSize:14.f];
    menuView.animationDuration = 0.2f;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:menuView];
}
    
- (void)addTitleMenu
{
    NSMutableArray *DTK=[NSMutableArray array];
    for(int i=0;i<_stationID.count;i++)
    {
        NSString *DTKtitle=[[NSString alloc]initWithFormat:_stationName[i]];
    DTKDropdownItem *DTKname= [DTKDropdownItem itemWithTitle:DTKtitle callBack:^(NSUInteger index, id info) {
        NSLog(@"家庭能源系统%lu",(unsigned long)index);
        [ [UserInfo defaultUserInfo]setPlantID:_stationID[index]];
        [ [UserInfo defaultUserInfo]setPlantNum:[NSString stringWithFormat:@"%lu",(unsigned long)index]];
    }];
         [DTK addObject:DTKname];
    }
  
    DTKDropdownMenuView *menuView = [DTKDropdownMenuView dropdownMenuViewForNavbarTitleViewWithFrame:CGRectMake(0, 0, 200.f, 44.f) dropdownItems:DTK];
    menuView.currentNav = self.navigationController;
    menuView.dropWidth = 150.f;
    menuView.titleColor=[UIColor blueColor];
    menuView.titleFont = [UIFont systemFontOfSize:18.f];
    menuView.textColor = [UIColor blueColor];;
    menuView.textFont = [UIFont systemFontOfSize:13.f];
    menuView.cellSeparatorColor =[UIColor blueColor];;
    menuView.textFont = [UIFont systemFontOfSize:14.f];
    menuView.animationDuration = 0.2f;
    NSString *sel=[[NSUserDefaults standardUserDefaults]objectForKey:@"plantNum"];
      NSInteger selected= [sel integerValue];
    if (sel==nil || sel==NULL||[sel isEqual:@""])
    {
       selected = 0;
    }
  
    if (selected>_stationID.count) {
        selected= 0;
    }
    menuView.selectedIndex = selected;
    self.navigationItem.titleView = menuView;
    NSString *plantid1=[[NSString alloc]initWithString:_stationID[selected]];
   // int plantid= [plantid1 intValue];
    //_plantId=[NSMutableDictionary dictionaryWithObject:[NSNumber numberWithInteger:plantid] forKey:@"plantId"];
    _plantId=[NSMutableDictionary dictionaryWithObject:plantid1 forKey:@"plantId"];
    NSString *a=@"1";
    NSString *b=@"6";
    //[_plantId setObject:[NSNumber numberWithInteger:a] forKey:@"pageNum"];
   // [_plantId setObject:[NSNumber numberWithInteger:b] forKey:@"pageSize"];
    [_plantId setObject:a forKey:@"pageNum"];
    [_plantId setObject:b forKey:@"pageSize"];
    [self netRequest];
}

-(void)netRequest{
    [self showProgressView];
    [BaseRequest requestWithMethodResponseJsonByGet:HEAD_URL paramars:_plantId paramarsSite:@"/questionAPI.do?op=getAllDeviceList" sucessBlock:^(id content) {
        [self hideProgressView];
          NSLog(@"getAllDeviceList:%@",content);
       // id jsonObj=[NSJSONSerialization JSONObjectWithData:content options:NSJSONReadingAllowFragments error:nil];
         self.dataArr = [NSMutableArray arrayWithArray:content];
        for (int i=0; i<_dataArr.count; i++) {
            [_typeArr addObject:content[i][@"deviceType"]];
            [nameArray addObject:content[i][@"deviceType"]];
          // [statueArray addObject:content[i][@"deviceStatus"]];
        NSString *ST=[NSString stringWithFormat:@"%@",content[i][@"deviceStatus"]];
            NSString *SD;
            if([ST isEqualToString:@"-1"])
            {
            SD=@"未连接";}else
            {
            SD=@"已连接";}
            [statueArray addObject:SD];
             NSString *DY=[NSString stringWithFormat:@"%@",content[i][@"energy"]];
            [dayArray addObject:DY];
             [imageArray addObject:@"4.gif"];
             [powerArray addObject:@"5000KW"];
        }
        for (int i=0; i<_typeArr.count; i++) {
            for (int j=0; j<nameArray2.count; j++)
            if([_typeArr[i] isEqualToString:nameArray2[j]])
            {
                [imageArray2 removeObjectAtIndex:j];
                [nameArray2 removeObjectAtIndex:j];
                [statueArray2 removeObjectAtIndex:j];
                [powerArray2 removeObjectAtIndex:j];
                 [dayArray2 removeObjectAtIndex:j];
            }
        }
        
         [self.tableView reloadData];
            
          //  [self showToastViewWithTitle:@"添加设备成功"];
        
    } failure:^(NSError *error) {
        [self hideProgressView];
        [self showToastViewWithTitle:root_Networking];
    }];

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
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return @"已配置设备";
    }
    else{
        return  @"未配置设备";
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
 
    TableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if([cell.titleLabel.text isEqualToString:@"inverter"]){
    secondViewController *sd=[[secondViewController alloc ]init];
    sd.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:sd animated:NO];}
    if([cell.titleLabel.text isEqualToString:@"storage"]){
        secondCNJ *sd=[[secondCNJ alloc ]init];
        sd.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:sd animated:NO];}
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section==0) {
        return imageArray.count;
    }
    else{
         return imageArray2.count;
    }
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section==0) {
    
   TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:_indenty forIndexPath:indexPath];
 //   cell.textLabel.text = [NSString stringWithFormat:@"Cell:%ld",indexPath.row];
    if (!cell) {
    cell=[[TableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:_indenty];
    }
   
   [cell.coverImageView  setImage:[UIImage imageNamed:imageArray[indexPath.row]]];
    cell.titleLabel.text = nameArray[indexPath.row];
        cell.titleLabel.textColor = [UIColor orangeColor];
       cell.stateValue.text = statueArray[indexPath.row];
     cell.powerValue.text = powerArray[indexPath.row];
     cell.electricValue.text =dayArray[indexPath.row];
 
        return cell;
    }
    else{
        TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:_indenty forIndexPath:indexPath];
        //   cell.textLabel.text = [NSString stringWithFormat:@"Cell:%ld",indexPath.row];
        if (!cell) {
            cell=[[TableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:_indenty];
        }
        
        [cell.coverImageView  setImage:[UIImage imageNamed:imageArray2[indexPath.row]]];
        cell.titleLabel.text = nameArray2[indexPath.row];
        cell.titleLabel.textColor = [UIColor grayColor];
        cell.stateValue.text = statueArray2[indexPath.row];
        cell.powerValue.text = powerArray2[indexPath.row];
        cell.electricValue.text =dayArray2[indexPath.row];
        return cell;
        
        }
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        //更新数据
        if(indexPath.section==0)
        {
        [imageArray removeObjectAtIndex:indexPath.row];
        [nameArray removeObjectAtIndex:indexPath.row];
        [statueArray removeObjectAtIndex:indexPath.row];
        [powerArray removeObjectAtIndex:indexPath.row];
        [dayArray removeObjectAtIndex:indexPath.row];
        }
        if(indexPath.section==1)
        {
            [imageArray2 removeObjectAtIndex:indexPath.row];
            [nameArray2 removeObjectAtIndex:indexPath.row];
            [statueArray2 removeObjectAtIndex:indexPath.row];
            [powerArray2 removeObjectAtIndex:indexPath.row];
            [dayArray2 removeObjectAtIndex:indexPath.row];
        }
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
        if(indexPath.section==0)
        {
            [imageArray removeObjectAtIndex:indexPath.row];
            [nameArray removeObjectAtIndex:indexPath.row];
            [statueArray removeObjectAtIndex:indexPath.row];
            [powerArray removeObjectAtIndex:indexPath.row];
            [dayArray removeObjectAtIndex:indexPath.row];
        }
        if(indexPath.section==1)
        {
            [imageArray2 removeObjectAtIndex:indexPath.row];
            [nameArray2 removeObjectAtIndex:indexPath.row];
            [statueArray2 removeObjectAtIndex:indexPath.row];
            [powerArray2 removeObjectAtIndex:indexPath.row];
            [dayArray2 removeObjectAtIndex:indexPath.row];
        }
        
        //2.更新UI
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:(UITableViewRowAnimationAutomatic)];
        
    }];
    //删除按钮颜色
    deleteAction.backgroundColor = [UIColor cyanColor];
    //添加一个置顶按钮
    UITableViewRowAction *topRowAction =[UITableViewRowAction rowActionWithStyle:(UITableViewRowActionStyleDestructive) title:@"置顶 "handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        NSLog(@"点击了置顶");
        //1.更新数据
        if(indexPath.section==0){
        [imageArray exchangeObjectAtIndex:indexPath.row withObjectAtIndex:0];
        [nameArray exchangeObjectAtIndex:indexPath.row withObjectAtIndex:0];
        [statueArray exchangeObjectAtIndex:indexPath.row withObjectAtIndex:0];
        [powerArray exchangeObjectAtIndex:indexPath.row withObjectAtIndex:0];
            [dayArray exchangeObjectAtIndex:indexPath.row withObjectAtIndex:0];}
        if(indexPath.section==1){
            [imageArray2 exchangeObjectAtIndex:indexPath.row withObjectAtIndex:0];
            [nameArray2 exchangeObjectAtIndex:indexPath.row withObjectAtIndex:0];
            [statueArray2 exchangeObjectAtIndex:indexPath.row withObjectAtIndex:0];
            [powerArray2 exchangeObjectAtIndex:indexPath.row withObjectAtIndex:0];
            [dayArray2 exchangeObjectAtIndex:indexPath.row withObjectAtIndex:0];}
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
