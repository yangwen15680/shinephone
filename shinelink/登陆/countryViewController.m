//
//  countryViewController.m
//  shinelink
//
//  Created by sky on 16/2/23.
//  Copyright © 2016年 sky. All rights reserved.
//

#import "countryViewController.h"
#import "AddressPickView.h"
#import "loginViewController.h"
#import "registerViewController.h"
#import "SNLocationManager.h"

@interface countryViewController ()<UINavigationControllerDelegate>
@property(nonatomic,strong)UILabel *label;
@property(nonatomic,strong)UILabel *label2;
@property (nonatomic, strong) NSMutableDictionary *dataDic;
@property(nonatomic,strong)NSMutableArray *countryArray;
@property(nonatomic,strong)NSString *latitude;//纬度
@property(nonatomic,strong)NSString *longitude;
@property(nonatomic,strong)NSString *city;
@property(nonatomic,strong)NSString *country;
@property(nonatomic,strong)NSMutableArray *provinceArray;

@end

@implementation countryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self _getPickerData];
      self.dataDic = [NSMutableDictionary dictionary];
    
    UIImage *bgImage = IMAGE(@"bg.png");
    self.view.layer.contents = (id)bgImage.CGImage;

    [self.navigationController setNavigationBarHidden:NO];
     [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.png"]]];

    // Do any additional setup after loading the view.
//    UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(30*NOW_SIZE,202*NOW_SIZE, 22*NOW_SIZE, 22*NOW_SIZE)];
//    imageView.contentMode=UIViewContentModeScaleAspectFit;
//    imageView.clipsToBounds=YES;
//    imageView.image=[UIImage imageNamed:@"语言.png"];
//    [self.view addSubview:imageView];
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(30*NOW_SIZE,198*NOW_SIZE-50*NOW_SIZE, 80*NOW_SIZE, 30*NOW_SIZE)];
    label.text=root_country;
    label.font = [UIFont systemFontOfSize:16*NOW_SIZE];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor=[UIColor whiteColor];
    [self.view addSubview:label];
    
//    UIView *line=[[UIView alloc]initWithFrame:CGRectMake(30*NOW_SIZE,240*NOW_SIZE-50*NOW_SIZE, 260*NOW_SIZE, 0.5)];
//    line.backgroundColor=[UIColor whiteColor];
//    [self.view addSubview:line];
    
    _label=[[UILabel alloc]initWithFrame:CGRectMake(110*NOW_SIZE,199*NOW_SIZE-50*NOW_SIZE, 180*NOW_SIZE, 30*NOW_SIZE)];
    _label.layer.borderWidth=1;
    _label.layer.cornerRadius=5;
    _label.layer.borderColor=[UIColor whiteColor].CGColor;
    _label.text =root_country_alet;
    _label.textColor = [UIColor whiteColor];
    //textField.tintColor = [UIColor whiteColor];
    _label.textAlignment = NSTextAlignmentCenter;
    _label.font = [UIFont systemFontOfSize:16*NOW_SIZE];
    [self.view addSubview:_label];
    _label.userInteractionEnabled=YES;
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pickadress)];
    [_label addGestureRecognizer:tap];
    
    UILabel *label2=[[UILabel alloc]initWithFrame:CGRectMake(30*NOW_SIZE,198*NOW_SIZE, 80*NOW_SIZE, 30*NOW_SIZE)];
    label2.text=root_weiZhi;
    label2.font = [UIFont systemFontOfSize:16*NOW_SIZE];
     label2.textAlignment = NSTextAlignmentCenter;
    label2.textColor=[UIColor whiteColor];
    [self.view addSubview:label2];
    
//    UIView *line2=[[UIView alloc]initWithFrame:CGRectMake(30*NOW_SIZE,240*NOW_SIZE, 260*NOW_SIZE, 0.5)];
//    line2.backgroundColor=[UIColor whiteColor];
//    [self.view addSubview:line2];
    
  _label2=[[UILabel alloc]initWithFrame:CGRectMake(110*NOW_SIZE,199*NOW_SIZE, 180*NOW_SIZE, 30*NOW_SIZE)];
    _label2.layer.borderWidth=1;
    _label2.layer.cornerRadius=5;
    _label2.layer.borderColor=[UIColor whiteColor].CGColor;
    _label2.text =root_weiZhi_tiShi;
    _label2.textColor = [UIColor whiteColor];
    //textField.tintColor = [UIColor whiteColor];
    _label2.textAlignment = NSTextAlignmentCenter;
    _label2.font = [UIFont systemFontOfSize:16*NOW_SIZE];
    [self.view addSubview:_label2];
    _label2.userInteractionEnabled=YES;
    UITapGestureRecognizer *tap2=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(fetchLocation)];
    [_label2 addGestureRecognizer:tap2];
    
   
    
    UIButton *goBut =  [UIButton buttonWithType:UIButtonTypeCustom];
    goBut.frame=CGRectMake(60*NOW_SIZE,280*NOW_SIZE, 200*NOW_SIZE, 40*NOW_SIZE);
    [goBut.layer setMasksToBounds:YES];
    [goBut.layer setCornerRadius:20.0];
       [goBut setBackgroundImage:IMAGE(@"按钮2.png") forState:UIControlStateNormal];
  
    [goBut setTitle:root_next_go forState:UIControlStateNormal];
    [goBut addTarget:self action:@selector(PresentGo) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:goBut];
}

- (void)_getPickerData
{
    _provinceArray=[NSMutableArray array];
    [self showProgressView];
    [BaseRequest requestWithMethodResponseJsonByGet:HEAD_URL paramars:@{@"admin":@"admin"} paramarsSite:@"/newCountryCityAPI.do?op=getCountryCity" sucessBlock:^(id content) {
        
        NSLog(@"getCountryCity: %@", content);
        if (content) {
            NSArray *dataDic=[NSArray arrayWithArray:content];
            if (dataDic.count>0) {
                for (int i=0; i<dataDic.count; i++) {
                    NSString *DY=[NSString stringWithFormat:@"%@",content[i][@"country"]];
                    [ _provinceArray addObject:DY];
                }
                [self hideProgressView];
            }
            
            [_provinceArray sortUsingComparator:^NSComparisonResult(__strong id obj1,__strong id obj2){
                NSString *str1=(NSString *)obj1;
                NSString *str2=(NSString *)obj2;
                return [str1 compare:str2];
            }];
        }else{
        [self hideProgressView];
        }
        
    } failure:^(NSError *error) {
        [self hideProgressView];
        
    }];
    
}


-(void)fetchLocation{
    [[SNLocationManager shareLocationManager] startUpdatingLocationWithSuccess:^(CLLocation *location, CLPlacemark *placemark) {
        _longitude=[NSString stringWithFormat:@"%.2f", location.coordinate.longitude];
        _latitude=[NSString stringWithFormat:@"%.2f", location.coordinate.latitude];
        _city=placemark.locality;
        
        NSString *lableText=[NSString stringWithFormat:@"%@(%@,%@)",_city,_longitude,_latitude];
        _label2.text =lableText;
        
    } andFailure:^(CLRegion *region, NSError *error) {
        
    }];

}


- (void)showToastViewWithTitle:(NSString *)title {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.animationType = MBProgressHUDAnimationZoom;
    hud.labelText = title;
    hud.margin = 10.f;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:1.5];
}

-(void)PresentGo{
    
 
    if (_country == nil || _country == NULL){
        [_dataDic setObject:@"" forKey:@"regCountry"];
    }else{
          [_dataDic setObject:_country forKey:@"regCountry"];
    }
    if (_city == nil || _city == NULL){
        [_dataDic setObject:@"" forKey:@"regCity"];
    }else{
     [_dataDic setObject:_city forKey:@"regCity"];
    }
    if (_longitude == nil || _longitude == NULL){
        [_dataDic setObject:@"" forKey:@"regLng"];
    }else{
        [_dataDic setObject:_longitude forKey:@"regLng"];
    }
    if (_latitude == nil || _latitude == NULL){
        [_dataDic setObject:@"" forKey:@"regLat"];
    }else{
        [_dataDic setObject:_latitude forKey:@"regLat"];
    }
    
    
    NSString *city=[self.dataDic objectForKey:@"regCountry"];
    if (city.length==0) {
        [self showToastViewWithTitle:root_country_kong];
        return;
    }
    
 registerViewController *reg=[[registerViewController alloc]initWithDataDict:_dataDic];
    [self. navigationController pushViewController:reg animated:YES];
}

-(void)Presentback{
    loginViewController *log=[[loginViewController alloc]init];
    
    [self presentViewController:log animated:YES completion:nil];
    
}

-(void)pickadress{
    if(_provinceArray.count>0){
    AddressPickView *addressPickView = [AddressPickView shareInstance];
    addressPickView.provinceArray=_provinceArray;
    [self.view addSubview:addressPickView];
    addressPickView.block = ^(NSString *province){
       // [self.dataDic setObject:city forKey:@"regCountry"];
       // [self.dataDic setObject:town forKey:@"regCity"];
        _label.text = [NSString stringWithFormat:@"%@",province] ;
        _country=province;
    };
    }else{
        [self showToastViewWithTitle:root_country_huoQu];
        return;
    
    }
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
