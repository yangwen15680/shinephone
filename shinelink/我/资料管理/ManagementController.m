//
//  ManagementController.m
//  shinelink
//
//  Created by sky on 16/4/21.
//  Copyright © 2016年 sky. All rights reserved.
//

#import "ManagementController.h"
#import "loginViewController.h"
#import "changManeger.h"

@interface ManagementController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)NSMutableArray *dataArray1;
@end

@implementation ManagementController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    [self initUI];
 
}

-(void)initUI{
    NSUserDefaults *ud=[NSUserDefaults standardUserDefaults];
    NSString *tel=[ud objectForKey:@"TelNumber"];
    NSString *email=[ud objectForKey:@"email"];
    
    self.dataArray1=[NSMutableArray array];
    [self.dataArray1 addObject:@""];
    [self.dataArray1 addObject:tel];
    [self.dataArray1 addObject:email];
    self.dataArray =[NSMutableArray arrayWithObjects:@"修改密码",@"修改手机号",@"修改邮箱",nil];
   // self.dataArray1 =[NSMutableArray arrayWithObjects:@"",@"18666666666",@"328657662@qq.com",nil];
    
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_Width, 300*NOW_SIZE)];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    [self.view addSubview:_tableView];
    
    UIButton *registerUser =  [UIButton buttonWithType:UIButtonTypeCustom];
    registerUser.frame=CGRectMake((SCREEN_Width-150*NOW_SIZE)/2,300*NOW_SIZE, 150*NOW_SIZE, 40*NOW_SIZE);
    [registerUser.layer setMasksToBounds:YES];
    [registerUser.layer setCornerRadius:20.0];
    registerUser.backgroundColor = [UIColor redColor];
    [registerUser setTitle:@"注销账号" forState:UIControlStateNormal];
    //[goBut setTintColor:[UIColor colorWithRed:130/ 255.0f green:200 / 255.0f blue:250 / 255.0f alpha:1]];
    [registerUser setTitleColor: [UIColor whiteColor]forState:UIControlStateNormal];
    [registerUser addTarget:self action:@selector(registerUser) forControlEvents:UIControlEventTouchUpInside];
    //  goBut.highlighted=[UIColor grayColor];
    [self.view addSubview:registerUser];


}

-(void)registerUser{
    [[UserInfo defaultUserInfo] setUserPassword:nil];
    [[UserInfo defaultUserInfo] setUserName:nil];
    loginViewController *login =[[loginViewController alloc]init];
    
    self.hidesBottomBarWhenPushed=YES;
    [login.navigationController setNavigationBarHidden:YES];
    [self.navigationController pushViewController:login animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return  _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellDentifier=@"cellDentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellDentifier];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cellDentifier"];
    }
    cell.textLabel.text=_dataArray[indexPath.row];
    cell.textLabel.textColor=[UIColor blackColor];
    cell.detailTextLabel.text=_dataArray1[indexPath.row];
    cell.detailTextLabel.textColor=[UIColor grayColor];
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    return 60*NOW_SIZE;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
     changManeger *go=[[changManeger alloc]init];
    if (indexPath.row==0) {
        go.type=@"0";
    }else if (indexPath.row==1){
        go.type=@"1";
    }else if (indexPath.row==2){
        go.type=@"2";
    }
 
    [self.navigationController pushViewController:go animated:YES];
    
}

@end
