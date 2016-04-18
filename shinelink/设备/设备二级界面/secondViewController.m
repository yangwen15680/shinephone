//
//  secondViewController.m
//  shinelink
//
//  Created by sky on 16/3/9.
//  Copyright © 2016年 sky. All rights reserved.
//

#import "secondViewController.h"
#import "CircleView.h"
#import"DTKDropdownMenuView.h"
#import "Line2View.h"
#import "threeViewController.h"
#import "KongZhiNi.h"
#import "parameterPV.h"
#import "PvLogTableViewController.h"
#import "EquipGraphViewController.h"
#import "newLine.h"

#define ColorWithRGB(r,g,b) [UIColor colorWithRed:r/255. green:g/255. blue:b/255. alpha:1]

@interface secondViewController ()
// 进度增长步长
@property (nonatomic, assign) CGFloat step;
@property (nonatomic, strong) CircleView *progressView;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) NSMutableArray *invsDataArr;
@property (nonatomic, strong) NSMutableDictionary *dayDict;
@property (nonatomic, strong) Line2View *line2View;
@property (nonatomic, strong) NSDateFormatter *dayFormatter;
@property (nonatomic, strong) NSString *currentDay;
@property (nonatomic, strong) NSString *nominalPower;

@end

@implementation secondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
      //[self.navigationController.navigationBar setBarTintColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.png"]]];
[self.navigationController.navigationBar setBarTintColor:COLOR(17, 183, 243, 1)];
  
     //[self addRightItem];
    [self addGraph];
    
    [self addbutton];
    
}

-(void)addbutton{
    UIButton *firstB=[[UIButton alloc]initWithFrame:CGRectMake(24*NOW_SIZE, 490*NOW_SIZE, 50*NOW_SIZE,50*NOW_SIZE )];
    [firstB setImage:[UIImage imageNamed:@"控制.jpg"] forState:UIControlStateNormal];
     [firstB addTarget:self action:@selector(controlThree) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:firstB];
    UILabel *firstL=[[UILabel alloc]initWithFrame:CGRectMake(24*NOW_SIZE, 540*NOW_SIZE, 50*NOW_SIZE,20*NOW_SIZE )];
    firstL.text=@"控制";
    firstL.textAlignment=NSTextAlignmentCenter;
    firstL.textColor=[UIColor blackColor];
    firstL.font = [UIFont systemFontOfSize:12*NOW_SIZE];
    [self.view addSubview:firstL];
    
    UIButton *secondB=[[UIButton alloc]initWithFrame:CGRectMake(24*NOW_SIZE+74*NOW_SIZE, 490*NOW_SIZE, 50*NOW_SIZE,50*NOW_SIZE )];
    [secondB setImage:[UIImage imageNamed:@"参数.png"] forState:UIControlStateNormal];
     [secondB addTarget:self action:@selector(parameterPV) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:secondB];
    UILabel *secondL=[[UILabel alloc]initWithFrame:CGRectMake(24*NOW_SIZE+74*NOW_SIZE, 540*NOW_SIZE, 50*NOW_SIZE,20*NOW_SIZE )];
    secondL.text=@"参数";
    secondL.textAlignment=NSTextAlignmentCenter;
    secondL.textColor=[UIColor blackColor];
    secondL.font = [UIFont systemFontOfSize:12*NOW_SIZE];
    [self.view addSubview:secondL];
    
    UIButton *threeB=[[UIButton alloc]initWithFrame:CGRectMake(24*NOW_SIZE+74*NOW_SIZE*2, 490*NOW_SIZE, 50*NOW_SIZE,50*NOW_SIZE )];
    [threeB setImage:[UIImage imageNamed:@"数据.png"] forState:UIControlStateNormal];
     [threeB addTarget:self action:@selector(goPVThree) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:threeB];
    UILabel *threeL=[[UILabel alloc]initWithFrame:CGRectMake(24*NOW_SIZE+74*NOW_SIZE*2, 540*NOW_SIZE, 50*NOW_SIZE,20*NOW_SIZE )];
    threeL.text=@"数据";
    threeL.textAlignment=NSTextAlignmentCenter;
    threeL.textColor=[UIColor blackColor];
    threeL.font = [UIFont systemFontOfSize:12*NOW_SIZE];
    [self.view addSubview:threeL];
    
    UIButton *fourB=[[UIButton alloc]initWithFrame:CGRectMake(24*NOW_SIZE+74*NOW_SIZE*3, 490*NOW_SIZE, 50*NOW_SIZE,50*NOW_SIZE )];
        [fourB addTarget:self action:@selector(goFour) forControlEvents:UIControlEventTouchUpInside];
    [fourB setImage:[UIImage imageNamed:@"日志.png"] forState:UIControlStateNormal];
   
    [self.view addSubview:fourB];
    UILabel *fourL=[[UILabel alloc]initWithFrame:CGRectMake(24*NOW_SIZE+74*NOW_SIZE*3, 540*NOW_SIZE, 50*NOW_SIZE,20*NOW_SIZE )];
    fourL.text=@"日志";
    fourL.textAlignment=NSTextAlignmentCenter;
    fourL.textColor=[UIColor blackColor];
    fourL.font = [UIFont systemFontOfSize:12*NOW_SIZE];
    [self.view addSubview:fourL];
}

-(void)goFour{
    PvLogTableViewController *four=[[PvLogTableViewController alloc]init];
    four.PvSn=_SnData;
    [self.navigationController pushViewController:four animated:NO];

}
-(void)controlThree{
    KongZhiNi *go=[[KongZhiNi alloc]init];
    [self.navigationController pushViewController:go animated:YES];
}

-(void)parameterPV{
    parameterPV *pv=[[parameterPV alloc]init];
    pv.PvSn=_SnData;
    [self.navigationController pushViewController:pv animated:NO];
}

-(void)goPVThree{
    EquipGraphViewController *equipGraph=[[EquipGraphViewController alloc]init];
    equipGraph.SnID=_SnData;
    equipGraph.dictInfo=@{@"equipId":_SnData,
                          @"daySite":@"/newInverterAPI.do?op=getInverterData",
                          @"monthSite":@"/newInverterAPI.do?op=getMonthPac",
                          @"yearSite":@"/newInverterAPI.do?op=getYearPac",
                          @"allSite":@"/newInverterAPI.do?op=getTotalPac"};
    equipGraph.dict=@{@"1":root_PV_POWER, @"2":root_PV1_VOLTAGE, @"3":root_PV1_ELEC_CURRENT, @"4":root_PV2_VOLTAGE, @"5":root_PV2_ELEC_CURRENT, @"6":root_R_PHASE_POWER, @"7":root_S_PHASE_POWER, @"8":root_T_PHASE_POWER};
    [self.navigationController pushViewController:equipGraph animated:YES];
    
}
-(void)addGraph{
    
   self.line2View = [[Line2View alloc] initWithFrame:CGRectMake(0, 275*NOW_SIZE, SCREEN_Width,250*NOW_SIZE )];
    [self.view addSubview:self.line2View];
    self.dayFormatter = [[NSDateFormatter alloc] init];
    [self.dayFormatter setDateFormat:@"yyyy-MM-dd"];
  self.currentDay = [_dayFormatter stringFromDate:[NSDate date]];
      [self showProgressView];
[BaseRequest requestWithMethodResponseJsonByGet:HEAD_URL paramars:@{@"id":_SnData,@"type":@"1", @"date":self.currentDay} paramarsSite:@"/newInverterAPI.do?op=getInverterData" sucessBlock:^(id content) {
        [self hideProgressView];
   
        if (content) {
               //NSString *res = [[NSString alloc] initWithData:content encoding:NSUTF8StringEncoding];
           //  id jsonObj = [NSJSONSerialization JSONObjectWithData:content options:NSJSONReadingAllowFragments error:nil];
            self.dayDict=[NSMutableDictionary dictionaryWithDictionary:[content objectForKey:@"invPacData"]];
            _nominalPower=[content objectForKey:@"nominalPower"];
           NSLog(@"getInverterData: %@", content);
            self.line2View.frameType=@"1";
            [self.line2View refreshLineChartViewWithDataDict:_dayDict];
            [self addProcess];
        }
    } failure:^(NSError *error) {
      [self hideProgressView];
         [self addProcess];
    }];
    


}

-(void)addProcess{
    UIView *processView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 250*NOW_SIZE)];
    UIImage *bgImage = IMAGE(@"bg3.png");
    processView.layer.contents = (id)bgImage.CGImage;
    [self.view addSubview:processView];
    
    UILabel *dayData=[[UILabel alloc]initWithFrame:CGRectMake(15*NOW_SIZE, 180*NOW_SIZE, 80*NOW_SIZE,20*NOW_SIZE )];
    dayData.text=_dayData;
    dayData.textAlignment=NSTextAlignmentCenter;
    dayData.textColor=[UIColor greenColor];
    dayData.font = [UIFont systemFontOfSize:14*NOW_SIZE];
    [self.view addSubview:dayData];
    UILabel *leftState=[[UILabel alloc]initWithFrame:CGRectMake(15*NOW_SIZE, 200*NOW_SIZE, 80*NOW_SIZE,20*NOW_SIZE )];
    leftState.text=@"日电量";
    leftState.textAlignment=NSTextAlignmentCenter;
    leftState.textColor=[UIColor blackColor];
    leftState.font = [UIFont systemFontOfSize:14*NOW_SIZE];
    [self.view addSubview:leftState];
    
     UILabel *powerData=[[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth-120*NOW_SIZE)/2, 120*NOW_SIZE, 120*NOW_SIZE,40*NOW_SIZE )];
    powerData.text=_powerData;
    powerData.textAlignment=NSTextAlignmentCenter;
    powerData.textColor=[UIColor redColor];
    powerData.font = [UIFont systemFontOfSize:25*NOW_SIZE];
    [self.view addSubview:powerData];
    UILabel *centState=[[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth-80*NOW_SIZE)/2,150*NOW_SIZE, 80*NOW_SIZE,20*NOW_SIZE )];
    centState.text=@"当前功率";
    centState.textAlignment=NSTextAlignmentCenter;
    centState.textColor=[UIColor blackColor];
    centState.font = [UIFont systemFontOfSize:12*NOW_SIZE];
    [self.view addSubview:centState];
    
    UILabel *totalData=[[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth-80*NOW_SIZE, 180*NOW_SIZE, 80*NOW_SIZE,20*NOW_SIZE )];
    totalData.text=_totalData;
    totalData.textAlignment=NSTextAlignmentCenter;
    totalData.textColor=[UIColor greenColor];
    totalData.font = [UIFont systemFontOfSize:14*NOW_SIZE];
    [self.view addSubview:totalData];
    UILabel *rightState=[[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth-80*NOW_SIZE, 200*NOW_SIZE, 80*NOW_SIZE,20*NOW_SIZE )];
    rightState.text=@"总电量";
    rightState.textAlignment=NSTextAlignmentCenter;
    rightState.textColor=[UIColor blackColor];
    rightState.font = [UIFont systemFontOfSize:14*NOW_SIZE];
    [self.view addSubview:rightState];
    
    UILabel *dayDate=[[UILabel alloc]initWithFrame:CGRectMake(0, 255*NOW_SIZE, 100*NOW_SIZE,20*NOW_SIZE )];
    dayDate.text=@"日发电量";
    dayDate.textAlignment=NSTextAlignmentLeft;
    dayDate.textColor=[UIColor blackColor];
    dayDate.font = [UIFont systemFontOfSize:14*NOW_SIZE];
    [self.view addSubview:dayDate];
    
    _progressView = [[CircleView alloc] initWithFrame:CGRectMake(0, 0, 180*NOW_SIZE, 200*NOW_SIZE)];
    CGPoint center = CGPointMake(CGRectGetMidX( [UIScreen mainScreen].bounds), 120*NOW_SIZE);
    _progressView.center = center;
    float K=[_powerData floatValue]/[_nominalPower floatValue];
    //K=0.3;
    _progressView.startAngle = - M_PI*1/2 ;
    _progressView.endAngle   =- M_PI*1/2 +M_PI*2*K;
    [processView addSubview:_progressView];
    self.step = 1.0 / 30;
    _timer = [NSTimer scheduledTimerWithTimeInterval:self.step target:self selector:@selector(updateProgress) userInfo:nil repeats:YES];

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

- (void)updateProgress {
    CGFloat progress = self.progressView.progress;
    if (progress > 100) {
        [_timer invalidate];
        _timer = nil;
        return;
    }
    progress += 0.3;
    self.progressView.progress = progress;
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
