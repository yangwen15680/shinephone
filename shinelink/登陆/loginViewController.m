//
//  loginViewController.m
//  shinelink
//
//  Created by sky on 16/2/18.
//  Copyright © 2016年 sky. All rights reserved.
//

#import "loginViewController.h"
#import "LoginButton.h"
#import "StTransitions.h"
#import "findViewController.h"
#import "energyViewController.h"
#import "deviceViewController.h"
#import "meViewController.h"
#import "registerViewController.h"
#import "countryViewController.h"
#import "UserInfo.h"
#import <CommonCrypto/CommonDigest.h>
#import "MBProgressHUD.h"
#import "forgetViewController.h"

@interface loginViewController ()<UINavigationControllerDelegate>
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UITextField *userTextField;
@property (nonatomic, strong) UITextField *pwdTextField;
//@property (nonatomic, strong) UIButton *loginButton;
@property (nonatomic, strong) UIButton *registButton;
@property (nonatomic, strong) UILabel *registLable;
@property (nonatomic, strong) UILabel *forgetLable;
@property (nonatomic, strong) NSDictionary *dataSource;

@end

@implementation loginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIImage *bgImage = IMAGE(@"loginbg.jpg");
    self.view.layer.contents = (id)bgImage.CGImage;
  
       //[self.navigationController setNavigationBarHidden:YES];
    
 NSUserDefaults *ud=[NSUserDefaults standardUserDefaults];
   NSString *reUsername=[ud objectForKey:@"userName"];
   NSString *rePassword=[ud objectForKey:@"userPassword"];
 //  [self addSubViews];
    
   // NSString *reUsername=@"123";
    //NSString *rePassword=@"234";
    
    NSLog(@"reUsername=%@",reUsername);
    NSLog(@"rePassword=%@",rePassword);
    if (reUsername==nil || reUsername==NULL||[reUsername isEqual:@""]) {
        [self addSubViews];
        // didPresentControllerButtonTouch
    }else{
        [_userTextField setText:[NSString stringWithString:reUsername]];
       // _userTextField.text=[ud objectForKey:@"userName"];;
     // _pwdTextField.text=rePassword;
      //  [self didPresentControllerButtonTouch];
          [self performSelectorOnMainThread:@selector(didPresentControllerButtonTouch) withObject:nil waitUntilDone:NO];
        //添加布局
    }
}

//添加布局
- (void)addSubViews {

    _scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Height)];
    [self.view addSubview:_scrollView];
    
    //logo
    UIImageView *logo = [[UIImageView alloc] initWithFrame:CGRectMake(20*NOW_SIZE, 60*NOW_SIZE, SCREEN_Width - 40*NOW_SIZE, 60*NOW_SIZE)];
    logo.image = IMAGE(@"icon_logo.png");
    [_scrollView addSubview:logo];
    
    //用户名
    UIImageView *userBgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(40*NOW_SIZE, 60*NOW_SIZE+60*NOW_SIZE+30*NOW_SIZE, SCREEN_Width - 80*NOW_SIZE, 45*NOW_SIZE)];
    userBgImageView.userInteractionEnabled = YES;
    userBgImageView.image = IMAGE(@"账号3.png");
    [_scrollView addSubview:userBgImageView];
    
    self.userTextField = [[UITextField alloc] initWithFrame:CGRectMake(50*NOW_SIZE, 0, CGRectGetWidth(userBgImageView.frame) - 50*NOW_SIZE, 45*NOW_SIZE)];
    self.userTextField.placeholder = root_Enter_your_username;
    self.userTextField.textColor = [UIColor whiteColor];
    self.userTextField.tintColor = [UIColor whiteColor];
    [self.userTextField setValue:[UIColor lightTextColor] forKeyPath:@"_placeholderLabel.textColor"];
    [self.userTextField setValue:[UIFont systemFontOfSize:13*NOW_SIZE] forKeyPath:@"_placeholderLabel.font"];
    self.userTextField.font = [UIFont systemFontOfSize:15*NOW_SIZE];
    [userBgImageView addSubview:_userTextField];
    
    //密码
    UIImageView *pwdBgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(40*NOW_SIZE, 60*NOW_SIZE+60*NOW_SIZE+30*NOW_SIZE+45*NOW_SIZE+20*NOW_SIZE, SCREEN_Width - 80*NOW_SIZE, 45*NOW_SIZE)];
    pwdBgImageView.image = IMAGE(@"密码3.png");
    pwdBgImageView.userInteractionEnabled = YES;
    [_scrollView addSubview:pwdBgImageView];
    
    self.pwdTextField = [[UITextField alloc] initWithFrame:CGRectMake(50*NOW_SIZE, 0, CGRectGetWidth(pwdBgImageView.frame) - 50*NOW_SIZE, 45*NOW_SIZE)];
    self.pwdTextField.placeholder = root_Enter_your_pwd;
    self.pwdTextField.keyboardType = UIKeyboardTypeASCIICapable;
    self.pwdTextField.secureTextEntry = YES;
    self.pwdTextField.textColor = [UIColor whiteColor];
    self.pwdTextField.tintColor = [UIColor whiteColor];
    [self.pwdTextField setValue:[UIColor lightTextColor] forKeyPath:@"_placeholderLabel.textColor"];
    [self.pwdTextField setValue:[UIFont systemFontOfSize:13*NOW_SIZE] forKeyPath:@"_placeholderLabel.font"];
    [pwdBgImageView addSubview:_pwdTextField];
    
 

    LoginButton *loginBtn = [[LoginButton alloc] initWithFrame:CGRectMake(40*NOW_SIZE, 420*NOW_SIZE-70*NOW_SIZE, SCREEN_Width - 80*NOW_SIZE, 45*NOW_SIZE)];
    loginBtn.backgroundColor = [UIColor colorWithRed:130/255.0f green:200/255.0f blue:250/255.0f alpha:1];
    [self.view addSubview:loginBtn];
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [loginBtn addTarget:self action:@selector(PresentCtrl:) forControlEvents:UIControlEventTouchUpInside];
    
    self.registLable= [[UILabel alloc] initWithFrame:CGRectMake(230*NOW_SIZE, 420*NOW_SIZE, 40*NOW_SIZE, 30*NOW_SIZE)];
    self.registLable.text=@"注册";
    self.registLable.textColor=[UIColor whiteColor];
    self.registLable.textAlignment = NSTextAlignmentRight;
     self.registLable.font = [UIFont systemFontOfSize:16*NOW_SIZE];
    self.registLable.userInteractionEnabled=YES;
     [self.view addSubview:self.registLable];
    UITapGestureRecognizer * labelTap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapLable)];
    [self.registLable addGestureRecognizer:labelTap];
   
    
    
    self.forgetLable= [[UILabel alloc] initWithFrame:CGRectMake(50*NOW_SIZE, 420*NOW_SIZE, 70*NOW_SIZE, 30*NOW_SIZE)];
    self.forgetLable.text=@"忘记密码";
     self.forgetLable.textColor=[UIColor whiteColor];
        self.forgetLable.font = [UIFont systemFontOfSize:16*NOW_SIZE];
    self.forgetLable.textAlignment = NSTextAlignmentLeft;
     self.forgetLable.userInteractionEnabled=YES;
    UITapGestureRecognizer * forget=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(forget)];
    [self.forgetLable addGestureRecognizer:forget];
    
    [self.view addSubview:self.forgetLable];
    

    
}

-(void)forget{
    forgetViewController *registerRoot=[[forgetViewController alloc]init];
    //[self presentViewController:registerRoot animated:YES completion:nil];
    
    [self.navigationController pushViewController:registerRoot animated:YES];
}


-(void)tapLable{
    NSLog(@"注册");
    self.registLable.highlighted=YES;
    self.registLable.highlightedTextColor=[UIColor whiteColor];
    
    countryViewController *registerRoot=[[countryViewController alloc]init];
  //[self presentViewController:registerRoot animated:YES completion:nil];
    
    [self.navigationController pushViewController:registerRoot animated:YES];
    

}

- (NSString *)MD5:(NSString *)str {
    const char *cStr = [str UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), digest);
    NSMutableString *result = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        NSString *tStr = [NSString stringWithFormat:@"%x", digest[i]];
        if (tStr.length == 1) {
            [result appendString:@"c"];
        }
        [result appendFormat:@"%@", tStr];
    }
    return result;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [_userTextField resignFirstResponder];
    [_pwdTextField resignFirstResponder];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [_userTextField resignFirstResponder];
    [_pwdTextField resignFirstResponder];
    
    return YES;
}

//模拟网络访问
- (void)PresentCtrl:(LoginButton *)loginBtn {
    
    typeof(self) __weak weak = self;
    //模拟网络访问
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [weak loginBtnAction:loginBtn];
    });
}
//判断登录
- (void)loginBtnAction:(LoginButton *)loginBtn {
    typeof(self) __weak weak = self;
    
    if (_userTextField.text == nil || _userTextField.text == NULL || [_userTextField.text isEqualToString:@""]) {//判断用户名为空
        //按钮动画还原
        [loginBtn ErrorRevertAnimationCompletion:nil];
        //延迟调用弹出提示框方法
        [self performSelector:@selector(userAlertAction) withObject:nil afterDelay:1.0];
    }else if (_pwdTextField.text == nil || _pwdTextField.text == NULL || [_pwdTextField.text isEqualToString:@""]) {//判断密码为空或者不正确
        //按钮动画还原
        [loginBtn ErrorRevertAnimationCompletion:nil];
        //延迟调用弹出提示框方法
        [self performSelector:@selector(passWordAlertAction) withObject:nil afterDelay:1.0];
    }else {
        //用户名和密码输入正确跳转页面
        [loginBtn ExitAnimationCompletion:^{
            
            [BaseRequest requestWithMethod:HEAD_URL paramars:@{@"userName":_userTextField.text, @"password":[self MD5:_pwdTextField.text]} paramarsSite:@"/NewLoginAPI.do" sucessBlock:^(id content) {
                 [MBProgressHUD hideHUDForView:self.view animated:YES];
                NSLog(@"loginIn:%@",content);
                if (content) {
                    if ([content[@"success"] integerValue] == 0) {
                        //登陆失败
                        if ([content[@"msg"] integerValue] == 501) {
                           
                            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"User name or password is blank" delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:nil];
                            [alertView show];
                        }
                        if ([content[@"msg"] integerValue] ==502) {
                             UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"username password error" delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:nil];
                               [alertView show];
                        }
                        if ([content[@"msg"] integerValue] ==503) {
                            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"server error" delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:nil];
                            [alertView show];
                        }
                    } else {
                        //登陆成功
                        [[UserInfo defaultUserInfo] setUserPassword:_pwdTextField.text];
                        [[UserInfo defaultUserInfo] setUserName:_userTextField.text];
                         self.dataSource = [NSDictionary dictionaryWithDictionary:content];
                        [[UserInfo defaultUserInfo] setTelNumber:_dataSource[@"user"][@"phoneNum"]];
                         [[UserInfo defaultUserInfo] setUserID:_dataSource[@"user"][@"id"]];
                             [[UserInfo defaultUserInfo] setEmail:_dataSource[@"user"][@"email"]];
                        
                        NSString *ID=[[NSUserDefaults standardUserDefaults] objectForKey:@"userID"];
                        NSLog(@"ID=%@",ID);
                              
                        [weak didPresentControllerButtonTouch];
                        
                    }
                }
                
            } failure:^(NSError *error) {
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                //[self showToastViewWithTitle:root_Networking];
                MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
                hud.mode = MBProgressHUDModeText;
                hud.animationType = MBProgressHUDAnimationZoom;
                hud.labelText = @"Networking Timeout";
                hud.margin = 10.f;
                hud.removeFromSuperViewOnHide = YES;
                [hud hide:YES afterDelay:1.5];
            }];
            
         
        }];
    }
}

//弹出输入用户提示框方法
- (void)userAlertAction {
    UIAlertController *alertCtrl = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"请输入用户名" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *btnAction = [UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertCtrl addAction:btnAction];
    [self presentViewController:alertCtrl animated:YES completion:nil];
}
//弹出输入密码提示框方法
- (void)passWordAlertAction {
    UIAlertController *alertCtrl = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"请输入密码" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *btnAction = [UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertCtrl addAction:btnAction];
    [self presentViewController:alertCtrl animated:YES completion:nil];
}

    //登录成功条跳转的方法
    - (void)didPresentControllerButtonTouch {
        NSMutableArray *stationID1=_dataSource[@"data"];
        NSMutableArray *stationID=[NSMutableArray array];
        for(int i=0;i<stationID1.count;i++){
         NSString *a=stationID1[i][@"plantId"];
           // NSLog(@"a=%@",a);
            [stationID addObject:a];
        }
        findViewController *findVc=[[findViewController alloc]init];
        energyViewController *energyVc=[[energyViewController alloc]init];
        deviceViewController *deviceVc=[[deviceViewController alloc]initWithDataDict:stationID];
        meViewController *meVc=[[meViewController alloc]init];
        
        UINavigationController *Vc3=[[UINavigationController alloc]initWithRootViewController:findVc];
        UINavigationController *Vc2=[[UINavigationController alloc]initWithRootViewController:energyVc];
        UINavigationController *Vc1=[[UINavigationController alloc]initWithRootViewController:deviceVc];
        UINavigationController *Vc4=[[UINavigationController alloc]initWithRootViewController:meVc];
        
        
        
        Vc1.title=@"Device";
        Vc2.title=@"Energy";
        Vc3.title=@"Find";
        Vc4.title=@"Me";
        
        Vc1.tabBarItem.image=[UIImage imageNamed:@"shebei@2x.png"];
        Vc1.tabBarItem.selectedImage=[UIImage imageNamed:@"shebei_press@2x.png"];
        Vc2.tabBarItem.image=[UIImage imageNamed:@"iconfont-nengyuanlei@2x.png"];
        Vc2.tabBarItem.selectedImage=[UIImage imageNamed:@"iconfont-nengyuanlei_press@2x.png"];
        Vc3.tabBarItem.image=[UIImage imageNamed:@"iconfont-faxian@2x.png"];
        Vc3.tabBarItem.selectedImage=[UIImage imageNamed:@"iconfont-faxian_press@2x.png"];
        Vc4.tabBarItem.image=[UIImage imageNamed:@"icon@2x.png"];
        Vc4.tabBarItem.selectedImage=[UIImage imageNamed:@"icon_press@2x.png"];
        
        NSArray *controllers=[NSArray arrayWithObjects:Vc1,Vc2,Vc3,Vc4,nil];
        UITabBarController *tabbar=[[UITabBarController alloc]init];
        tabbar.viewControllers=controllers;

        [self presentViewController:tabbar animated:YES completion:nil];
    }


    
    - (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    
    return [[StTransitions alloc]initWithTransitionDuration:0.4f StartingAlpha:0.5f isBOOL:true];
}
    
    - (id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
        
        return [[StTransitions alloc]initWithTransitionDuration:0.4f StartingAlpha:0.8f isBOOL:false];
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
