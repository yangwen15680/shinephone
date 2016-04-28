//
//  StationLocationViewController.m
//  ShinePhone
//
//  Created by ZML on 15/5/27.
//  Copyright (c) 2015年 binghe168. All rights reserved.
//

#import "StationLocationViewController.h"



@interface StationLocationViewController ()
@property(nonatomic,strong)NSMutableArray *textFieldMutableArray;
@property(nonatomic,strong)NSMutableArray *timeZone;
@property(nonatomic,strong)NSString *lat;
@property(nonatomic,strong)NSString *lng;
@property (nonatomic, strong) UIView *readView;
@property (nonatomic, strong) UIView *writeView;
@property (nonatomic, strong) UIView *buttonView;
@property (nonatomic, strong) UIButton *goBut;

@end

@implementation StationLocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImage *bgImage = IMAGE(@"bg4.png");
    self.view.layer.contents = (id)bgImage.CGImage;
    
    self.navigationItem.title=@"地理信息";
    [self requestData];
}


//rightBarButtonItem上变成取消
-(void)barButtonPressed:(UIBarButtonItem *)sender{
    //4.根据是否为浏览用户(登录接口返回参数判断)，屏蔽添加电站、添加采集器、修改电站信息功能，给予提示(浏览用户禁止操作)。
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"isDemo"] isEqualToString:@"isDemo"]) {
        [self showAlertViewWithTitle:nil message:NSLocalizedString(@"Browse user prohibited operation", @"Browse user prohibited operation") cancelButtonTitle:root_Yes];
        return;
    }
    if ([sender.title isEqual:NSLocalizedString(@"Edit", @"Edit")]) {
        [sender setTitle:root_Cancel];
        [_readView removeFromSuperview];
        _readView=nil;
        [self writeUI];
    }else{
        [sender setTitle:NSLocalizedString(@"Edit", @"Edit")];
        [self readUI];
        [_writeView removeFromSuperview];
        _writeView=nil;
        [_buttonView removeFromSuperview];
        _goBut=nil;
    }
    
}

//请求数据
-(void)requestData{
    
    [BaseRequest requestWithMethodResponseJsonByGet:HEAD_URL paramars:@{@"plantId":[UserInfo defaultUserInfo].plantID} paramarsSite:@"/newPlantAPI.do?op=getPlant" sucessBlock:^(id content) {
        NSLog(@"getPlant:%@",content);
        _dict=[NSDictionary new];
        _dict=content;
        [self initUI];
        [self readUI];
    } failure:^(NSError *error) {
        
    }];
}

-(void)initUI{    
    UIBarButtonItem *rightItem=[[UIBarButtonItem alloc]initWithTitle:NSLocalizedString(@"Edit", @"Edit") style:UIBarButtonItemStylePlain target:self action:@selector(barButtonPressed:)];
    self.navigationItem.rightBarButtonItem=rightItem;

    NSArray *array=[[NSArray alloc]initWithObjects:@"国家",@"城市",@"时区",@"经度",@"纬度", nil];
    
    for (int i=0; i<5; i++) {
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(40*NOW_SIZE, (10+i*40)*NOW_SIZE, 120*NOW_SIZE, 40*NOW_SIZE)];
        label.text=array[i];
        label.font=[UIFont systemFontOfSize:11*NOW_SIZE];
        label.textColor=[UIColor whiteColor];
        [self.view addSubview:label];
    }
}


-(void)readUI{
    _readView=[[UIView alloc]initWithFrame:CGRectMake(160*NOW_SIZE, 10*NOW_SIZE, 140*NOW_SIZE, 210*NOW_SIZE)];
    [self.view addSubview:_readView];
    NSString *timezone=[NSString stringWithFormat:@"%@",_dict[@"timezone"]];
    NSString *plant_lat=[NSString stringWithFormat:@"%@",_dict[@"plant_lat"]];
      NSString *plant_lng=[NSString stringWithFormat:@"%@",_dict[@"plant_lng"]];
    NSArray *array=[[NSArray alloc]initWithObjects:_dict[@"country"],_dict[@"city"],timezone,plant_lat,plant_lng,nil];
    for (int i=0; i<5; i++) {
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0*NOW_SIZE, (0+i*40)*NOW_SIZE, 120*NOW_SIZE, 40*NOW_SIZE)];
        label.text=array[i];
        label.font=[UIFont systemFontOfSize:14*NOW_SIZE];
        label.textColor=[UIColor whiteColor];
        [_readView addSubview:label];
    }
    
}


-(void)writeUI{
    
    _timeZone=[NSMutableArray arrayWithObjects:@"+1",@"+2",@"+3",@"+4",@"+5",@"+6",@"+7",@"+8",@"+9",@"+10",@"+11",@"+12",@"-1",@"-2",@"-3",@"-4",@"-5",@"-6",@"-7",@"-8",@"-9",@"-10",@"-11",@"-12", nil];
    _writeView=[[UIView alloc]initWithFrame:CGRectMake(160*NOW_SIZE, 10*NOW_SIZE, 140*NOW_SIZE, 210*NOW_SIZE)];
    [self.view addSubview:_writeView];
    _textFieldMutableArray=[NSMutableArray new];
//    NSRange timerange=[_dict[@"timeZone"] rangeOfString:@"T"];
//    NSRange timeNewRange={timerange.location+1,[_dict[@"timeZone"] length]-timerange.location-1};
//    NSString *timeString=[_dict[@"timeZone"] substringWithRange:timeNewRange];
    NSString *timezone=[NSString stringWithFormat:@"%@",_dict[@"timezone"]];
    NSString *plant_lat=[NSString stringWithFormat:@"%@",_dict[@"plant_lat"]];
    NSString *plant_lng=[NSString stringWithFormat:@"%@",_dict[@"plant_lng"]];
    NSArray *array=[[NSArray alloc]initWithObjects:_dict[@"country"],_dict[@"city"],timezone,plant_lat,plant_lng, nil];
    for (int i=0; i<5; i++) {
        UITextField *textField=[[UITextField alloc]initWithFrame:CGRectMake(0*NOW_SIZE, (5+i*40)*NOW_SIZE, 100*NOW_SIZE, 30*NOW_SIZE)];
        textField.text=array[i];
        textField.layer.borderWidth=0.5;
        textField.layer.cornerRadius=5;
        textField.layer.borderColor=[UIColor whiteColor].CGColor;
        textField.tintColor = [UIColor whiteColor];
        [textField setValue:[UIColor lightTextColor] forKeyPath:@"_placeholderLabel.textColor"];
        [textField setValue:[UIFont systemFontOfSize:14*NOW_SIZE] forKeyPath:@"_placeholderLabel.font"];
        textField.font=[UIFont systemFontOfSize:14*NOW_SIZE];
        textField.textColor=[UIColor whiteColor];
        if (i==0) {
            textField.tag=1000;
        }else if(i==2){
            textField.tag=5000;
        }else{
            textField.tag=i;
        }
        //textField.delegate=_pickerView;
        [_writeView addSubview:textField];
        [_textFieldMutableArray addObject:textField];
    }
    
    UIButton *latButton=[[UIButton alloc]initWithFrame:CGRectMake(105*NOW_SIZE, 130*NOW_SIZE, 50*NOW_SIZE, 20*NOW_SIZE)];
    [latButton setBackgroundImage:IMAGE(@"圆角矩形.png") forState:UIControlStateNormal];
    [latButton setTitle:@"" forState:UIControlStateNormal];
    latButton.titleLabel.font=[UIFont systemFontOfSize:11*NOW_SIZE];
    [latButton setTitleColor:COLOR(82, 201, 194, 1) forState:0];
    latButton.tag=1;
    [latButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [_writeView addSubview:latButton];
    
    UIButton *lngButton=[[UIButton alloc]initWithFrame:CGRectMake(105*NOW_SIZE, 170*NOW_SIZE, 50*NOW_SIZE, 20*NOW_SIZE)];
    [lngButton setBackgroundImage:IMAGE(@"按钮2.png") forState:UIControlStateNormal];
    [lngButton setTitle:@"点击获取" forState:UIControlStateNormal];
    lngButton.titleLabel.font=[UIFont systemFontOfSize:11*NOW_SIZE];
    [lngButton setTitleColor:COLOR(82, 201, 194, 1) forState:0];
    lngButton.tag=2;
    [lngButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [_writeView addSubview:lngButton];
    

    
    _goBut =  [UIButton buttonWithType:UIButtonTypeCustom];
    _goBut.frame=CGRectMake(60*NOW_SIZE,300*NOW_SIZE, 200*NOW_SIZE, 40*NOW_SIZE);
    [_goBut.layer setMasksToBounds:YES];
    [_goBut.layer setCornerRadius:25.0];
    [_goBut setBackgroundImage:IMAGE(@"按钮2.png") forState:UIControlStateNormal];
    [_goBut setTitle:@"完成" forState:UIControlStateNormal];
    [_goBut addTarget:self action:@selector(addButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_goBut];
}



-(void)buttonPressed:(UIButton *)sender{
    if (sender.tag==1) {
        UIView *view=[self.view viewWithTag:3];
        UITextField *textField=(UITextField *)view;
        textField.text=_lat;
    }
    if (sender.tag==2) {
        UIView *view=[self.view viewWithTag:4];
        UITextField *textField=(UITextField *)view;
        textField.text=_lng;
    }
}



-(void)delButtonPressed{
    [self.navigationController popViewControllerAnimated:YES];
}



-(void)addButtonPressed{
    NSArray *array=[[NSArray alloc]initWithObjects:NSLocalizedString(@"Country can not be empty", @"Country can not be empty"),
                    NSLocalizedString(@"City can not be empty", @"City can not be empty"),
                    NSLocalizedString(@"Time Zone can not be empty", @"Time Zone can not be empty"),
                    NSLocalizedString(@"longitude can not be empty", @"longitude can not be empty"),
                    NSLocalizedString(@"latitude can not be empty", @"latitude can not be empty"),nil];
    for (int i=0; i<5; i++) {
        if ([[_textFieldMutableArray[i] text] isEqual:@""]) {
            [self showToastViewWithTitle:array[i]];
            return;
        }
    }
    NSRange range=[_dict[@"normalPower"] rangeOfString:@" "];
    NSRange newRange={0,range.location};
    NSString *string=[_dict[@"normalPower"] substringWithRange:newRange];
    NSDictionary *dict=@{@"plantID":_stationId,
                         @"plantName":_dict[@"plantName"],
                         @"plantDate":_dict[@"createData"],
                         @"plantFirm":_dict[@"designCompany"],
                         @"plantPower":string,
                         @"plantCountry":[_textFieldMutableArray[0] text],
                         @"plantCity":[_textFieldMutableArray[1] text],
                         @"plantTimezone":[_textFieldMutableArray[2] text],
                         @"plantLat":[_textFieldMutableArray[3] text],
                         @"plantLng":[_textFieldMutableArray[4] text],
                         @"plantIncome":_dict[@"formulaMoney"],
                         @"plantMoney":_dict[@"formulaMoneyUnit"],
                         @"plantCoal":_dict[@"formulaCoal"],
                         @"plantCo2":_dict[@"formulaCo2"],
                         @"plantSo2":_dict[@"formulaSo2"],};
    [self showProgressView];
    [BaseRequest uplodImageWithMethod:HEAD_URL paramars:dict paramarsSite:@"/plantA.do?op=update" dataImageDict:nil sucessBlock:^(id content) {
        [self hideProgressView];
        NSLog(@"testtest: %@", content);
        id jsonObj = [NSJSONSerialization JSONObjectWithData:content options:NSJSONReadingAllowFragments error:nil];
        if ([jsonObj integerValue]==1) {
            [self showAlertViewWithTitle:nil message:NSLocalizedString(@"Successfully modified", @"Successfully modified") cancelButtonTitle:root_Yes];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [self showAlertViewWithTitle:nil message:NSLocalizedString(@"Modification fails", @"Modification fails") cancelButtonTitle:root_Yes];
        }
    } failure:^(NSError *error) {
        [self hideProgressView];
        [self showToastViewWithTitle:root_Networking];
    }];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
  
    for (UITextField *textField in _textFieldMutableArray) {
        [textField resignFirstResponder];
    }
}

@end
