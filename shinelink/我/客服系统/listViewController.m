//
//  listViewController.m
//  shinelink
//
//  Created by sky on 16/2/29.
//  Copyright © 2016年 sky. All rights reserved.
//

#import "listViewController.h"
#import "listTableViewCell.h"
#import "myListSecond.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define Width [UIScreen mainScreen].bounds.size.width/320.0
#define Height [UIScreen mainScreen].bounds.size.height/568.0

@interface listViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *titleArray;
@property(nonatomic,strong)NSMutableArray *statusArray;
@property(nonatomic,strong)NSMutableArray *contentArray;
@property(nonatomic,strong)NSMutableArray *timeArray;
@property(nonatomic,strong)NSMutableArray *allArray;

@end

@implementation listViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSUserDefaults *ud=[NSUserDefaults standardUserDefaults];
    NSString *userID=[ud objectForKey:@"userID"];
    
    self.titleArray =[NSMutableArray array];
    self.statusArray =[NSMutableArray array];
        self.contentArray =[NSMutableArray array];
        self.timeArray =[NSMutableArray array];
    
    [self showProgressView];
    [BaseRequest requestWithMethodResponseJsonByGet:HEAD_URL paramars:@{@"userId":userID} paramarsSite:@"/questionAPI.do?op=questionList" sucessBlock:^(id content) {
        [self hideProgressView];
      NSLog(@"questionList=: %@", content);
        if(content){
             _allArray=[NSMutableArray arrayWithArray:content];
            for(int i=0;i<_allArray.count;i++){
           
                NSString *title=[NSString stringWithFormat:@"%@",content[i][@"title"]];
                NSString *status=[NSString stringWithFormat:@"%@",content[i][@"status"]];
                NSString *contentS1=[NSString stringWithFormat:@"%@",content[i][@"content"]];
                NSString *time=[NSString stringWithFormat:@"%@",content[i][@"lastTime"]];
                [_titleArray addObject:title];
              [_statusArray addObject:status];
                  [_contentArray addObject:contentS1];
                  [_timeArray addObject:time];

        /*self.titleArray =[NSMutableArray arrayWithObjects:@"第一",@"第二",@"第三",nil];
        self.statusArray =[NSMutableArray arrayWithObjects:@"已处理",@"已处理",@"已处理",nil];
        self.contentArray =[NSMutableArray arrayWithObjects:@"这个是比较简单的图文混排这个是比较简单的图文混排这个是比较简单的图文混排这个是比较简单的图文混排这个是是比较简单的图这个是比较简单的图文混排这个是比较简单的图文混排这个是比较简单的图",
                            @"自适应宽高这个是比较简单的图文混排,自适应宽高自适应宽高这个是比较简单的图文混排,自适应宽高自适应宽高这个是比较简单的图文混排,自适应宽高自适应宽高这个是比较简单的图文混排,自高",
                            @"这个是比较简单的图文混排自适应宽高这个是比较简单的图文混排自适应宽高这个是比较简单的图文混排自适应宽高这个是比较简单的图文混排自适应宽高这个是比较简单的图文混排", nil];
        self.timeArray=[NSMutableArray arrayWithObjects:@"2016.3.3",@"2016.3.3",@"2016.3.3",nil];*/
                
            }
            
        self.navigationItem.title = @"问题列表";
        _tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-100*NOW_SIZE)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.view addSubview:_tableView];
        }
    } failure:^(NSError *error) {
        [self hideProgressView];
        [self showToastViewWithTitle:root_Networking];
    }];
    
   
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma tableViewDelegate&DataSource
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    listTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[listTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
     [cell.contentView setBackgroundColor: [UIColor whiteColor] ];
    
    cell.titleLabel.text= self.titleArray[indexPath.row];
       cell.statusLabel.text= self.statusArray[indexPath.row];
       cell.contentLabel.text= self.contentArray[indexPath.row];
    cell.timeLabel.text=self.timeArray[indexPath.row];
    cell.content=self.contentArray[indexPath.row];
    CGRect fcRect = [cell.content boundingRectWithSize:CGSizeMake(300*Width, 1000*Height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18 *Width]} context:nil];
     cell.contentLabel.frame =CGRectMake(10*Width, 45*Width, 300*Width, fcRect.size.height);
   cell.timeLabel.frame=CGRectMake(SCREEN_WIDTH-200*NOW_SIZE, 45*NOW_SIZE+fcRect.size.height,200*NOW_SIZE, 20*NOW_SIZE );
    cell.selectionStyle=UITableViewCellSelectionStyleGray;
     //NSLog(@"content=%@",cell.content);
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    myListSecond *second=[[myListSecond alloc]init];
    [self.navigationController pushViewController:second animated:NO];
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    
    CGRect fcRect = [self.contentArray[indexPath.row] boundingRectWithSize:CGSizeMake(300*Width, 1000*Height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18 *Width]} context:nil];
    return 70*Height+fcRect.size.height;
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.titleArray.count;
}


@end
