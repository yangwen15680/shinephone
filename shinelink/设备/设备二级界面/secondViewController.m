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

#define ColorWithRGB(r,g,b) [UIColor colorWithRed:r/255. green:g/255. blue:b/255. alpha:1]

@interface secondViewController ()
// 进度增长步长
@property (nonatomic, assign) CGFloat step;
@property (nonatomic, strong) CircleView *progressView;
@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, strong) NSMutableDictionary *dayDict;
@property (nonatomic, strong) Line2View *line2View;

@end

@implementation secondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
      //[self.navigationController.navigationBar setBarTintColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.png"]]];
[self.navigationController.navigationBar setBarTintColor:COLOR(17, 183, 243, 1)];
    [self addProcess];
     [self addRightItem];
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
   
    [self.view addSubview:fourB];
    UILabel *fourL=[[UILabel alloc]initWithFrame:CGRectMake(24*NOW_SIZE+74*NOW_SIZE*3, 540*NOW_SIZE, 50*NOW_SIZE,20*NOW_SIZE )];
    fourL.text=@"日志";
    fourL.textAlignment=NSTextAlignmentCenter;
    fourL.textColor=[UIColor blackColor];
    fourL.font = [UIFont systemFontOfSize:12*NOW_SIZE];
    [self.view addSubview:fourL];
}

-(void)controlThree{
    KongZhiNi *go=[[KongZhiNi alloc]init];
    [self.navigationController pushViewController:go animated:YES];
}

-(void)parameterPV{
    parameterPV *pv=[[parameterPV alloc]init];
    [self.navigationController pushViewController:pv animated:NO];
}

-(void)goThree{
    threeViewController *goThree=[[threeViewController alloc]init];
    [self.navigationController pushViewController:goThree animated:YES];
    
}
-(void)addGraph{
    
    self.line2View = [[Line2View alloc] initWithFrame:CGRectMake(0, 100*NOW_SIZE, SCREEN_Width,280*NOW_SIZE )];
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
    UIView *processView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 250*NOW_SIZE)];
    UIImage *bgImage = IMAGE(@"bg3.png");
    processView.layer.contents = (id)bgImage.CGImage;
    [self.view addSubview:processView];
    
    UILabel *leftName=[[UILabel alloc]initWithFrame:CGRectMake(24*NOW_SIZE, 180*NOW_SIZE, 50*NOW_SIZE,20*NOW_SIZE )];
    leftName.text=@"正常";
    leftName.textAlignment=NSTextAlignmentCenter;
    leftName.textColor=[UIColor greenColor];
    leftName.font = [UIFont systemFontOfSize:14*NOW_SIZE];
    [self.view addSubview:leftName];
    UILabel *leftState=[[UILabel alloc]initWithFrame:CGRectMake(15*NOW_SIZE, 200*NOW_SIZE, 80*NOW_SIZE,20*NOW_SIZE )];
    leftState.text=@"当前状态";
    leftState.textAlignment=NSTextAlignmentCenter;
    leftState.textColor=[UIColor blackColor];
    leftState.font = [UIFont systemFontOfSize:14*NOW_SIZE];
    [self.view addSubview:leftState];
    
    UILabel *centName=[[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth-120*NOW_SIZE)/2, 120*NOW_SIZE, 120*NOW_SIZE,40*NOW_SIZE )];
    centName.text=@"2000KW";
    centName.textAlignment=NSTextAlignmentCenter;
    centName.textColor=[UIColor redColor];
    centName.font = [UIFont systemFontOfSize:25*NOW_SIZE];
    [self.view addSubview:centName];
    UILabel *centState=[[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth-80*NOW_SIZE)/2,150*NOW_SIZE, 80*NOW_SIZE,20*NOW_SIZE )];
    centState.text=@"已提供总电量";
    centState.textAlignment=NSTextAlignmentCenter;
    centState.textColor=[UIColor blackColor];
    centState.font = [UIFont systemFontOfSize:12*NOW_SIZE];
    [self.view addSubview:centState];
    
    UILabel *rightName=[[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth-74*NOW_SIZE, 180*NOW_SIZE, 50*NOW_SIZE,20*NOW_SIZE )];
    rightName.text=@"480h";
    rightName.textAlignment=NSTextAlignmentCenter;
    rightName.textColor=[UIColor greenColor];
    leftName.font = [UIFont systemFontOfSize:14*NOW_SIZE];
    [self.view addSubview:rightName];
    UILabel *rightState=[[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth-100*NOW_SIZE, 200*NOW_SIZE, 100*NOW_SIZE,20*NOW_SIZE )];
    rightState.text=@"累计运行时长";
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
    _progressView.startAngle = - M_PI*1/2 ;
    _progressView.endAngle   = - M_PI*1;
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
