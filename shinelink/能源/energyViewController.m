//
//  energyViewController.m
//  shinelink
//
//  Created by sky on 16/2/15.
//  Copyright © 2016年 sky. All rights reserved.
//

#import "energyViewController.h"
#import "energyTableViewCell.h"
#import "engrgySencondViewController.h"
#import "homeDeviceViewController.h"
#import "EquitGraph2ViewController.h"
#import "EquipGraphViewController.h"

@interface energyViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation energyViewController
{
 NSString *_indenty;
    NSMutableArray* imageArray;
    NSMutableArray *nameArray;
    NSMutableArray *monthArray;
    NSMutableArray *dayArray;
    NSMutableArray *monthDateArray;
    NSMutableArray *dayDateArray;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setBarTintColor:COLOR(17, 183, 243, 1)];
    [self.navigationController.navigationBar setTitleTextAttributes:@{
                                                                      NSForegroundColorAttributeName :[UIColor whiteColor]
                                                                      }];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    [self setTitle:@"能源分析"];
    
    nameArray=[[NSMutableArray alloc]initWithObjects:@"家庭用电量",@"家庭用电设备",@"光伏电量",@"储能电量", nil];
    monthArray=[[NSMutableArray alloc]initWithObjects:@"月:",@"最省电:",@"月:",@"月:",nil];
    monthDateArray=[[NSMutableArray alloc]initWithObjects:@"10KW/m",@"10KW/m",@"10KW/m",@"10KW/m",nil];
    dayDateArray=[[NSMutableArray alloc]initWithObjects:@"10KW/m",@"10KW/m",@"10KW/m",@"10KW/m",nil];
    dayArray=[[NSMutableArray alloc]initWithObjects:@"日:",@"最耗电:",@"日:",@"日:", nil];
    imageArray=[[NSMutableArray alloc]initWithObjects:@"家庭用电量.png",@"家庭用电设备.png",@"光伏收益.png",@"光伏电量.png", nil];
    // Do any additional setup after loading the view.
    [self _createTableView];
}

- (void)_createTableView {
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:_tableView];
    _indenty = @"indenty";
    //注册单元格类型
    [_tableView registerClass:[energyTableViewCell class] forCellReuseIdentifier:_indenty];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
        return imageArray.count;
  
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

        
        energyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:_indenty forIndexPath:indexPath];
        //   cell.textLabel.text = [NSString stringWithFormat:@"Cell:%ld",indexPath.row];
        if (!cell) {
            cell=[[energyTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:_indenty];
        }
        
        [cell.coverImageView  setImage:[UIImage imageNamed:imageArray[indexPath.row]]];
        cell.titleLabel.text = nameArray[indexPath.row];
        cell.titleLabel.textColor = [UIColor orangeColor];
        cell.stateValue.text = monthDateArray[indexPath.row];
        cell.electricValue.text =dayDateArray[indexPath.row];
            cell.state.text=monthArray[indexPath.row];
    cell.electric.text=dayArray[indexPath.row];
        return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row==0){
        EquitGraph2ViewController *equipGraph=[[EquitGraph2ViewController alloc]init];
        equipGraph.dictInfo=@{@"equipId":@"家庭用电",
                              @"daySite":@"/inverterA.do?op=getDps",
                              @"monthSite":@"/inverterA.do?op=getMps",
                              @"yearSite":@"/inverterA.do?op=getYps",
                              @"allSite":@"/inverterA.do?op=getTps"};
        //equipGraph.dict=@{@"1":root_PV_POWER, @"2":root_PV1_VOLTAGE, @"3":root_PV1_ELEC_CURRENT, @"4":root_PV2_VOLTAGE, @"5":root_PV2_ELEC_CURRENT, @"6":root_R_PHASE_POWER, @"7":root_S_PHASE_POWER, @"8":root_T_PHASE_POWER};
        [self.navigationController pushViewController:equipGraph animated:YES];
    }
    
    
    if (indexPath.row==1) {
        homeDeviceViewController *home=[[homeDeviceViewController alloc]init];
        [self.navigationController pushViewController:home animated:YES];
        
    }
    
    if (indexPath.row==2) {
       EquitGraph2ViewController  *home=[[EquitGraph2ViewController alloc]init];
        [self.navigationController pushViewController:home animated:YES];
        NSUserDefaults *ud=[NSUserDefaults standardUserDefaults];
        NSString *plantID=[ud objectForKey:@"plantID"];
        home.plantID=plantID;
        home.dicType=@"2";
        home.dictInfo=@{@"equipId":plantID,
                              @"daySite":@"/newPlantDetailAPI.do?type=1",
                              @"monthSite":@"/newPlantDetailAPI.do?type=2",
                              @"yearSite":@"/newPlantDetailAPI.do?type=3",
                              @"allSite":@"/newPlantDetailAPI.do?type=4"};
        
    }
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 65*NOW_SIZE;
    
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
