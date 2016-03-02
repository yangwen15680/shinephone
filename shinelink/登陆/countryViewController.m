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


@interface countryViewController ()<UINavigationControllerDelegate>
@property(nonatomic,strong)UILabel *label;
@property (nonatomic, strong) NSMutableDictionary *dataDic;

@end

@implementation countryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
      self.dataDic = [NSMutableDictionary dictionary];
    
    UIImage *bgImage = IMAGE(@"loginbg.jpg");
    self.view.layer.contents = (id)bgImage.CGImage;

    [self.navigationController setNavigationBarHidden:NO];
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"loginbg.jpg"]]];
    
    // Do any additional setup after loading the view.
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(30*NOW_SIZE,202*NOW_SIZE, 22*NOW_SIZE, 22*NOW_SIZE)];
    imageView.contentMode=UIViewContentModeScaleAspectFit;
    imageView.clipsToBounds=YES;
    imageView.image=[UIImage imageNamed:@"语言.png"];
    [self.view addSubview:imageView];
    
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(60*NOW_SIZE,198*NOW_SIZE, 50*NOW_SIZE, 30*NOW_SIZE)];
    label.text=@"国家:";
    label.font = [UIFont systemFontOfSize:20*NOW_SIZE];
    label.textColor=[UIColor whiteColor];
    [self.view addSubview:label];
    
    UIView *line=[[UIView alloc]initWithFrame:CGRectMake(30*NOW_SIZE,240*NOW_SIZE, 260*NOW_SIZE, 0.5)];
    line.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:line];
    
  _label=[[UILabel alloc]initWithFrame:CGRectMake(110*NOW_SIZE,199*NOW_SIZE, 180*NOW_SIZE, 30*NOW_SIZE)];
    _label.text =@"请点击选择国家";
    _label.textColor = [UIColor colorWithRed:130/255.0f green:200/255.0f blue:250/255.0f alpha:1];
    //textField.tintColor = [UIColor whiteColor];
    _label.textAlignment = NSTextAlignmentRight;
    _label.font = [UIFont systemFontOfSize:16*NOW_SIZE];
    [self.view addSubview:_label];
    _label.userInteractionEnabled=YES;
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pickadress)];
    [_label addGestureRecognizer:tap];
    
   
    
    UIButton *goBut =  [UIButton buttonWithType:UIButtonTypeCustom];
    goBut.frame=CGRectMake(60*NOW_SIZE,280*NOW_SIZE, 200*NOW_SIZE, 40*NOW_SIZE);
    [goBut.layer setMasksToBounds:YES];
    [goBut.layer setCornerRadius:25.0];
    goBut.backgroundColor = [UIColor colorWithRed:130/255.0f green:200/255.0f blue:250/255.0f alpha:1];
    [goBut setTitle:@"下一步" forState:UIControlStateNormal];
    [goBut addTarget:self action:@selector(PresentGo) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:goBut];
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
    NSString *city=[self.dataDic objectForKey:@"regCountry"];
    if (city == nil || city == NULL) {
        [self showToastViewWithTitle:@"请选择国家和城市"];
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
    AddressPickView *addressPickView = [AddressPickView shareInstance];
    [self.view addSubview:addressPickView];
    addressPickView.block = ^(NSString *province,NSString *city,NSString *town){
        [self.dataDic setObject:city forKey:@"regCountry"];
        [self.dataDic setObject:town forKey:@"regCity"];
        _label.text = [NSString stringWithFormat:@"%@ %@ %@",province,city,town] ;
        
    };

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
