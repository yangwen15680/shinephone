//
//  forgetViewController.m
//  shinelink
//
//  Created by sky on 16/3/1.
//  Copyright © 2016年 sky. All rights reserved.
//

#import "forgetViewController.h"
#import "emailViewController.h"
#import "SNViewController.h"

@interface forgetViewController ()

@end

@implementation forgetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImage *bgImage = IMAGE(@"loginbg.jpg");
    self.view.layer.contents = (id)bgImage.CGImage;
    
    
    UIButton *byEmail =  [UIButton buttonWithType:UIButtonTypeCustom];
    byEmail.frame=CGRectMake(60*NOW_SIZE,200*NOW_SIZE, 200*NOW_SIZE, 40*NOW_SIZE);
    [byEmail.layer setMasksToBounds:YES];
    [byEmail.layer setCornerRadius:25.0];
    byEmail.backgroundColor = [UIColor colorWithRed:130/255.0f green:200/255.0f blue:250/255.0f alpha:1];
    [byEmail setTitle:@"通过用户名" forState:UIControlStateNormal];
    [byEmail addTarget:self action:@selector(bymail) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:byEmail];
    
    UIButton *goBut =  [UIButton buttonWithType:UIButtonTypeCustom];
    goBut.frame=CGRectMake(60*NOW_SIZE,280*NOW_SIZE, 200*NOW_SIZE, 40*NOW_SIZE);
    [goBut.layer setMasksToBounds:YES];
    [goBut.layer setCornerRadius:25.0];
    goBut.backgroundColor = [UIColor colorWithRed:130/255.0f green:200/255.0f blue:250/255.0f alpha:1];
    [goBut setTitle:@"通过序列号" forState:UIControlStateNormal];
    [goBut addTarget:self action:@selector(bySN) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:goBut];
}

-(void)bymail{
    emailViewController *goView=[[emailViewController alloc]init];
    [self.navigationController pushViewController:goView animated:YES];
    
    
}

-(void)bySN{
    SNViewController *goView=[[SNViewController alloc]init];
    [self.navigationController pushViewController:goView animated:YES];
    
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
