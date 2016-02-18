//
//  rootviewViewController.m
//  shinelink
//
//  Created by sky on 16/2/15.
//  Copyright © 2016年 sky. All rights reserved.
//

#import "rootviewViewController.h"
#import "findViewController.h"
#import "energyViewController.h"
#import "deviceViewController.h"
#import "meViewController.h"

@interface rootviewViewController ()

@end

@implementation rootviewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    self.view= [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.view.backgroundColor = [UIColor whiteColor];
    
    //rootviewViewController *rootView=[[rootviewViewController alloc]init];
    //UINavigationController *navc=[[UINavigationController alloc]initWithRootViewController:rootView];
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
    
   
    
   
    

    
    
    // Do any additional setup after loading the view.
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
