//
//  addDevice.m
//  shinelink
//
//  Created by sky on 16/2/16.
//  Copyright © 2016年 sky. All rights reserved.
//

#import "addDevice.h"
#import "TempViewController.h"
#import "SHBQRView.h"

@interface addDevice ()<SHBQRViewDelegate>
@property(nonatomic,strong)UITextField *cellectId;
@property(nonatomic,strong)UITextField *cellectNo;
@end

@implementation addDevice
- (void)viewDidLoad {
    [super viewDidLoad];
    UIImage *bgImage = IMAGE(@"loginbg.jpg");
    self.view.layer.contents = (id)bgImage.CGImage;
    self.title=@"配置设备";
    
    [self initUI];
}

-(void)buttonPressed{
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationItem.title = @"配置设备";
}



-(void)initUI{
    //数据采集器序列号
    UIImageView *userBgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(40*NOW_SIZE, 90*NOW_SIZE, SCREEN_Width - 80*NOW_SIZE, 45*NOW_SIZE)];
    userBgImageView.userInteractionEnabled = YES;
    userBgImageView.image = IMAGE(@"圆角矩形空心.png");
    [self.view addSubview:userBgImageView];
    
    _cellectId = [[UITextField alloc] initWithFrame:CGRectMake(60*NOW_SIZE, 0, CGRectGetWidth(userBgImageView.frame) - 50*NOW_SIZE, 45*NOW_SIZE)];
    _cellectId.placeholder = @"请输入采集器序列号";
    _cellectId.textColor = [UIColor grayColor];
    _cellectId.tintColor = [UIColor grayColor];
    [_cellectId setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
    [_cellectId setValue:[UIFont systemFontOfSize:11*NOW_SIZE] forKeyPath:@"_placeholderLabel.font"];
    _cellectId.font = [UIFont systemFontOfSize:11*NOW_SIZE];
    [userBgImageView addSubview:_cellectId];
    
    //数据采集器效验码
    UIImageView *pwdBgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(40*NOW_SIZE, 150*NOW_SIZE, SCREEN_Width - 80*NOW_SIZE, 45*NOW_SIZE)];
    pwdBgImageView.image = IMAGE(@"圆角矩形空心.png");
    pwdBgImageView.userInteractionEnabled = YES;
    [self.view addSubview:pwdBgImageView];
    
    _cellectNo = [[UITextField alloc] initWithFrame:CGRectMake(60*NOW_SIZE, 0, CGRectGetWidth(pwdBgImageView.frame) - 50*NOW_SIZE, 45*NOW_SIZE)];
    _cellectNo.placeholder = @"请输入采集器校验码";
    _cellectNo.textColor = [UIColor grayColor];
    _cellectNo.tintColor = [UIColor grayColor];
    [_cellectNo setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
    [_cellectNo setValue:[UIFont systemFontOfSize:11*NOW_SIZE] forKeyPath:@"_placeholderLabel.font"];
    _cellectNo.font = [UIFont systemFontOfSize:11*NOW_SIZE];
    [pwdBgImageView addSubview:_cellectNo];
    
    
    
    UIButton *goBut =  [UIButton buttonWithType:UIButtonTypeCustom];
    goBut.frame=CGRectMake(40*NOW_SIZE,250*NOW_SIZE, 240*NOW_SIZE, 40*NOW_SIZE);
    [goBut.layer setMasksToBounds:YES];
    [goBut.layer setCornerRadius:25.0];
    goBut.backgroundColor = [UIColor colorWithRed:130/255.0f green:200/255.0f blue:250/255.0f alpha:1];
    [goBut setTitle:@"确定" forState:UIControlStateNormal];
    [goBut addTarget:self action:@selector(addButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:goBut];
    
    UIButton *QR=[[UIButton alloc]initWithFrame:CGRectMake(40*NOW_SIZE,400*NOW_SIZE , 240*NOW_SIZE, 60*NOW_SIZE)];
    [QR setBackgroundImage:IMAGE(@"圆角矩形.png") forState:0];
    [QR setTitle:@"扫描条形码" forState:UIControlStateNormal];
    [QR setTitleColor:COLOR(73, 135, 43, 1) forState:UIControlStateNormal];
    [QR addTarget:self action:@selector(ScanQR) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:QR];
}

-(void)ScanQR{
    // TempViewController *temp = [[TempViewController alloc] init];
    // [self.navigationController pushViewController:temp animated:true];
    
    SHBQRView *qrView = [[SHBQRView alloc] initWithFrame:self.view.bounds];
    qrView.delegate = self;
    [self.view addSubview:qrView];
}

- (void)qrView:(SHBQRView *)view ScanResult:(NSString *)result {
    [view stopScan];
    
    _cellectNo.text=[self getValidCode:result];
    NSLog(@"_cellectNo.text=%@",_cellectNo.text);
    _cellectId.text=result;
    NSLog(@"_cellectId.text=%@",_cellectId.text);
    
    [self showProgressView];
    
    NSMutableDictionary *userCheck=[NSMutableDictionary dictionaryWithObject:_cellectId.text forKey:@"dataLogSn"];
    [userCheck setObject:_cellectNo.text forKey:@"validateCode"];
    [BaseRequest requestWithMethod:HEAD_URL paramars:userCheck  paramarsSite:@"/newDatalogAPI.do?op=addDatalog" sucessBlock:^(id content) {
        NSLog(@"addDatalog: %@", content);
        [self hideProgressView];
        if (content) {
            if ([content[@"success"] integerValue] == 0) {
                if ([content[@"msg"] integerValue] ==501) {
                    [self showAlertViewWithTitle:nil message:@"添加失败，系统错误" cancelButtonTitle:root_Yes];
                }
                else if ([content[@"msg"] integerValue] ==502) {
                    [self showAlertViewWithTitle:nil message:@"权限不够" cancelButtonTitle:root_Yes];
                }
                else if ([content[@"msg"] integerValue] ==503) {
                    [self showAlertViewWithTitle:nil message:@"采集器序列号或电站ID错误" cancelButtonTitle:root_Yes];
                } else if ([content[@"msg"] integerValue] ==504) {
                    [self showAlertViewWithTitle:nil message:@"总体采集器数量超出限制" cancelButtonTitle:root_Yes];
                } else if ([content[@"msg"] integerValue] ==505) {
                    [self showAlertViewWithTitle:nil message:@"单个电站采集器数量超出限制" cancelButtonTitle:root_Yes];
                } else if ([content[@"msg"] integerValue] ==506) {
                    [self showAlertViewWithTitle:nil message:@"采集器序列号已经存在" cancelButtonTitle:root_Yes];
                } else if ([content[@"msg"] integerValue] ==507) {
                    [self showAlertViewWithTitle:nil message:@"序列号与校验码不匹配" cancelButtonTitle:root_Yes];
                }
            }else{
                if ([content[@"msg"] integerValue] ==200){
                    [self showAlertViewWithTitle:nil message:@"设备添加成功" cancelButtonTitle:root_Yes];}
                [[NSNotificationCenter defaultCenter] postNotificationName:@"changeName" object:nil];
                [self.navigationController popToRootViewControllerAnimated:YES];
            }
        }
    }failure:^(NSError *error) {
        [self hideProgressView];
        [self showToastViewWithTitle:root_Networking];
    }];
    
}

-(void)delButtonPressed{
    [self.navigationController popViewControllerAnimated:YES];
}

-(NSString*)getValidCode:(NSString*)serialNum{
    if (serialNum==NULL||serialNum==nil) {
        return @"";
    }
    NSData *testData = [serialNum dataUsingEncoding: NSUTF8StringEncoding];
    int sum=0;
    
    Byte *snBytes=(Byte*)[testData bytes];
    
    for(int i=0;i<[testData length];i++)
    {
        sum+=snBytes[i];
    }
    NSInteger B=sum%8;
    NSString *B1= [NSString stringWithFormat: @"%d", B];
    int C=sum*sum;
    
    NSString *text = [NSString stringWithFormat:@"%@",[[NSString alloc] initWithFormat:@"%1x",C]];
    int length = [text length];
    NSString *resultTemp;
    NSString *resultTemp3;
    NSString *resultTemp1=[text substringWithRange:NSMakeRange(0, 2)];
    NSString *resultTemp2=[text substringWithRange:NSMakeRange(length - 2, 2)];
    
    resultTemp3= [resultTemp1 stringByAppendingString:resultTemp2];
    resultTemp=[resultTemp3 stringByAppendingString:B1];
    
    NSString *result = @"";
    
    char *charArray = [resultTemp cStringUsingEncoding:NSASCIIStringEncoding];
    for (int i=0; i<[resultTemp length]; i++) {
        if (charArray[i]==0x30||charArray[i]==0x4F||charArray[i]==0x4F) {
            charArray[i]++;
        }
        result=[result stringByAppendingFormat:@"%c",charArray[i]];
    }
    
    
    return [result uppercaseString];
    
}



-(void)addButtonPressed{
    if ([_cellectId.text isEqual:@""]) {
        [self showAlertViewWithTitle:nil message:@"请输入正确的采集器序列号" cancelButtonTitle:@"确定"];
        return;
    }
    if ([_cellectNo.text isEqual:@""]) {
        [self showAlertViewWithTitle:nil message:@"请输入正确的采集器校验码" cancelButtonTitle:@"确定"];
        return;
    }
    [self showProgressView];
    NSMutableDictionary *userCheck=[NSMutableDictionary dictionaryWithObject:_cellectId.text forKey:@"datalogSN"];
    [userCheck setObject:_cellectNo.text forKey:@"validCode"];
    [userCheck setObject:[[NSUserDefaults standardUserDefaults]objectForKey:@"plantID"] forKey:@"plantId"];
    
    [BaseRequest requestWithMethodResponseStringResult:HEAD_URL paramars:userCheck  paramarsSite:@"/newDatalogAPI.do?op=addDatalog" sucessBlock:^(id content) {
        [self hideProgressView];
        NSLog(@"addDatalog: %@", content);
          id jsonObj = [NSJSONSerialization JSONObjectWithData:content options:NSJSONReadingAllowFragments error:nil];
        if (content) {
            if ([[jsonObj objectForKey:@"success"] integerValue] ==0) {
                if ([[jsonObj objectForKey:@"msg"]integerValue]==501) {
                    [self showAlertViewWithTitle:nil message:@"添加失败，系统错误" cancelButtonTitle:root_Yes];
                }
                else if ([[jsonObj objectForKey:@"msg"]integerValue]==502) {
                    [self showAlertViewWithTitle:nil message:@"权限不够" cancelButtonTitle:root_Yes];
                }
                else if ([[jsonObj objectForKey:@"msg"]integerValue]==503) {
                    [self showAlertViewWithTitle:nil message:@"采集器序列号或电站ID错误" cancelButtonTitle:root_Yes];
                } else if ([[jsonObj objectForKey:@"msg"]integerValue]==504) {
                    [self showAlertViewWithTitle:nil message:@"总体采集器数量超出限制" cancelButtonTitle:root_Yes];
                } else if ([[jsonObj objectForKey:@"msg"]integerValue]==505) {
                    [self showAlertViewWithTitle:nil message:@"单个电站采集器数量超出限制" cancelButtonTitle:root_Yes];
                } else if ([[jsonObj objectForKey:@"msg"]integerValue]==506) {
                    [self showAlertViewWithTitle:nil message:@"采集器序列号已经存在" cancelButtonTitle:root_Yes];
                } else if ([[jsonObj objectForKey:@"msg"]integerValue]==507) {
                    [self showAlertViewWithTitle:nil message:@"序列号与校验码不匹配" cancelButtonTitle:root_Yes];
                }
            }else{
                if ([[jsonObj objectForKey:@"msg"]integerValue]==200){
                    [self showAlertViewWithTitle:nil message:@"设备添加成功" cancelButtonTitle:root_Yes];}
                
            }
        }
    }failure:^(NSError *error) {
        [self hideProgressView];
        [self showToastViewWithTitle:root_Networking];
    }];
    
    
    
    
}

@end
