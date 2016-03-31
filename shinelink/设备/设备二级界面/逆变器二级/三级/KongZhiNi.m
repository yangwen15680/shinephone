//
//  KongZhiNi.m
//  shinelink
//
//  Created by sky on 16/3/24.
//  Copyright © 2016年 sky. All rights reserved.
//

#import "KongZhiNi.h"
#import "ASValueTrackingSlider.h"
@interface KongZhiNi ()
@property (nonatomic, strong) UIToolbar *toolBar;
@property (nonatomic, strong) UIDatePicker *date;
@property (nonatomic, strong) NSDateFormatter *dayFormatter;
@property (nonatomic, strong) NSString *currentDay;
@property (nonatomic, strong) UIButton *datePickerButton;
@property (nonatomic, strong) NSMutableDictionary *dataDic;
@property (nonatomic, strong) ASValueTrackingSlider *slider;
@property (nonatomic, strong) ASValueTrackingSlider *slider1;
@property (nonatomic, strong) ASValueTrackingSlider *slider2;
@property (nonatomic, strong) UIScrollView *scrollView;
@end

@implementation KongZhiNi

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataDic=[NSMutableDictionary new];
    UIImage *bgImage = IMAGE(@"bg4.png");
    self.view.layer.contents = (id)bgImage.CGImage;
    [self initUI];
    
}

-(void)initUI{
    _scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Height)];
    _scrollView.scrollEnabled=YES;
    _scrollView.contentSize = CGSizeMake(SCREEN_Width,600*NOW_SIZE);
    [self.view addSubview:_scrollView];
    
    float buttonSize=70*NOW_SIZE;
    UILabel *buttonLable=[[UILabel alloc]initWithFrame:CGRectMake((SCREEN_Width-100*NOW_SIZE)/2, 60*NOW_SIZE, 100*NOW_SIZE,20*NOW_SIZE )];
    buttonLable.text=@"开关机";
    buttonLable.textAlignment=NSTextAlignmentCenter;
    buttonLable.textColor=[UIColor whiteColor];
    buttonLable.font = [UIFont systemFontOfSize:18*NOW_SIZE];
    [_scrollView addSubview:buttonLable];
    
    UIButton *firstB=[[UIButton alloc]initWithFrame:CGRectMake((SCREEN_Width-buttonSize)/2, 85*NOW_SIZE, buttonSize,buttonSize)];
    [firstB setImage:[UIImage imageNamed:@"open@2x.png"] forState:UIControlStateNormal];
    [firstB addTarget:self action:@selector(control) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:firstB];
    
    UILabel *PVLable=[[UILabel alloc]initWithFrame:CGRectMake(10*NOW_SIZE, 85*NOW_SIZE+buttonSize+5*NOW_SIZE, 150*NOW_SIZE,20*NOW_SIZE )];
    PVLable.text=@"设置有效功率";
    PVLable.textAlignment=NSTextAlignmentLeft;
    PVLable.textColor=[UIColor whiteColor];
    PVLable.font = [UIFont systemFontOfSize:16*NOW_SIZE];
    [_scrollView addSubview:PVLable];
    _slider=[[ASValueTrackingSlider alloc]initWithFrame:CGRectMake(20*NOW_SIZE, 85*NOW_SIZE+buttonSize+30*NOW_SIZE, SCREEN_Width-40*NOW_SIZE, 40*NOW_SIZE)];
   _slider.maximumValue = 1.0;
    [_scrollView addSubview:_slider];
    UILabel *PVLable1=[[UILabel alloc]initWithFrame:CGRectMake(15*NOW_SIZE, 85*NOW_SIZE+buttonSize+5*NOW_SIZE+55*NOW_SIZE, 150*NOW_SIZE,20*NOW_SIZE )];
    PVLable1.text=@"0";
    PVLable1.textAlignment=NSTextAlignmentLeft;
    PVLable1.textColor=[UIColor whiteColor];
    PVLable1.font = [UIFont systemFontOfSize:16*NOW_SIZE];
    [_scrollView addSubview:PVLable1];
    UILabel *PVLable2=[[UILabel alloc]initWithFrame:CGRectMake(SCREEN_Width-22*NOW_SIZE, 85*NOW_SIZE+buttonSize+5*NOW_SIZE+55*NOW_SIZE, 150*NOW_SIZE,20*NOW_SIZE )];
    PVLable2.text=@"1";
    PVLable2.textAlignment=NSTextAlignmentLeft;
    PVLable2.textColor=[UIColor whiteColor];
    PVLable2.font = [UIFont systemFontOfSize:16*NOW_SIZE];
    [_scrollView addSubview:PVLable2];
    
    UILabel *PV1Lable=[[UILabel alloc]initWithFrame:CGRectMake(10*NOW_SIZE, 85*NOW_SIZE+buttonSize+5*NOW_SIZE+85*NOW_SIZE, 150*NOW_SIZE,20*NOW_SIZE )];
    PV1Lable.text=@"设置无功功率";
    PV1Lable.textAlignment=NSTextAlignmentLeft;
    PV1Lable.textColor=[UIColor whiteColor];
    PV1Lable.font = [UIFont systemFontOfSize:16*NOW_SIZE];
    [_scrollView addSubview:PV1Lable];
    _slider1=[[ASValueTrackingSlider alloc]initWithFrame:CGRectMake(20*NOW_SIZE, 85*NOW_SIZE+buttonSize+30*NOW_SIZE+85*NOW_SIZE, SCREEN_Width-40*NOW_SIZE, 40*NOW_SIZE)];
    _slider1.maximumValue = 1;
    [_scrollView addSubview:_slider1];
    UILabel *PV1Lable1=[[UILabel alloc]initWithFrame:CGRectMake(15*NOW_SIZE, 85*NOW_SIZE+buttonSize+5*NOW_SIZE+55*NOW_SIZE+85*NOW_SIZE, 150*NOW_SIZE,20*NOW_SIZE )];
    PV1Lable1.text=@"0";
    PV1Lable1.textAlignment=NSTextAlignmentLeft;
    PV1Lable1.textColor=[UIColor whiteColor];
    PV1Lable1.font = [UIFont systemFontOfSize:16*NOW_SIZE];
    [_scrollView addSubview:PV1Lable1];
    UILabel *PV1Lable2=[[UILabel alloc]initWithFrame:CGRectMake(SCREEN_Width-22*NOW_SIZE, 85*NOW_SIZE+buttonSize+5*NOW_SIZE+55*NOW_SIZE+85*NOW_SIZE, 150*NOW_SIZE,20*NOW_SIZE )];
    PV1Lable2.text=@"1";
    PV1Lable2.textAlignment=NSTextAlignmentLeft;
    PV1Lable2.textColor=[UIColor whiteColor];
    PV1Lable2.font = [UIFont systemFontOfSize:16*NOW_SIZE];
    [_scrollView addSubview:PV1Lable2];
    
    UILabel *PV2Lable=[[UILabel alloc]initWithFrame:CGRectMake(10*NOW_SIZE, 85*NOW_SIZE+buttonSize+5*NOW_SIZE+85*NOW_SIZE*2, 150*NOW_SIZE,20*NOW_SIZE )];
    PV2Lable.text=@"设置PF值";
    PV2Lable.textAlignment=NSTextAlignmentLeft;
    PV2Lable.textColor=[UIColor whiteColor];
    PV2Lable.font = [UIFont systemFontOfSize:16*NOW_SIZE];
    [_scrollView addSubview:PV2Lable];
    _slider2=[[ASValueTrackingSlider alloc]initWithFrame:CGRectMake(20*NOW_SIZE, 85*NOW_SIZE+buttonSize+30*NOW_SIZE+85*NOW_SIZE*2, SCREEN_Width-40*NOW_SIZE, 40*NOW_SIZE)];
    _slider2.maximumValue = 0.8;
    _slider2.minimumValue=-0.8;
    [_scrollView addSubview:_slider2];
    UILabel *PV2Lable1=[[UILabel alloc]initWithFrame:CGRectMake(15*NOW_SIZE, 85*NOW_SIZE+buttonSize+5*NOW_SIZE+55*NOW_SIZE+85*NOW_SIZE*2, 150*NOW_SIZE,20*NOW_SIZE )];
    PV2Lable1.text=@"-0.8";
    PV2Lable1.textAlignment=NSTextAlignmentLeft;
    PV2Lable1.textColor=[UIColor whiteColor];
    PV2Lable1.font = [UIFont systemFontOfSize:16*NOW_SIZE];
    [_scrollView addSubview:PV2Lable1];
    UILabel *PV2Lable2=[[UILabel alloc]initWithFrame:CGRectMake(SCREEN_Width-22*NOW_SIZE, 85*NOW_SIZE+buttonSize+5*NOW_SIZE+55*NOW_SIZE+85*NOW_SIZE*2, 150*NOW_SIZE,20*NOW_SIZE )];
    PV2Lable2.text=@"0.8";
    PV2Lable2.textAlignment=NSTextAlignmentLeft;
    PV2Lable2.textColor=[UIColor whiteColor];
    PV2Lable2.font = [UIFont systemFontOfSize:16*NOW_SIZE];
    [_scrollView addSubview:PV2Lable2];
    
    UILabel *PVData=[[UILabel alloc]initWithFrame:CGRectMake(10*NOW_SIZE, 85*NOW_SIZE+buttonSize+5*NOW_SIZE+85*NOW_SIZE*3, 150*NOW_SIZE,20*NOW_SIZE )];
    PVData.text=@"设置逆变器时间:";
    PVData.textAlignment=NSTextAlignmentLeft;
    PVData.textColor=[UIColor whiteColor];
    PVData.font = [UIFont systemFontOfSize:16*NOW_SIZE];
    [_scrollView addSubview:PVData];

    self.dayFormatter = [[NSDateFormatter alloc] init];
    [self.dayFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
  self.currentDay = [_dayFormatter stringFromDate:[NSDate date]];
    
    _datePickerButton=[[UIButton alloc]initWithFrame:CGRectMake(120*NOW_SIZE,85*NOW_SIZE+buttonSize+6*NOW_SIZE+85*NOW_SIZE*3, 200*NOW_SIZE, 20*NOW_SIZE)];
    [_datePickerButton setTitle:self.currentDay forState:UIControlStateNormal];
    [_datePickerButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _datePickerButton.titleLabel.textAlignment = NSTextAlignmentLeft;
    _datePickerButton.titleLabel.font = [UIFont boldSystemFontOfSize:16*NOW_SIZE];
    [_datePickerButton addTarget:self action:@selector(pickDate) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:_datePickerButton];
    
    UIButton *goBut =  [UIButton buttonWithType:UIButtonTypeCustom];
    goBut.frame=CGRectMake(60*NOW_SIZE,85*NOW_SIZE+buttonSize+36*NOW_SIZE+85*NOW_SIZE*3, 200*NOW_SIZE, 40*NOW_SIZE);
    [goBut.layer setMasksToBounds:YES];
    [goBut.layer setCornerRadius:25.0];
    [goBut setBackgroundImage:IMAGE(@"按钮2.png") forState:UIControlStateNormal];
    [goBut setTitle:@"完成" forState:UIControlStateNormal];
    [goBut addTarget:self action:@selector(finishSet) forControlEvents:UIControlEventTouchUpInside];
        [_scrollView addSubview:goBut];

}

-(void)finishSet{
    [_dataDic removeAllObjects];
    NSString *S1=[NSString stringWithFormat:@"%.2f",_slider.value];
    [_dataDic setObject:S1 forKey:@"pv1"];
    NSString *S2=[NSString stringWithFormat:@"%.2f",_slider1.value];
    [_dataDic setObject:S2 forKey:@"pv2"];
    NSString *S3=[NSString stringWithFormat:@"%.2f",_slider2.value];
    [_dataDic setObject:S3 forKey:@"pv3"];
}

-(void)pickDate{
    float buttonSize=70*NOW_SIZE;
  _date=[[UIDatePicker alloc]initWithFrame:CGRectMake(0*NOW_SIZE, 85*NOW_SIZE+buttonSize+5*NOW_SIZE+55*NOW_SIZE+85*NOW_SIZE*2, SCREEN_Width, 216*NOW_SIZE)];
    _date.backgroundColor=[UIColor whiteColor];
    _date.datePickerMode=UIDatePickerModeDateAndTime;
    [self.view addSubview:_date];
    
    if (self.toolBar) {
        [UIView animateWithDuration:0.3f animations:^{
            self.toolBar.alpha = 1;
            self.toolBar.frame = CGRectMake(0, 85*NOW_SIZE+buttonSize+5*NOW_SIZE+55*NOW_SIZE+85*NOW_SIZE*2-44*NOW_SIZE, SCREEN_Width, 44*NOW_SIZE);
            [self.view addSubview:_toolBar];
        }];
    } else {
        self.toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 85*NOW_SIZE+buttonSize+5*NOW_SIZE+55*NOW_SIZE+85*NOW_SIZE*2-44*NOW_SIZE, SCREEN_Width, 44*NOW_SIZE)];
        self.toolBar.barStyle = UIBarStyleDefault;
        self.toolBar.barTintColor = COLOR(17, 183, 243, 1);
        [self.view addSubview:self.toolBar];
        
        UIBarButtonItem *spaceButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        
        UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(completeSelectDate:)];
        doneButton.tintColor = [UIColor whiteColor];
        self.toolBar.items = @[spaceButton, doneButton];
   }
}

- (void)completeSelectDate:(UIToolbar *)toolBar {
    self.currentDay = [self.dayFormatter stringFromDate:self.date.date];
    [self.datePickerButton setTitle:self.currentDay forState:UIControlStateNormal];
    [self.toolBar removeFromSuperview];
    [self.date removeFromSuperview];
    
}

-(void)control{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"警告" message:@"是否确定关闭逆变器" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
    [alertView show];
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
