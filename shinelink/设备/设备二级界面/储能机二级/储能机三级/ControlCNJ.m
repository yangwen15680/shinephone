//
//  ControlCNJ.m
//  shinelink
//
//  Created by sky on 16/3/31.
//  Copyright © 2016年 sky. All rights reserved.
//

#import "ControlCNJ.h"
#import "ASValueTrackingSlider.h"


@interface ControlCNJ ()
@property (nonatomic, strong) NSMutableDictionary *dataDic;
@property (nonatomic, strong) ASValueTrackingSlider *slider;
@property (nonatomic, strong) UIToolbar *toolBar;
@property (nonatomic, strong) UIDatePicker *date;
@property (nonatomic, strong) UIDatePicker *date1;
@property (nonatomic, strong) UIDatePicker *date2;
@property (nonatomic, strong) NSDateFormatter *dayFormatter;
@property (nonatomic, strong) NSString *currentDay;
@property (nonatomic, strong) UIButton *time1;
@property (nonatomic, strong) NSDateFormatter *time1Formatter;
@property (nonatomic, strong) NSString *currentTime1;
@property (nonatomic, strong) UIButton *time2;
@property (nonatomic, strong) NSString *currentTime2;
@property (nonatomic, strong)UITextField *textField;
@property (nonatomic, strong)UITextField *textField1;
@property (nonatomic, strong) UIButton *datePickerButton;
@property (nonatomic, strong) UISwitch *Switch;
@property (nonatomic, strong) UIScrollView *scrollView;
@end

@implementation ControlCNJ

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImage *bgImage = IMAGE(@"bg4.png");
    self.view.layer.contents = (id)bgImage.CGImage;
   
    [self initUI];
}

-(void)initUI{
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    //将触摸事件添加到当前view
    [self.view addGestureRecognizer:tapGestureRecognizer];
    
    _scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Height)];
    _scrollView.scrollEnabled=YES;
    _scrollView.contentSize = CGSizeMake(SCREEN_Width,650*NOW_SIZE);
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
    [firstB addTarget:self action:@selector(controlOpen) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:firstB];
    
    UILabel *PVLable=[[UILabel alloc]initWithFrame:CGRectMake(10*NOW_SIZE, 85*NOW_SIZE+buttonSize+5*NOW_SIZE, 150*NOW_SIZE,20*NOW_SIZE )];
    PVLable.text=@"锂电池SOC下限设定";
    PVLable.textAlignment=NSTextAlignmentLeft;
    PVLable.textColor=[UIColor whiteColor];
    PVLable.font = [UIFont systemFontOfSize:16*NOW_SIZE];
    [_scrollView addSubview:PVLable];
    _slider=[[ASValueTrackingSlider alloc]initWithFrame:CGRectMake(20*NOW_SIZE, 85*NOW_SIZE+buttonSize+30*NOW_SIZE, SCREEN_Width-40*NOW_SIZE, 40*NOW_SIZE)];
    _slider.maximumValue = 0.1;
    _slider.minimumValue=0.01;
    [_scrollView addSubview:_slider];
    
    UILabel *PVLable1=[[UILabel alloc]initWithFrame:CGRectMake(15*NOW_SIZE, 85*NOW_SIZE+buttonSize+5*NOW_SIZE+55*NOW_SIZE, 150*NOW_SIZE,20*NOW_SIZE )];
    PVLable1.text=@"0.01";
    PVLable1.textAlignment=NSTextAlignmentLeft;
    PVLable1.textColor=[UIColor whiteColor];
    PVLable1.font = [UIFont systemFontOfSize:16*NOW_SIZE];
    [_scrollView addSubview:PVLable1];
    UILabel *PVLable2=[[UILabel alloc]initWithFrame:CGRectMake(SCREEN_Width-22*NOW_SIZE, 85*NOW_SIZE+buttonSize+5*NOW_SIZE+55*NOW_SIZE, 150*NOW_SIZE,20*NOW_SIZE )];
    PVLable2.text=@"0.1";
    PVLable2.textAlignment=NSTextAlignmentLeft;
    PVLable2.textColor=[UIColor whiteColor];
    PVLable2.font = [UIFont systemFontOfSize:16*NOW_SIZE];
    [_scrollView addSubview:PVLable2];
    
    UILabel *PVData=[[UILabel alloc]initWithFrame:CGRectMake(10*NOW_SIZE, 85*NOW_SIZE+buttonSize+5*NOW_SIZE+85*NOW_SIZE, 150*NOW_SIZE,20*NOW_SIZE )];
    PVData.text=@"设置储能机时间:";
    PVData.textAlignment=NSTextAlignmentLeft;
    PVData.textColor=[UIColor whiteColor];
    PVData.font = [UIFont systemFontOfSize:16*NOW_SIZE];
    [_scrollView addSubview:PVData];
    
    UIView *line=[[UIView alloc]initWithFrame:CGRectMake(130*NOW_SIZE,85*NOW_SIZE+buttonSize+26*NOW_SIZE+85*NOW_SIZE, 180*NOW_SIZE, 1*NOW_SIZE)];
    line.backgroundColor=[UIColor whiteColor];
    [_scrollView addSubview:line];
    
    self.dayFormatter = [[NSDateFormatter alloc] init];
    [self.dayFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    self.currentDay = [_dayFormatter stringFromDate:[NSDate date]];
    
    _datePickerButton=[[UIButton alloc]initWithFrame:CGRectMake(120*NOW_SIZE,85*NOW_SIZE+buttonSize+5*NOW_SIZE+85*NOW_SIZE, 200*NOW_SIZE, 20*NOW_SIZE)];
    [_datePickerButton setTitle:self.currentDay forState:UIControlStateNormal];
    [_datePickerButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _datePickerButton.titleLabel.textAlignment = NSTextAlignmentLeft;
    _datePickerButton.titleLabel.font = [UIFont boldSystemFontOfSize:16*NOW_SIZE];
    _datePickerButton.tag=1001;
    [_datePickerButton addTarget:self action:@selector(pickDate1:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:_datePickerButton];
    
    UILabel *FDT=[[UILabel alloc]initWithFrame:CGRectMake(10*NOW_SIZE, 85*NOW_SIZE+buttonSize+5*NOW_SIZE+85*NOW_SIZE+45*NOW_SIZE, 150*NOW_SIZE,20*NOW_SIZE )];
    FDT.text=@"FDT设置";
    FDT.textAlignment=NSTextAlignmentLeft;
    FDT.textColor=[UIColor blueColor];
    FDT.font = [UIFont systemFontOfSize:18*NOW_SIZE];
    [_scrollView addSubview:FDT];
    
    UILabel *Enable=[[UILabel alloc]initWithFrame:CGRectMake(10*NOW_SIZE, 85*NOW_SIZE+buttonSize+10*NOW_SIZE+85*NOW_SIZE+65*NOW_SIZE, 150*NOW_SIZE,20*NOW_SIZE )];
    Enable.text=@"强制放电使能";
    Enable.textAlignment=NSTextAlignmentLeft;
    Enable.textColor=[UIColor whiteColor];
    Enable.font = [UIFont systemFontOfSize:16*NOW_SIZE];
    [_scrollView addSubview:Enable];
    
    _Switch=[[UISwitch alloc]initWithFrame:CGRectMake(260*NOW_SIZE, 85*NOW_SIZE+buttonSize+10*NOW_SIZE+85*NOW_SIZE+65*NOW_SIZE, 120*NOW_SIZE,10*NOW_SIZE )];
    [_Switch setOn:YES];
    [_Switch addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
    _Switch.transform= CGAffineTransformMakeScale(1.2, 1);
       [_scrollView addSubview:_Switch];

    UILabel *dataDischarge=[[UILabel alloc]initWithFrame:CGRectMake(10*NOW_SIZE, 85*NOW_SIZE+buttonSize+10*NOW_SIZE+85*NOW_SIZE+55*NOW_SIZE+45*NOW_SIZE, 150*NOW_SIZE,20*NOW_SIZE )];
    dataDischarge.text=@"强制放电时间段";
    dataDischarge.textAlignment=NSTextAlignmentLeft;
    dataDischarge.textColor=[UIColor whiteColor];
    dataDischarge.font = [UIFont systemFontOfSize:16*NOW_SIZE];
    [_scrollView addSubview:dataDischarge];
    
    self.time1Formatter = [[NSDateFormatter alloc] init];
    [self.time1Formatter setDateFormat:@"HH:mm"];
    self.currentTime1 = [_time1Formatter stringFromDate:[NSDate date]];
    
    _time1=[[UIButton alloc]initWithFrame:CGRectMake(10*NOW_SIZE, 85*NOW_SIZE+buttonSize+10*NOW_SIZE+85*NOW_SIZE+55*NOW_SIZE+65*NOW_SIZE, 150*NOW_SIZE,20*NOW_SIZE )];
    [_time1 setTitle:self.currentTime1 forState:UIControlStateNormal];
    [_time1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _time1.titleLabel.textAlignment = NSTextAlignmentLeft;
    _time1.titleLabel.font = [UIFont boldSystemFontOfSize:16*NOW_SIZE];
    _time1.tag=1002;
    [_time1 addTarget:self action:@selector(pickDate1:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:_time1];
    
    _time2=[[UIButton alloc]initWithFrame:CGRectMake(160*NOW_SIZE, 85*NOW_SIZE+buttonSize+10*NOW_SIZE+85*NOW_SIZE+55*NOW_SIZE+65*NOW_SIZE, 150*NOW_SIZE,20*NOW_SIZE )];
    [_time2 setTitle:self.currentTime1 forState:UIControlStateNormal];
    [_time2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _time2.titleLabel.textAlignment = NSTextAlignmentLeft;
    _time2.titleLabel.font = [UIFont boldSystemFontOfSize:16*NOW_SIZE];
    _time2.tag=1003;
    [_time2 addTarget:self action:@selector(pickDate1:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:_time2];
    
    UILabel *TO=[[UILabel alloc]initWithFrame:CGRectMake(160*NOW_SIZE, 85*NOW_SIZE+buttonSize+10*NOW_SIZE+85*NOW_SIZE+55*NOW_SIZE+65*NOW_SIZE, 150*NOW_SIZE,20*NOW_SIZE )];
    TO.text=@"至";
    TO.textAlignment=NSTextAlignmentLeft;
    TO.textColor=[UIColor whiteColor];
    TO.font = [UIFont systemFontOfSize:16*NOW_SIZE];
    [_scrollView addSubview:TO];
    
    UIView *line1=[[UIView alloc]initWithFrame:CGRectMake(25*NOW_SIZE, 85*NOW_SIZE+buttonSize+10*NOW_SIZE+85*NOW_SIZE+55*NOW_SIZE+85*NOW_SIZE, 115*NOW_SIZE,1*NOW_SIZE )];
    line1.backgroundColor=[UIColor whiteColor];
    [_scrollView addSubview:line1];
    UIView *line2=[[UIView alloc]initWithFrame:CGRectMake(185*NOW_SIZE, 85*NOW_SIZE+buttonSize+10*NOW_SIZE+85*NOW_SIZE+55*NOW_SIZE+85*NOW_SIZE, 115*NOW_SIZE,1*NOW_SIZE )];
    line2.backgroundColor=[UIColor whiteColor];
    [_scrollView addSubview:line2];
    
    float Size1=20*NOW_SIZE;
    UILabel *PV=[[UILabel alloc]initWithFrame:CGRectMake(10*NOW_SIZE,85*NOW_SIZE+buttonSize+10*NOW_SIZE+85*NOW_SIZE+55*NOW_SIZE+95*NOW_SIZE+Size1, 300*NOW_SIZE,20*NOW_SIZE )];
    PV.text=@"设置输入SP的组串电压";
    PV.textAlignment=NSTextAlignmentLeft;
    PV.textColor=[UIColor whiteColor];
    PV.font = [UIFont systemFontOfSize:16*NOW_SIZE];
    [_scrollView addSubview:PV];
    
    UILabel *PV1=[[UILabel alloc]initWithFrame:CGRectMake(10*NOW_SIZE,85*NOW_SIZE+buttonSize+10*NOW_SIZE+85*NOW_SIZE+55*NOW_SIZE+95*NOW_SIZE+30*NOW_SIZE+Size1, 180*NOW_SIZE,20*NOW_SIZE )];
    PV1.text=@"开路电压(300~500V)：";
    PV1.textAlignment=NSTextAlignmentLeft;
    PV1.textColor=[UIColor whiteColor];
    PV1.font = [UIFont systemFontOfSize:16*NOW_SIZE];
    [_scrollView addSubview:PV1];
    
    UIView *line3=[[UIView alloc]initWithFrame:CGRectMake(200*NOW_SIZE,85*NOW_SIZE+buttonSize+10*NOW_SIZE+85*NOW_SIZE+55*NOW_SIZE+95*NOW_SIZE+50*NOW_SIZE+Size1, 110*NOW_SIZE,1*NOW_SIZE )];
    line3.backgroundColor=[UIColor whiteColor];
    [_scrollView addSubview:line3];
    
   _textField = [[UITextField alloc] initWithFrame:CGRectMake(200*NOW_SIZE,85*NOW_SIZE+buttonSize+10*NOW_SIZE+85*NOW_SIZE+55*NOW_SIZE+95*NOW_SIZE+30*NOW_SIZE+Size1, 300*NOW_SIZE,20*NOW_SIZE )];
    _textField.textColor = [UIColor whiteColor];
    _textField.tintColor = [UIColor whiteColor];
    _textField.font = [UIFont systemFontOfSize:16*NOW_SIZE];
     [_scrollView addSubview:_textField];
    
    UILabel *PV2=[[UILabel alloc]initWithFrame:CGRectMake(10*NOW_SIZE,85*NOW_SIZE+buttonSize+10*NOW_SIZE+85*NOW_SIZE+55*NOW_SIZE+95*NOW_SIZE+30*NOW_SIZE*2+Size1, 120*NOW_SIZE,20*NOW_SIZE )];
    PV2.text=@"MPP电压:";
    PV2.textAlignment=NSTextAlignmentLeft;
    PV2.textColor=[UIColor whiteColor];
    PV2.font = [UIFont systemFontOfSize:16*NOW_SIZE];
    [_scrollView addSubview:PV2];
    
    _textField1 = [[UITextField alloc] initWithFrame:CGRectMake(100*NOW_SIZE,85*NOW_SIZE+buttonSize+10*NOW_SIZE+85*NOW_SIZE+55*NOW_SIZE+95*NOW_SIZE+30*NOW_SIZE*2+Size1, 300*NOW_SIZE,20*NOW_SIZE )];
    _textField1.textColor = [UIColor whiteColor];
    _textField1.tintColor = [UIColor whiteColor];
    _textField1.font = [UIFont systemFontOfSize:16*NOW_SIZE];
    [_scrollView addSubview:_textField1];
    
    UIView *line4=[[UIView alloc]initWithFrame:CGRectMake(100*NOW_SIZE,85*NOW_SIZE+buttonSize+10*NOW_SIZE+85*NOW_SIZE+55*NOW_SIZE+95*NOW_SIZE+30*NOW_SIZE*2+20*NOW_SIZE+Size1, 200*NOW_SIZE,1*NOW_SIZE )];
    line4.backgroundColor=[UIColor whiteColor];
    [_scrollView addSubview:line4];
    
    UIButton *goBut =  [UIButton buttonWithType:UIButtonTypeCustom];
    goBut.frame=CGRectMake(60*NOW_SIZE,85*NOW_SIZE+buttonSize+10*NOW_SIZE+85*NOW_SIZE+55*NOW_SIZE+95*NOW_SIZE+30*NOW_SIZE*2+40*NOW_SIZE+Size1, 200*NOW_SIZE, 40*NOW_SIZE);
    [goBut.layer setMasksToBounds:YES];
    [goBut.layer setCornerRadius:25.0];
    [goBut setBackgroundImage:IMAGE(@"按钮2.png") forState:UIControlStateNormal];
    [goBut setTitle:@"完成" forState:UIControlStateNormal];
    [goBut addTarget:self action:@selector(finishSet1) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:goBut];

}

-(void)finishSet1{

}

#pragma mark - customSwitch delegate
-(void)switchAction:(id)sender {
    UISwitch *switchButton = (UISwitch*)sender;
    BOOL isButtonOn = [switchButton isOn];
    if (isButtonOn) {
        NSLog(@"是") ;
    }else {
        NSLog(@"否") ;
    }
}

#pragma mark - pickDate
-(void)pickDate1:(id)sender{
    float buttonSize=70*NOW_SIZE;
    UIButton *switchButton = (UIButton*)sender;
    if (switchButton.tag==1001) {
        _date=[[UIDatePicker alloc]initWithFrame:CGRectMake(0*NOW_SIZE, 85*NOW_SIZE+buttonSize+5*NOW_SIZE+55*NOW_SIZE+85*NOW_SIZE*2, SCREEN_Width, 216*NOW_SIZE)];
        _date.backgroundColor=[UIColor whiteColor];
        _date.datePickerMode=UIDatePickerModeDateAndTime;
        [self.view addSubview:_date];
    }else if(switchButton.tag==1002){
        _date1=[[UIDatePicker alloc]initWithFrame:CGRectMake(0*NOW_SIZE, 85*NOW_SIZE+buttonSize+5*NOW_SIZE+55*NOW_SIZE+85*NOW_SIZE*2, SCREEN_Width, 216*NOW_SIZE)];
        _date1.backgroundColor=[UIColor whiteColor];
        _date1.datePickerMode=UIDatePickerModeTime;
        [self.view addSubview:_date1];
    }else if(switchButton.tag==1003){
        _date2=[[UIDatePicker alloc]initWithFrame:CGRectMake(0*NOW_SIZE, 85*NOW_SIZE+buttonSize+5*NOW_SIZE+55*NOW_SIZE+85*NOW_SIZE*2, SCREEN_Width, 216*NOW_SIZE)];
        _date2.backgroundColor=[UIColor whiteColor];
        _date2.datePickerMode=UIDatePickerModeTime;
        [self.view addSubview:_date2];
    }
    
    
   
    
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
    self.currentTime1 = [self.time1Formatter stringFromDate:self.date1.date];
    [self.time1 setTitle:self.currentTime1 forState:UIControlStateNormal];
    self.currentTime2 = [self.time1Formatter stringFromDate:self.date2.date];
    [self.time2 setTitle:self.currentTime2 forState:UIControlStateNormal];
    
    [self.toolBar removeFromSuperview];
    [self.date removeFromSuperview];
    [self.date1 removeFromSuperview];
     [self.date2 removeFromSuperview];
}

-(void)controlOpen{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"警告" message:@"是否确定关闭逆变器" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
    [alertView show];
}

-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    [_textField resignFirstResponder];
    [_textField1 resignFirstResponder];
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
