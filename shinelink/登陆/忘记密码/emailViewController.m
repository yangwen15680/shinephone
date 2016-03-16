//
//  emailViewController.m
//  shinelink
//
//  Created by sky on 16/3/1.
//  Copyright © 2016年 sky. All rights reserved.
//

#import "emailViewController.h"

@interface emailViewController ()
@property(nonatomic,strong)UITextField *cellectId;
@end

@implementation emailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImage *bgImage = IMAGE(@"bg.png");
    self.view.layer.contents = (id)bgImage.CGImage;
    
    UIImageView *userBgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(40*NOW_SIZE, 90*NOW_SIZE, SCREEN_Width - 80*NOW_SIZE, 45*NOW_SIZE)];
    userBgImageView.userInteractionEnabled = YES;
    userBgImageView.image = IMAGE(@"圆角矩形空心.png");
    [self.view addSubview:userBgImageView];
    
    _cellectId = [[UITextField alloc] initWithFrame:CGRectMake(60*NOW_SIZE, 0, CGRectGetWidth(userBgImageView.frame) - 50*NOW_SIZE, 45*NOW_SIZE)];
    _cellectId.placeholder = @"请输入用户名";
    _cellectId.textColor = [UIColor grayColor];
    _cellectId.tintColor = [UIColor grayColor];
    [_cellectId setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
    [_cellectId setValue:[UIFont systemFontOfSize:11*NOW_SIZE] forKeyPath:@"_placeholderLabel.font"];
    _cellectId.font = [UIFont systemFontOfSize:11*NOW_SIZE];
    [userBgImageView addSubview:_cellectId];
    
    UIButton *goBut =  [UIButton buttonWithType:UIButtonTypeCustom];
    goBut.frame=CGRectMake(40*NOW_SIZE,160*NOW_SIZE, 240*NOW_SIZE, 40*NOW_SIZE);
    [goBut.layer setMasksToBounds:YES];
    [goBut.layer setCornerRadius:25.0];
       [goBut setBackgroundImage:IMAGE(@"按钮2.png") forState:UIControlStateNormal];
    [goBut setTitle:@"确定" forState:UIControlStateNormal];
    [goBut addTarget:self action:@selector(addButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:goBut];
}

- (void)showAlertViewWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelTitle{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:cancelTitle otherButtonTitles:nil];
    [alertView show];
}

-(void)addButtonPressed{
    if ([_cellectId.text isEqual:@""]) {
        [self showAlertViewWithTitle:nil message:@"请输入正确的用户名" cancelButtonTitle:@"确定"];
        return;
    }
      NSDictionary *userCheck=[NSDictionary dictionaryWithObject:_cellectId.text forKey:@"accountName"];
        [self showProgressView];
        [BaseRequest requestWithMethod:HEAD_URL paramars:userCheck  paramarsSite:@"/newForgetAPI.do?op=sendResetEmailByAccount" sucessBlock:^(id content) {
            NSLog(@"sendResetEmailByAccount: %@", content);
            [self hideProgressView];
            if (content) {
                if ([content[@"success"] integerValue] == 0) {
                    if ([content[@"msg"] integerValue] ==501) {
                        [self showAlertViewWithTitle:nil message:@"发送邮件失败" cancelButtonTitle:root_Yes];
                    }
                    else if ([content[@"msg"] integerValue] ==502) {
                        [self showAlertViewWithTitle:nil message:@"不能找到用户名" cancelButtonTitle:root_Yes];
                    }else if ([content[@"msg"] integerValue] ==503) {
                        [self showAlertViewWithTitle:nil message:@"服务器错误" cancelButtonTitle:root_Yes];
                    }
                }else{
                    NSString *email=content[@"msg"];
                    [self showAlertViewWithTitle:nil message:email cancelButtonTitle:root_Yes];
                    
                } 
            }
        }failure:^(NSError *error) {
            [self hideProgressView];
            [self showToastViewWithTitle:root_Networking];
        }];
    
    
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
