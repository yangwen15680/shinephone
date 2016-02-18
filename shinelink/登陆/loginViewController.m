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
#import "rootviewViewController.h"
#import "findViewController.h"
#import "energyViewController.h"
#import "deviceViewController.h"
#import "meViewController.h"

@interface loginViewController ()
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UITextField *userTextField;
@property (nonatomic, strong) UITextField *pwdTextField;
//@property (nonatomic, strong) UIButton *loginButton;
@property (nonatomic, strong) UIButton *registButton;
@end

@implementation loginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIImage *bgImage = IMAGE(@"loginbg.jpg");
    self.view.layer.contents = (id)bgImage.CGImage;
    
    //添加布局
    [self addSubViews];
}

//添加布局
- (void)addSubViews {

    _scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Height)];
    [self.view addSubview:_scrollView];
    
    //logo
    UIImageView *logo = [[UIImageView alloc] initWithFrame:CGRectMake(20*NOW_SIZE, 80*NOW_SIZE, SCREEN_Width - 40*NOW_SIZE, 60*NOW_SIZE)];
    logo.image = IMAGE(@"icon_logo.png");
    [_scrollView addSubview:logo];
    
    //用户名
    UIImageView *userBgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(40*NOW_SIZE, 210*NOW_SIZE, SCREEN_Width - 80*NOW_SIZE, 45*NOW_SIZE)];
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
    UIImageView *pwdBgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(40*NOW_SIZE, 270*NOW_SIZE, SCREEN_Width - 80*NOW_SIZE, 45*NOW_SIZE)];
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
    
 

    LoginButton *loginBtn = [[LoginButton alloc] initWithFrame:CGRectMake(40*NOW_SIZE, 330*NOW_SIZE, SCREEN_Width - 80*NOW_SIZE, 45*NOW_SIZE)];
    loginBtn.backgroundColor = [UIColor colorWithRed:130/255.0f green:200/255.0f blue:250/255.0f alpha:1];
    [self.view addSubview:loginBtn];
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [loginBtn addTarget:self action:@selector(PresentCtrl:) forControlEvents:UIControlEventTouchUpInside];

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
            
            [weak didPresentControllerButtonTouch];
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
        findViewController *findVc=[[findViewController alloc]init];
        energyViewController *energyVc=[[energyViewController alloc]init];
        deviceViewController *deviceVc=[[deviceViewController alloc]init];
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
