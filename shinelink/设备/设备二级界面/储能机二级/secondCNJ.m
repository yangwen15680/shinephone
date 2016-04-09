//
//  secondCNJ.m
//  shinelink
//
//  Created by sky on 16/3/15.
//  Copyright © 2016年 sky. All rights reserved.
//

#import "secondCNJ.h"
#import"DTKDropdownMenuView.h"
#import "Line2View.h"
#import "threeViewController.h"
#import"VWWWaterView.h"
#import "ControlCNJ.h"
#import "parameterCNJ.h"
#import "PvLogTableViewController.h"

#define ColorWithRGB(r,g,b) [UIColor colorWithRed:r/255. green:g/255. blue:b/255. alpha:1]
@interface secondCNJ ()
@property (nonatomic, strong) NSMutableDictionary *dayDict;
@property (nonatomic, strong) Line2View *line2View;
@end

@implementation secondCNJ

- (void)viewDidLoad {
    [super viewDidLoad];
   //UIImage *bgImage = IMAGE(@"bg.png");
    //self.view.layer.contents = (id)bgImage.CGImage;
    // UIView *lineView=[[UIView alloc]initWithFrame:CGRectMake(0, 200*NOW_SIZE, SCREEN_Width,320*NOW_SIZE )];
    //[self.view addSubview:lineView];
    [self addProcess];
    [self addRightItem];
    [self addGraph];
    [self addbutton];
    
}

-(void)addbutton{
    UIButton *firstB=[[UIButton alloc]initWithFrame:CGRectMake(24*NOW_SIZE, 490*NOW_SIZE, 50*NOW_SIZE,50*NOW_SIZE )];
    [firstB setImage:[UIImage imageNamed:@"控制.jpg"] forState:UIControlStateNormal];
    [firstB addTarget:self action:@selector(controlCNJ) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:firstB];
    UILabel *firstL=[[UILabel alloc]initWithFrame:CGRectMake(24*NOW_SIZE, 540*NOW_SIZE, 50*NOW_SIZE,20*NOW_SIZE )];
    firstL.text=@"控制";
    firstL.textAlignment=NSTextAlignmentCenter;
    firstL.textColor=[UIColor blackColor];
    firstL.font = [UIFont systemFontOfSize:12*NOW_SIZE];
    [self.view addSubview:firstL];
    
    UIButton *secondB=[[UIButton alloc]initWithFrame:CGRectMake(24*NOW_SIZE+74*NOW_SIZE, 490*NOW_SIZE, 50*NOW_SIZE,50*NOW_SIZE )];
    [secondB setImage:[UIImage imageNamed:@"参数.png"] forState:UIControlStateNormal];
     [secondB addTarget:self action:@selector(parameterCNJ) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:secondB];
    UILabel *secondL=[[UILabel alloc]initWithFrame:CGRectMake(24*NOW_SIZE+74*NOW_SIZE, 540*NOW_SIZE, 50*NOW_SIZE,20*NOW_SIZE )];
    secondL.text=@"参数";
    secondL.textAlignment=NSTextAlignmentCenter;
    secondL.textColor=[UIColor blackColor];
    secondL.font = [UIFont systemFontOfSize:12*NOW_SIZE];
    [self.view addSubview:secondL];
    
    UIButton *threeB=[[UIButton alloc]initWithFrame:CGRectMake(24*NOW_SIZE+74*NOW_SIZE*2, 490*NOW_SIZE, 50*NOW_SIZE,50*NOW_SIZE )];
    [threeB setImage:[UIImage imageNamed:@"数据.png"] forState:UIControlStateNormal];
      [threeB addTarget:self action:@selector(goThree) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:threeB];
    UILabel *threeL=[[UILabel alloc]initWithFrame:CGRectMake(24*NOW_SIZE+74*NOW_SIZE*2, 540*NOW_SIZE, 50*NOW_SIZE,20*NOW_SIZE )];
    threeL.text=@"数据";
    threeL.textAlignment=NSTextAlignmentCenter;
    threeL.textColor=[UIColor blackColor];
    threeL.font = [UIFont systemFontOfSize:12*NOW_SIZE];
    [self.view addSubview:threeL];
    
    UIButton *fourB=[[UIButton alloc]initWithFrame:CGRectMake(24*NOW_SIZE+74*NOW_SIZE*3, 490*NOW_SIZE, 50*NOW_SIZE,50*NOW_SIZE )];
    [fourB setImage:[UIImage imageNamed:@"日志.png"] forState:UIControlStateNormal];
  [fourB addTarget:self action:@selector(gofour) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:fourB];
    UILabel *fourL=[[UILabel alloc]initWithFrame:CGRectMake(24*NOW_SIZE+74*NOW_SIZE*3, 540*NOW_SIZE, 50*NOW_SIZE,20*NOW_SIZE )];
    fourL.text=@"日志";
    fourL.textAlignment=NSTextAlignmentCenter;
    fourL.textColor=[UIColor blackColor];
    fourL.font = [UIFont systemFontOfSize:12*NOW_SIZE];
    [self.view addSubview:fourL];
}

-(void)gofour{
    PvLogTableViewController *four=[[PvLogTableViewController alloc]init];
    [self.navigationController pushViewController:four animated:NO];
}

-(void)controlCNJ{
    ControlCNJ *CNJ=[[ControlCNJ alloc]init];
    [self.navigationController pushViewController:CNJ animated:YES];
}

-(void)parameterCNJ{
    parameterCNJ *PC=[[parameterCNJ alloc]init];
    [self.navigationController pushViewController:PC animated:NO];
}

-(void)goThree{
    
    threeViewController *goThree=[[threeViewController alloc]init];
    [self.navigationController pushViewController:goThree animated:YES];
    
}
-(void)addGraph{
  
    
    self.line2View = [[Line2View alloc] initWithFrame:CGRectMake(0, 260*NOW_SIZE, SCREEN_Width,280*NOW_SIZE )];
    self.line2View.flag=@"1";
    [self.view addSubview:self.line2View];
    NSMutableDictionary *dict=[NSMutableDictionary new];
    [dict setObject:@"3.0" forKey:@"08:30"];
    [dict setObject:@"5.0" forKey:@"09:30"];
    [dict setObject:@"12.0" forKey:@"10:30"];
    [dict setObject:@"21.0" forKey:@"11:30"];
    [dict setObject:@"33.0" forKey:@"12:30"];
    [dict setObject:@"45.0" forKey:@"13:30"];
    [dict setObject:@"65.0" forKey:@"14:30"];
    [dict setObject:@"23.0" forKey:@"15:30"];
    [dict setObject:@"151.0" forKey:@"16:30"];
    [dict setObject:@"124.0" forKey:@"17:30"];
    self.line2View.frameType=@"1";
    [self.line2View refreshLineChartViewWithDataDict:dict];
    
    
    /*   [BaseRequest requestWithMethodResponseJsonByGet:@"http://server-cn.growatt.com" paramars:@{@"id":@"S765520005",@"type":@"1", @"date":current} paramarsSite:@"/inverterA.do?op=getDps" sucessBlock:^(id content) {
     
     if (content) {
     self.dayDict=[NSMutableDictionary new];
     //[self.dayDict setObject:content forKey:@"data"];
     self.line2View = [[Line2View alloc] initWithFrame:CGRectMake(0, 200*NOW_SIZE, SCREEN_Width,300*NOW_SIZE )];
     self.line2View.flag=@"1";
     [lineView addSubview:self.line2View];
     [self.line2View refreshLineChartViewWithDataDict:content];
     }
     } failure:^(NSError *error) {
     
     }];*/
    
}

-(void)addProcess{
    UIView *processView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 240*NOW_SIZE)];
    UIImage *bgImage = IMAGE(@"bg3.png");
    processView.layer.contents = (id)bgImage.CGImage;
    [self.view addSubview:processView];
    UILabel *leftName=[[UILabel alloc]initWithFrame:CGRectMake(24*NOW_SIZE, 180*NOW_SIZE, 50*NOW_SIZE,20*NOW_SIZE )];
    leftName.text=@"50KW";
    leftName.textAlignment=NSTextAlignmentCenter;
    leftName.textColor=[UIColor greenColor];
    leftName.font = [UIFont systemFontOfSize:14*NOW_SIZE];
    [self.view addSubview:leftName];
    UILabel *leftState=[[UILabel alloc]initWithFrame:CGRectMake(15*NOW_SIZE, 200*NOW_SIZE, 80*NOW_SIZE,20*NOW_SIZE )];
    leftState.text=@"日放电量";
    leftState.textAlignment=NSTextAlignmentCenter;
    leftState.textColor=[UIColor blackColor];
    leftState.font = [UIFont systemFontOfSize:14*NOW_SIZE];
    [self.view addSubview:leftState];
    
    
    UILabel *rightName=[[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth-74*NOW_SIZE, 180*NOW_SIZE, 50*NOW_SIZE,20*NOW_SIZE )];
    rightName.text=@"200KW";
    rightName.textAlignment=NSTextAlignmentCenter;
    rightName.textColor=[UIColor greenColor];
    leftName.font = [UIFont systemFontOfSize:14*NOW_SIZE];
    [self.view addSubview:rightName];
    UILabel *rightState=[[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth-100*NOW_SIZE, 200*NOW_SIZE, 100*NOW_SIZE,20*NOW_SIZE )];
    rightState.text=@"总放电量";
    rightState.textAlignment=NSTextAlignmentCenter;
    rightState.textColor=[UIColor blackColor];
    rightState.font = [UIFont systemFontOfSize:14*NOW_SIZE];
    [self.view addSubview:rightState];
    
    UILabel *dataName=[[UILabel alloc]initWithFrame:CGRectMake(0*NOW_SIZE, 245*NOW_SIZE, 80*NOW_SIZE,20*NOW_SIZE )];
    dataName.text=@"当日储能";
    dataName.textAlignment=NSTextAlignmentCenter;
    dataName.textColor=[UIColor blackColor];
    dataName.font = [UIFont systemFontOfSize:14*NOW_SIZE];
    [self.view addSubview:dataName];
    
    
    VWWWaterView *waterView = [[VWWWaterView alloc]initWithFrame:CGRectMake(0, 20*NOW_SIZE, 160*NOW_SIZE, 160*NOW_SIZE)];
    CGPoint center = CGPointMake(CGRectGetMidX( [UIScreen mainScreen].bounds), 150*NOW_SIZE);
    waterView.center = center;
    waterView.backgroundColor = [UIColor colorWithRed:28/ 255.0f green:111/ 255.0f blue:235/ 255.0f alpha:1];//页面背景颜色改背景
    waterView.currentWaterColor = [UIColor colorWithRed:105/ 255.0f green:214/ 255.0f blue:249/ 255.0f alpha:1];//水波颜色
    //   waterView.currentWaterColor1 = [UIColor colorWithRed:105/ 255.0f green:214/ 255.0f blue:249/ 255.0f alpha:0.5];
    waterView.percentum = 0.66f;//百分比
    [self.view addSubview:waterView];
    
}

- (void)addRightItem
{
    DTKDropdownItem *item0 = [DTKDropdownItem itemWithTitle:@"高级设置" iconName:@"DTK_jiangbei" callBack:^(NSUInteger index, id info) {
        NSLog(@"rightItem%lu",(unsigned long)index);}];
    DTKDropdownItem *item1 = [DTKDropdownItem itemWithTitle:@"基本信息" iconName:@"DTK_renwu" callBack:^(NSUInteger index, id info) {
        NSLog(@"rightItem%lu",(unsigned long)index);}];
    DTKDropdownItem *item2 = [DTKDropdownItem itemWithTitle:@"日志" iconName:@"DTK_update" callBack:^(NSUInteger index, id info) {
        NSLog(@"rightItem%lu",(unsigned long)index);}];
    DTKDropdownMenuView *menuView = [DTKDropdownMenuView dropdownMenuViewWithType:dropDownTypeRightItem frame:CGRectMake(0, 0, 44.f, 44.f) dropdownItems:@[item0,item1,item2] icon:@"DTK_bi"];
    
    menuView.dropWidth = 150.f;
    menuView.titleFont = [UIFont systemFontOfSize:18.f];
    menuView.textColor = ColorWithRGB(102.f, 102.f, 102.f);
    menuView.textFont = [UIFont systemFontOfSize:13.f];
    menuView.cellSeparatorColor = ColorWithRGB(229.f, 229.f, 229.f);
    menuView.textFont = [UIFont systemFontOfSize:14.f];
    menuView.animationDuration = 0.2f;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:menuView];
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
