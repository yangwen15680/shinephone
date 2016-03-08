//
//  energyViewController.m
//  shinelink
//
//  Created by sky on 16/2/15.
//  Copyright © 2016年 sky. All rights reserved.
//

#import "energyViewController.h"
#import "energyTableViewCell.h"

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

    nameArray=[[NSMutableArray alloc]initWithObjects:@"家庭用电量",@"家庭用电设备",@"光伏收益",@"储能收益",@"光伏电量", nil];
    monthArray=[[NSMutableArray alloc]initWithObjects:@"月:",@"最省电:",@"月:",@"月:",@"月:", nil];
    monthDateArray=[[NSMutableArray alloc]initWithObjects:@"10KW/m",@"10KW/m",@"10KW/m",@"10KW/m",@"10KW/m", nil];
    dayDateArray=[[NSMutableArray alloc]initWithObjects:@"10KW/m",@"10KW/m",@"10KW/m",@"10KW/m",@"10KW/m", nil];
    dayArray=[[NSMutableArray alloc]initWithObjects:@"日:",@"最耗电:",@"日:",@"日:",@"日:", nil];
    imageArray=[[NSMutableArray alloc]initWithObjects:@"2.jpg",@"2.jpg",@"2.jpg",@"2.jpg",@"2.jpg", nil];
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
