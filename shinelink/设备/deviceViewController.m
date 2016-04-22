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
#import "aliasViewController.h"
#import "DemoDevice.h"
#import "GetDevice.h"

#define ColorWithRGB(r,g,b) [UIColor colorWithRed:r/255. green:g/255. blue:b/255. alpha:1]

@interface deviceViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,EditStationMenuViewDelegate,UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITabBarControllerDelegate>

@property (nonatomic, strong) NSIndexPath *indexPath;
@property(nonatomic,strong)EditStationMenuView  *editCellect;
@property (nonatomic, strong) UIActionSheet *uploadImageActionSheet;
@property (nonatomic, strong) UIImagePickerController *cameraImagePicker;
@property (nonatomic, strong) UIImagePickerController *photoLibraryImagePicker;

@property (nonatomic, strong) NSMutableArray *stationID;
@property (nonatomic, strong) NSMutableArray *stationName;
@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, strong) NSMutableArray *typeArr;
@property (nonatomic, strong) NSMutableDictionary *plantId;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableDictionary *dataDic;
@property (nonatomic, strong) CoreDataManager *manager;
@property (nonatomic, strong) NSMutableArray *managerArray;
@property (nonatomic, strong) NSMutableArray *managerNowArray;
@property (nonatomic, strong) DemoDevice *demoDevice;
@property (nonatomic, strong) GetDevice *getDevice;
@property (nonatomic, strong) UIRefreshControl *control;
@property (nonatomic, strong) NSString *netType;
@property (nonatomic, strong) NSString *stationIdOne;
@property (nonatomic, strong) NSString *headPicName;
@property (nonatomic, strong) NSString *headAdress;
@property (nonatomic, strong) NSString *headWether;
@property (nonatomic, strong) NSString *headDate;
@property (nonatomic, strong) NSString *headWeek;
@property (nonatomic, strong) NSString *headUse;
@property (nonatomic, strong) NSString *headGet;
@property (nonatomic, strong) NSString *headT;
@property (nonatomic, strong) NSString *headT1;
@property (nonatomic, strong) NSString *headT2;
@property (nonatomic, strong)UIView *headerView;
@end

@implementation deviceViewController
{   //服务器设备属性
     NSMutableArray* imageArray;
     NSMutableArray *nameArray;
     NSMutableArray *statueArray;
    NSMutableArray *powerArray;
    NSMutableArray *dayArray;
     NSMutableArray *SNArray;
    NSMutableArray *totalPowerArray;
    //DEMO设备属性
     NSMutableArray* imageArray2;
     NSMutableArray *nameArray2;
     NSMutableArray *statueArray2;
     NSMutableArray *powerArray2;
     NSMutableArray *dayArray2;
    UIPageControl *_pageControl;
    UIScrollView *_scrollerView;
    NSString *_indenty;
    
       NSMutableArray* imageStatueArray;
    //全局变量 用来控制偏移量
    NSInteger pageName;
    //coredata
   
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
-(void)viewDidAppear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(viewDidLoad) name:@"changeName" object:nil];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
  [self.navigationController.navigationBar setTranslucent:YES];
    [self.navigationController.navigationBar setBarTintColor:COLOR(17, 183, 243, 1)];
 
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd  target:self action:@selector(selectRightAction)];
    self.navigationItem.rightBarButtonItem = rightButton;
    _manager=[CoreDataManager sharedCoreDataManager];
    _managerArray=[NSMutableArray array];
    _managerNowArray=[NSMutableArray array];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(initDemoData) name:@"reroadDemo" object:nil];
  
    
    [self initData];
       [self addTitleMenu];
    [self addRightItem];
    //创建tableView的方法
    [self _createTableView];
    //创建tableView的头视图
  //  [self _createHeaderView];
    [self netWeather];
}



#pragma mark - CoreData
-(void)initDatacore{
   
      BOOL firstRun = !_manager.hasStore;
    if (firstRun){
        [self initDemoData];}
    else{[self request];}
}

-(void)initDemoData{
  
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    //    设置要检索哪种类型的实体对象
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"DemoDevice" inManagedObjectContext:_manager.managedObjContext];
    //    设置请求实体
    [request setEntity:entity];
    
    //    指定对结果的排序方式
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:NO];
    NSArray *sortDescriptions = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    [request setSortDescriptors:sortDescriptions];
    
    NSError *error = nil;
    //    执行获取数据请求，返回数组
    NSArray *fetchResult = [_manager.managedObjContext executeFetchRequest:request error:&error];
    for (NSManagedObject *obj in fetchResult)
    {
        [_manager.managedObjContext deleteObject:obj];
    }       
    
    for(int i=0;i<imageArray2.count;i++)
    {
       _demoDevice=[NSEntityDescription insertNewObjectForEntityForName:@"DemoDevice" inManagedObjectContext:[CoreDataManager sharedCoreDataManager].managedObjContext];
        
        _demoDevice.name=nameArray2[i];
        _demoDevice.power=powerArray2[i];
        _demoDevice.dayPower=dayArray2[i];
        _demoDevice.statueData=statueArray2[i];
        UIImage *image=IMAGE(imageArray2[i]);
        NSData *imagedata=UIImageJPEGRepresentation(image, 0.5);
        _demoDevice.image=imagedata;
    }
    
    BOOL isSaveSuccess = [[CoreDataManager sharedCoreDataManager].managedObjContext save:&error];
    if (!isSaveSuccess) {
        NSLog(@"Error: %@,%@",error,[error userInfo]);
    }else
    {
        NSLog(@"Save successFull");
    }
    [self request];
}

-(void)request{
    //    创建取回数据请求
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    //    设置要检索哪种类型的实体对象
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"DemoDevice" inManagedObjectContext:_manager.managedObjContext];
    //    设置请求实体
    [request setEntity:entity];
    
    //    指定对结果的排序方式
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:NO];
    NSArray *sortDescriptions = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    [request setSortDescriptors:sortDescriptions];
    
    NSError *error = nil;
    //    执行获取数据请求，返回数组
    NSArray *fetchResult = [_manager.managedObjContext executeFetchRequest:request error:&error];
    if (!fetchResult)
    {
        NSLog(@"error:%@,%@",error,[error userInfo]);
    }
    [self.managerArray removeAllObjects];
    [self.managerArray addObjectsFromArray:fetchResult];
}

-(void)initData{
    _typeArr=[NSMutableArray array];
    nameArray=[NSMutableArray array];
    statueArray=[NSMutableArray array];
    dayArray=[NSMutableArray array];
    imageArray=[NSMutableArray array];
    powerArray=[NSMutableArray array];
    totalPowerArray=[NSMutableArray array];
    SNArray=[NSMutableArray array];
    imageStatueArray=[NSMutableArray array];
    imageArray2=[[NSMutableArray alloc]initWithObjects:@"inverter.png", @"储能机.png", @"Plug.png", @"PowerRegulator.png",@"TemperatureController.png",@"充电桩.png",nil];
    nameArray2=[[NSMutableArray alloc]initWithObjects:@"inverter", @"storage", @"Plug", @"Regulator",@"controller", @"charge",  nil];
    statueArray2=[[NSMutableArray alloc]initWithObjects:@"未连接", @"未连接", @"未连接", @"未连接",@"未连接",@"未连接",nil];
    powerArray2=[[NSMutableArray alloc]initWithObjects:@"5000KW", @"5000KW", @"5000KW",@"5000KW", @"5000KW", @"5000KW",  nil];
    dayArray2=[[NSMutableArray alloc]initWithObjects:@"500K/h", @"500K/h", @"500K/h", @"500K/h",@"500K/h",@"500K/h",nil];
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
        StationCellectViewController *goLog=[[StationCellectViewController alloc]init];
        goLog.stationId=_stationIdOne;
        [self.navigationController pushViewController:goLog animated:NO];
    }];
    DTKDropdownMenuView *menuView = [DTKDropdownMenuView dropdownMenuViewWithType:dropDownTypeRightItem frame:CGRectMake(0, 0, 44.f, 44.f) dropdownItems:@[item0,item1] icon:@"add@2x.png"];
    
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
        NSLog(@"电站%lu",(unsigned long)index);
        [ [UserInfo defaultUserInfo]setPlantID:_stationID[index]];
        [ [UserInfo defaultUserInfo]setPlantNum:[NSString stringWithFormat:@"%lu",(unsigned long)index]];
        [_plantId setObject:_stationID[index] forKey:@"plantId"];
        [self refreshData];
        
    }];
         [DTK addObject:DTKname];
    }
  
    DTKDropdownMenuView *menuView = [DTKDropdownMenuView dropdownMenuViewForNavbarTitleViewWithFrame:CGRectMake(0, 0, 200.f, 44.f) dropdownItems:DTK];
    menuView.currentNav = self.navigationController;
    menuView.dropWidth = 150.f;
    menuView.titleColor=[UIColor whiteColor];
    menuView.titleFont = [UIFont systemFontOfSize:18.f];
    menuView.textColor =COLOR(17, 183, 243, 1);
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
    _stationIdOne=[NSString stringWithString:plantid1];
   // int plantid= [plantid1 intValue];
    //_plantId=[NSMutableDictionary dictionaryWithObject:[NSNumber numberWithInteger:plantid] forKey:@"plantId"];
    _plantId=[NSMutableDictionary dictionaryWithObject:plantid1 forKey:@"plantId"];
    NSString *a=@"1";
    NSString *b=@"15";

    [_plantId setObject:a forKey:@"pageNum"];
    [_plantId setObject:b forKey:@"pageSize"];
    
    //没有网络的功能测试开关
    BOOL netOk=1;
    if(netOk==1){
        [self netRequest];
    }
    else{
         [self initDemoData];
        }
}

-(void)refreshData{
   
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"GetDevice" inManagedObjectContext:_manager.managedObjContext];
    [request setEntity:entity];
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"deviceSN" ascending:NO];
    NSArray *sortDescriptions = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    [request setSortDescriptors:sortDescriptions];
    NSError *error = nil;
    NSArray *fetchResult = [_manager.managedObjContext executeFetchRequest:request error:&error];
    for (NSManagedObject *obj in fetchResult)
    {
        [_manager.managedObjContext deleteObject:obj];
    }
    BOOL isSaveSuccess = [_manager.managedObjContext save:&error];
    if (!isSaveSuccess) {
        NSLog(@"Error: %@,%@",error,[error userInfo]);
    }else
    {
        NSLog(@"Save successFull");
    }
    
  
    
    [self netRequest];


}


-(void)netRequest{
    [self showProgressView];
    [BaseRequest requestWithMethodResponseJsonByGet:HEAD_URL paramars:_plantId paramarsSite:@"/newPlantAPI.do?op=getAllDeviceList" sucessBlock:^(id content) {
        [self hideProgressView];
        
        _typeArr=[NSMutableArray array];
        nameArray=[NSMutableArray array];
        statueArray=[NSMutableArray array];
        dayArray=[NSMutableArray array];
        imageArray=[NSMutableArray array];
        powerArray=[NSMutableArray array];
        SNArray=[NSMutableArray array];
        imageStatueArray=[NSMutableArray array];
        
        [_control endRefreshing];
          NSLog(@"getAllDeviceList:%@",content);
       // id jsonObj=[NSJSONSerialization JSONObjectWithData:content options:NSJSONReadingAllowFragments error:nil];
         self.dataArr = [NSMutableArray arrayWithArray:content];
        for (int i=0; i<_dataArr.count; i++) {
            [_typeArr addObject:content[i][@"deviceType"]];
            [SNArray addObject:content[i][@"deviceSn"]];
            if ([content[i][@"deviceAilas"]isEqualToString:@""]) {
                [nameArray addObject:content[i][@"deviceType"]];
            }else{
                [nameArray addObject:content[i][@"deviceAilas"]];}
           
            NSString *TO=[NSString stringWithFormat:@"%@",content[i][@"energy"]];
            [totalPowerArray addObject:TO];
            
        NSString *ST=[NSString stringWithFormat:@"%@",content[i][@"deviceStatus"]];
            NSString *SD;
            if([ST isEqualToString:@"-1"])
            {SD=@"未连接";
                [imageStatueArray addObject:@"disconnect@2x.png"];}
            else{SD=@"已连接";[imageStatueArray addObject:@"connected@2x.png"];}
            [statueArray addObject:SD];
           
            
            if ([content[i][@"deviceType"]isEqualToString:@"inverter"]) {
                 [imageArray addObject:@"inverter.png"];
                NSString *PO=[NSString stringWithFormat:@"%@",content[i][@"power"]];
                [powerArray addObject:PO];
                NSString *DY=[NSString stringWithFormat:@"%@",content[i][@"eToday"]];
                [dayArray addObject:DY];
            }else if ([content[i][@"deviceType"]isEqualToString:@"storage"]){
             [imageArray addObject:@"storage.png"];
                NSString *PO=[NSString stringWithFormat:@"%@",content[i][@"pCharge"]];
                [powerArray addObject:PO];
                NSString *DY=[NSString stringWithFormat:@"%@",content[i][@"capacity"]];
                [dayArray addObject:DY];
            }else{
            [imageArray addObject:@"Plug.png"];
            }
            
        }
        
        NSFetchRequest *request = [[NSFetchRequest alloc] init];
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"GetDevice" inManagedObjectContext:_manager.managedObjContext];
        [request setEntity:entity];
        NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"deviceSN" ascending:NO];
        NSArray *sortDescriptions = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
        [request setSortDescriptors:sortDescriptions];
        NSError *error = nil;
        NSArray *fetchResult = [_manager.managedObjContext executeFetchRequest:request error:&error];
        NSMutableArray *SN=[NSMutableArray array];
        for (NSManagedObject *obj in fetchResult)
        {
            GetDevice *get=obj;
            [SN addObject:get.deviceSN];
        }
       
        for(int i=0;i<SNArray.count;i++)
        {
            if (fetchResult.count==0) {
                _getDevice=[NSEntityDescription insertNewObjectForEntityForName:@"GetDevice" inManagedObjectContext:[CoreDataManager sharedCoreDataManager].managedObjContext];
                _getDevice.name=nameArray[i];
                _getDevice.power=powerArray[i];
                _getDevice.dayPower=dayArray[i];
                _getDevice.statueData=statueArray[i];
                _getDevice.deviceSN=SNArray[i];
                _getDevice.type=_typeArr[i];
                _getDevice.totalPower=totalPowerArray[i];
                UIImage *image=IMAGE(imageArray[i]);
                NSData *imagedata=UIImageJPEGRepresentation(image, 0.5);
                _getDevice.demoImage=imagedata;
                _getDevice.statueImage=UIImageJPEGRepresentation(IMAGE(imageStatueArray[i]), 0.5);
   
            }else{
                
                if (![SN containsObject:SNArray[i]]) {
                    _getDevice=[NSEntityDescription insertNewObjectForEntityForName:@"GetDevice" inManagedObjectContext:[CoreDataManager sharedCoreDataManager].managedObjContext];
                    _getDevice.name=nameArray[i];
                     _getDevice.type=_typeArr[i];
                    _getDevice.power=powerArray[i];
                    _getDevice.dayPower=dayArray[i];
                    _getDevice.statueData=statueArray[i];
                    _getDevice.deviceSN=SNArray[i];
                      _getDevice.totalPower=totalPowerArray[i];
                    UIImage *image=IMAGE(imageArray[i]);
                    NSData *imagedata=UIImageJPEGRepresentation(image, 0.5);
                    _getDevice.demoImage=imagedata;
                    _getDevice.statueImage=UIImageJPEGRepresentation(IMAGE(imageStatueArray[i]), 0.5);

                }
        }
    }
        BOOL isSaveSuccess = [_manager.managedObjContext save:&error];
        if (!isSaveSuccess) {
            NSLog(@"Error: %@,%@",error,[error userInfo]);
        }else
        {
            NSLog(@"Save successFull");
        }

           NSArray *fetchResult1 = [_manager.managedObjContext executeFetchRequest:request error:&error];
        [self.managerNowArray removeAllObjects];
        [self.managerNowArray addObjectsFromArray:fetchResult1];
        
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
         [self initDatacore];
         [self.tableView reloadData];
            
          //  [self showToastViewWithTitle:@"添加设备成功"];
        
    } failure:^(NSError *error) {
        [self hideProgressView];
         [_control endRefreshing];
        [self showToastViewWithTitle:root_Networking];
    }];

}



#pragma mark 创建tableView的方法
- (void)_createTableView {
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    _control=[[UIRefreshControl alloc]init];
    [_control addTarget:self action:@selector(refreshStateChange:) forControlEvents:UIControlEventValueChanged];
    [_tableView addSubview:_control];
    
    //2.马上进入刷新状态，并不会触发UIControlEventValueChanged事件
    [_control beginRefreshing];
    
    // 3.加载数据
    [self refreshStateChange:_control];
    
    [self.view addSubview:_tableView];
    _indenty = @"indenty";
    //注册单元格类型
    [_tableView registerClass:[TableViewCell class] forCellReuseIdentifier:_indenty];
}

-(void)refreshStateChange:(UIRefreshControl *)control{

    //NSUserDefaults *ud=[NSUserDefaults standardUserDefaults];
   // _plantId=[ud objectForKey:@"plantID"];
    
    [self refreshData];
    
}

-(void)netWeather{
    _headerView = [[UIView alloc] initWithFrame:CGRectMake(0,0,Kwidth,200*NOW_SIZE)];
    UIColor *bgColor = [UIColor colorWithPatternImage: [UIImage imageNamed:@"overcast@2x.png"]];
                        _headerView.backgroundColor=bgColor;
    _tableView.tableHeaderView = _headerView;
    
//    [BaseRequest requestWithMethodResponseJsonByGet:HEAD_URL paramars:@{@"":@""} paramarsSite:@"/newTheWeatherAPI.do?op= getTheWeather" sucessBlock:^(id content) {
//        NSLog(@"Weather: %@", content);
//        [self hideProgressView];
//        
//        if (content) {
//            
//            [self _createHeaderView];
//        }
//        
//    } failure:^(NSError *error) {
//        [self hideProgressView];
//    }];
     [self _createHeaderView];
}

- (void)_createHeaderView {
    
   
    float headHeight=_headerView.bounds.size.height;
    _headPicName=@"bgweather@3x.png";
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,Kwidth,headHeight)];
    imageView.image = [UIImage imageNamed:_headPicName];
    [_headerView addSubview:imageView];
    
    UIImageView *imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake((Kwidth-Kwidth*1/4)/2,headHeight*1/4,Kwidth*1/4,headHeight*1/3)];
    imageView1.image = [UIImage imageNamed:@"fog2@3x.png"];
       [_headerView addSubview:imageView1];
    
    _headAdress=@"深圳";
    UILabel *Lable1=[[UILabel alloc]initWithFrame:CGRectMake((Kwidth-160*NOW_SIZE)/2, 10*NOW_SIZE, 160*NOW_SIZE,20*NOW_SIZE )];
    Lable1.text=_headAdress;
    Lable1.textAlignment=NSTextAlignmentCenter;
    Lable1.textColor=[UIColor whiteColor];
    Lable1.font = [UIFont systemFontOfSize:18*NOW_SIZE];
    [_headerView addSubview:Lable1];
    
    _headWether=@"阴";
    UILabel *Lable2=[[UILabel alloc]initWithFrame:CGRectMake((Kwidth-160*NOW_SIZE)/2, 30*NOW_SIZE, 160*NOW_SIZE,20*NOW_SIZE )];
    Lable2.text=_headWether;
    Lable2.textAlignment=NSTextAlignmentCenter;
    Lable2.textColor=[UIColor whiteColor];
    Lable2.font = [UIFont systemFontOfSize:12*NOW_SIZE];
    [_headerView addSubview:Lable2];

   _headT =@"12º";
    UILabel *Lable3=[[UILabel alloc]initWithFrame:CGRectMake((Kwidth-160*NOW_SIZE)/2, headHeight*1/4+15*NOW_SIZE, 160*NOW_SIZE,20*NOW_SIZE )];
    Lable3.text=_headT;
    Lable3.textAlignment=NSTextAlignmentCenter;
    Lable3.textColor=[UIColor whiteColor];
    Lable3.font = [UIFont systemFontOfSize:18*NOW_SIZE];
    [_headerView addSubview:Lable3];
    
    
    _headDate =@"2016-03-31";
    UILabel *Lable4=[[UILabel alloc]initWithFrame:CGRectMake(Kwidth/2-120*NOW_SIZE, headHeight*1/4+headHeight*1/3+10*NOW_SIZE, 130*NOW_SIZE,20*NOW_SIZE )];
    Lable4.text=_headDate;
    Lable4.textAlignment=NSTextAlignmentRight;
    Lable4.textColor=[UIColor whiteColor];
    Lable4.font = [UIFont systemFontOfSize:12*NOW_SIZE];
    [_headerView addSubview:Lable4];
    
    _headWeek =@"星期三";
    UILabel *Lable5=[[UILabel alloc]initWithFrame:CGRectMake((Kwidth-0*NOW_SIZE)/2+20*NOW_SIZE, headHeight*1/4+headHeight*1/3+10*NOW_SIZE, 110*NOW_SIZE,20*NOW_SIZE )];
    Lable5.text=_headWeek;
    Lable5.textAlignment=NSTextAlignmentLeft;
    Lable5.textColor=[UIColor whiteColor];
    Lable5.font = [UIFont systemFontOfSize:12*NOW_SIZE];
    [_headerView addSubview:Lable5];
    
    _headT1=@"8º";_headT2=@"18º";
    NSString *T3=[NSString stringWithFormat:@"%@~%@",_headT1,_headT2];
    UILabel *Lable6=[[UILabel alloc]initWithFrame:CGRectMake((Kwidth-120*NOW_SIZE)/2, headHeight*1/4+headHeight*1/3+30*NOW_SIZE, 120*NOW_SIZE,20*NOW_SIZE )];
    Lable6.text=T3;
    Lable6.textAlignment=NSTextAlignmentCenter;
    Lable6.textColor=[UIColor whiteColor];
    Lable6.font = [UIFont systemFontOfSize:12*NOW_SIZE];
    [_headerView addSubview:Lable6];
    
 _headUse=@"30KW";
    UILabel *Lable7=[[UILabel alloc]initWithFrame:CGRectMake(30*NOW_SIZE, headHeight*1/4+headHeight*1/3+30*NOW_SIZE, 120*NOW_SIZE,30*NOW_SIZE )];
    Lable7.text=_headUse;
    Lable7.textAlignment=NSTextAlignmentLeft;
    Lable7.textColor=[UIColor whiteColor];
    Lable7.font = [UIFont systemFontOfSize:20*NOW_SIZE];
    [_headerView addSubview:Lable7];
    
 
    UILabel *Lable9=[[UILabel alloc]initWithFrame:CGRectMake(20*NOW_SIZE, headHeight*1/4+headHeight*1/3+55*NOW_SIZE, 120*NOW_SIZE,20*NOW_SIZE )];
    Lable9.text=@"今日用电量";
    Lable9.textAlignment=NSTextAlignmentLeft;
    Lable9.textColor=[UIColor whiteColor];
    Lable9.font = [UIFont systemFontOfSize:14*NOW_SIZE];
    [_headerView addSubview:Lable9];
    
    _headGet=@"30KW";
    UILabel *Lable8=[[UILabel alloc]initWithFrame:CGRectMake(Kwidth-150*NOW_SIZE, headHeight*1/4+headHeight*1/3+30*NOW_SIZE, 120*NOW_SIZE,30*NOW_SIZE )];
    Lable8.text=_headUse;
    Lable8.textAlignment=NSTextAlignmentRight;
    Lable8.textColor=[UIColor whiteColor];
    Lable8.font = [UIFont systemFontOfSize:20*NOW_SIZE];
    [_headerView addSubview:Lable8];
    
    UILabel *Lable10=[[UILabel alloc]initWithFrame:CGRectMake(Kwidth-140*NOW_SIZE, headHeight*1/4+headHeight*1/3+55*NOW_SIZE, 120*NOW_SIZE,20*NOW_SIZE )];
    Lable10.text=@"今日发电量";
    Lable10.textAlignment=NSTextAlignmentRight;
    Lable10.textColor=[UIColor whiteColor];
    Lable10.font = [UIFont systemFontOfSize:14*NOW_SIZE];
    [_headerView addSubview:Lable10];
    
}

#pragma mark - EditCellectViewDelegate
- (void)menuDidSelectAtRow:(NSInteger)row {
    
    GetDevice *getDevice=[_managerNowArray objectAtIndex:_indexPath.row];
    
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"isDemo"] isEqualToString:@"isDemo"]) {
        [_editCellect removeFromSuperview];
        [self showAlertViewWithTitle:nil message:NSLocalizedString(@"Browse user prohibited operation", @"Browse user prohibited operation") cancelButtonTitle:root_Yes];
        return;
    }
    if (row==0) {
        //取消菜单
        [_editCellect removeFromSuperview];
        return;
    }
    if (row==1) {
        [_editCellect removeFromSuperview];
        aliasViewController *alias=[[aliasViewController alloc]init];
        alias.deviceSN=getDevice.deviceSN;
        if ([getDevice.type isEqualToString:@"inverter"]) {
            alias.netType=@"/newInverterAPI.do?op=updateInvInfo";
            alias.deviceSnKey=@"inverterId";
        }else if ([getDevice.type isEqualToString:@"storage"]){
        alias.deviceSnKey=@"storageId";
         alias.netType=@"/newStorageAPI.do?op=updateStorageInfo";
        }
        [self.navigationController pushViewController:alias animated:YES];
    }
    if (row==2) {
        [_editCellect removeFromSuperview];
        _dataDic=[NSMutableDictionary dictionaryWithObject:@"" forKey:@"alias"];
        if ([getDevice.type isEqualToString:@"inverter"]) {
               [_dataDic setObject:getDevice.deviceSN forKey:@"inverterId"];
            _netType=@"/newInverterAPI.do?op=updateInvInfo";
            
        }else if ([getDevice.type isEqualToString:@"storage"]){
             [_dataDic setObject:getDevice.deviceSN forKey:@"storageId"];
     
           _netType=@"/newStorageAPI.do?op=updateStorageInfo";
        }
        [_dataDic setObject:SNArray[_indexPath.row] forKey:@"inverterId"];
        
        [self addPicture];
    }
    if (row==3) {
        [_editCellect removeFromSuperview];
        [self showProgressView];
        NSMutableDictionary *dict=[NSMutableDictionary dictionary];
        NSString *netType;
        GetDevice *get=[_managerNowArray objectAtIndex:_indexPath.row];
        if ([getDevice.type isEqualToString:@"inverter"]) {
            [dict setObject:getDevice.deviceSN forKey:@"inverterId"];
            netType=@"/newInverterAPI.do?op=deleteInverter";
            
        }else if ([getDevice.type isEqualToString:@"storage"]){
            [dict setObject:getDevice.deviceSN forKey:@"storageId"];
            
            netType=@"/newStorageAPI.do?op=deleteStorage";
        }

          [dict setObject:get.deviceSN forKey:@"inverterId"];
        
        [BaseRequest requestWithMethodResponseStringResult:HEAD_URL paramars:dict paramarsSite:netType sucessBlock:^(id content) {
            //NSString *res = [[NSString alloc] initWithData:content encoding:NSUTF8StringEncoding];
            NSLog(@"updateInvInfo: %@", content);
            [self hideProgressView];
            id  content1= [NSJSONSerialization JSONObjectWithData:content options:NSJSONReadingAllowFragments error:nil];
            if (content1) {
                if ([content1[@"success"] integerValue] == 0) {
                    if ([content1[@"msg"] integerValue] ==501) {
                        [self showAlertViewWithTitle:nil message:@"系统错误" cancelButtonTitle:root_Yes];
                         //[self.tableView reloadData];
                    }
                }else{
                    [self showAlertViewWithTitle:nil message:@"删除成功" cancelButtonTitle:root_Yes];
                    [[CoreDataManager sharedCoreDataManager].managedObjContext deleteObject:get];
                    NSError *error = nil;
                    BOOL isSaveSuccess = [[CoreDataManager sharedCoreDataManager].managedObjContext save:&error];
                    if (!isSaveSuccess) {
                        NSLog(@"Error: %@,%@",error,[error userInfo]);
                    }else
                    {
                        NSLog(@"del successFull");
                        [self netRequest];
                    }
                }
            }
        } failure:^(NSError *error) {
            [self showToastViewWithTitle:root_Networking];
        }];
    }
}

-(void)addPicture{
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

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    UIImage *image = info[@"UIImagePickerControllerEditedImage"];
    NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
    NSMutableDictionary *dataImageDict = [NSMutableDictionary dictionary];
    [dataImageDict setObject:imageData forKey:@"image"];
   
    
    [BaseRequest uplodImageWithMethod:HEAD_URL paramars:_dataDic paramarsSite:_netType dataImageDict:dataImageDict sucessBlock:^(id content) {
      
        id  content1= [NSJSONSerialization JSONObjectWithData:content options:NSJSONReadingAllowFragments error:nil];
          NSLog(@"updateInvInfo: %@", content1);
        if (content1) {
            if ([content1[@"success"] integerValue] == 0) {
                if ([content1[@"msg"] integerValue] ==501) {
                    [self showAlertViewWithTitle:nil message:@"系统错误" cancelButtonTitle:root_Yes];
                }
            }else{
                
                [self showAlertViewWithTitle:nil message:@"修改成功" cancelButtonTitle:root_Yes];
            
                GetDevice *getDevice=[_managerNowArray objectAtIndex:_indexPath.row];
                [getDevice setValue:imageData forKey:@"nowImage"];
                NSError *error;
                BOOL isSaveSuccess = [[CoreDataManager sharedCoreDataManager].managedObjContext save:&error];
                if (!isSaveSuccess) {
                    NSLog(@"Error: %@,%@",error,[error userInfo]);
                }else
                {
                    NSLog(@"Save successFull");
                }
                [self.tableView reloadData];
                
            }
        }
    } failure:^(NSError *error) {
        [self showToastViewWithTitle:root_Networking];
    }];
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
 
    //TableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if(indexPath.section==0){
        GetDevice *getDevice=[_managerNowArray objectAtIndex:indexPath.row];
    if([getDevice.type isEqualToString:@"inverter"])
    {
    secondViewController *sd=[[secondViewController alloc ]init];
        sd.dayData=getDevice.dayPower;
        sd.totalData=getDevice.totalPower;
        sd.powerData=getDevice.power;
        sd.SnData=getDevice.deviceSN;
               sd.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:sd animated:NO];
    }
    else if([getDevice.type  isEqualToString:@"storage"]){
        secondCNJ *sd=[[secondCNJ alloc ]init];
        sd.deviceSN=getDevice.deviceSN;
        sd.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:sd animated:NO];}}
    else{
         DemoDevice *demoDevice=[_managerArray objectAtIndex:indexPath.row];
       if([demoDevice.name isEqualToString:@"inverter"]){
            secondViewController *sd=[[secondViewController alloc ]init];
            sd.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:sd animated:NO];}
        else if([demoDevice.name  isEqualToString:@"storage"]){
            secondCNJ *sd=[[secondCNJ alloc ]init];
            sd.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:sd animated:NO];}
    
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section==0) {
        return _managerNowArray.count;
    }
    else{
         return _managerArray.count;
    }
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section==0) {
   TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:_indenty forIndexPath:indexPath];
 //   cell.textLabel.text = [NSString stringWithFormat:@"Cell:%ld",indexPath.row];
    if (!cell) {
    cell=[[TableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:_indenty];
    }
   
        GetDevice *getDevice=[_managerNowArray objectAtIndex:indexPath.row];
        if (getDevice.nowImage) {
            [cell.coverImageView  setImage:[UIImage imageWithData:getDevice.nowImage]];
        }else{
            [cell.coverImageView  setImage:[UIImage imageWithData:getDevice.demoImage]];}
      
        if ([getDevice.type isEqualToString:@"inverter"]) {
            cell.electric.text = @"日电量:";
        }else if (([getDevice.type isEqualToString:@"storage"])){
         cell.electric.text = @"电池百分比:";
        }
            cell.titleLabel.text = getDevice.name;
        cell.titleLabel.textColor = [UIColor orangeColor];
       cell.stateValue.text = getDevice.statueData;
     cell.powerValue.text = getDevice.power;
     cell.electricValue.text =getDevice.dayPower;
       [cell.stateView setImage:[UIImage imageWithData:getDevice.statueImage] ];
        return cell;
    }
    else{
        TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:_indenty forIndexPath:indexPath];
        //   cell.textLabel.text = [NSString stringWithFormat:@"Cell:%ld",indexPath.row];
        if (!cell) {
            cell=[[TableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:_indenty];
        }
        DemoDevice *demoDevice=[_managerArray objectAtIndex:indexPath.row];
        [cell.coverImageView  setImage:[UIImage imageWithData:demoDevice.image]];
        cell.titleLabel.text = demoDevice.name;
        cell.titleLabel.textColor = [UIColor grayColor];
        cell.powerValue.text = demoDevice.power;
        cell.electricValue.text =demoDevice.dayPower;
        cell.stateView.image =IMAGE(@"disconnect@2x.png");
        cell.stateValue.text=demoDevice.statueData;
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
        }
        if(indexPath.section==1)
        {
            DemoDevice *demoDevice=[_managerArray objectAtIndex:indexPath.row];
         [[CoreDataManager sharedCoreDataManager].managedObjContext deleteObject:demoDevice];
            NSError *error = nil;
            
            //    托管对象准备好后，调用托管对象上下文的save方法将数据写入数据库
            BOOL isSaveSuccess = [[CoreDataManager sharedCoreDataManager].managedObjContext save:&error];
            if (!isSaveSuccess) {
                NSLog(@"Error: %@,%@",error,[error userInfo]);
            }else
            {
                NSLog(@"del successFull");
            }
           [self request];
        }
        //更新UI
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
    }else if (editingStyle == UITableViewCellEditingStyleInsert) {
        
    }
}

- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section==0){
    //添加一个编辑按钮
    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:(UITableViewRowActionStyleNormal) title:@"编辑 "handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        NSLog(@"点击了编辑");
        _indexPath=indexPath;
        _editCellect = [[EditStationMenuView alloc] initWithFrame:self.view.bounds];
        _editCellect.delegate = self;
        _editCellect.tintColor = [UIColor blackColor];
        _editCellect.dynamic = NO;
        _editCellect.blurRadius = 10.0f;
        [[UIApplication sharedApplication].keyWindow addSubview:_editCellect];
    }];
    deleteAction.backgroundColor = [UIColor redColor];
    
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
   
        //2.更新UI
        NSIndexPath *firstIndexPath =[NSIndexPath indexPathForRow:0 inSection:indexPath.section];
        [tableView moveRowAtIndexPath:indexPath toIndexPath:firstIndexPath];
    }];
    
    //置顶按钮颜色
    topRowAction.backgroundColor =COLOR(99, 209, 249, 1);
    
        return @[deleteAction,topRowAction];}else return nil;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
        return 65*NOW_SIZE;
    }
    


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
