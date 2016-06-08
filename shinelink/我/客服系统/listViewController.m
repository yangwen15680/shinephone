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
@property(nonatomic,strong)NSMutableArray *questionTypeArray;
@property(nonatomic,strong)NSMutableArray *statusArray;
@property(nonatomic,strong)NSMutableArray *contentArray;
@property(nonatomic,strong)NSMutableArray *contentSecondArray;
@property(nonatomic,strong)NSMutableArray *timeArray;
@property(nonatomic,strong)NSMutableArray *allArray;
@property(nonatomic,strong)NSMutableArray *questionID;
@property(nonatomic,strong)NSMutableArray *questionPicArray;
@property(nonatomic,strong)NSString *delQuestionID;
@property (nonatomic, strong) NSIndexPath *indexPath;

@end

@implementation listViewController

-(void)viewWillAppear:(BOOL)animated{
    [self netquestion];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

-(void)netquestion{

    NSUserDefaults *ud=[NSUserDefaults standardUserDefaults];
    NSString *userID=[ud objectForKey:@"userID"];
    
    self.titleArray =[NSMutableArray array];
    self.statusArray =[NSMutableArray array];
    self.contentArray =[NSMutableArray array];
    self.timeArray =[NSMutableArray array];
    self.questionID=[NSMutableArray array];
    self.questionTypeArray=[NSMutableArray array];
    self.questionPicArray=[NSMutableArray array];
    self.contentSecondArray=[NSMutableArray array];
    
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
                NSString *question=[NSString stringWithFormat:@"%@",content[i][@"id"]];
                NSString *questiontype=[NSString stringWithFormat:@"%@",content[i][@"questionType"]];
                NSString *questionPIC=[NSString stringWithFormat:@"%@",content[i][@"attachment"]];
                NSArray *PIC = [questionPIC componentsSeparatedByString:@"_"];
                
                 NSArray *contentS2=[NSArray arrayWithArray:content[i][@"serviceQuestionReplyBean"]];
                if(contentS2[0] != nil && ![(NSArray*)contentS2[0] isKindOfClass:[NSNull class]] && ((NSArray*)contentS2[0]).count !=0){
               // if([contentS2[0] containsObject:@"message"]){
                    
                //NSArray *contentS2=[NSArray arrayWithArray:content[i][@"serviceQuestionReplyBean"]];
                  
                if ([contentS2[0][@"message"] length]>0) {
                    NSString *contentS3=[NSString stringWithFormat:@"%@",contentS2[0][@"message"]];
                      [_contentArray addObject:contentS3];
                }else{
                  [_contentArray addObject:contentS1];
                }
                }else{
                  [_contentArray addObject:contentS1];
                }
                
                [_contentSecondArray addObject:contentS1];
                [_questionPicArray addObject:PIC];
                [_titleArray addObject:title];
                [_statusArray addObject:status];
              
                [_timeArray addObject:time];
                [_questionID addObject:question];
                [_questionTypeArray addObject:questiontype];
            }
            
            self.navigationItem.title = root_ME_wenti_liebiao;
            _tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-40*HEIGHT_SIZE)];
            _tableView.delegate = self;
            _tableView.dataSource = self;
            self.tableView.separatorStyle=NO;
            self.tableView.backgroundColor=COLOR(240, 242, 239, 1);
            self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
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
    
    if ([_statusArray[indexPath.row] isEqualToString:@"0"]) {
         cell.statusLabel.text= root_ME_wei_chuli;
        cell.titleView.backgroundColor=COLOR(244, 147, 147, 1);
    }else if ([_statusArray[indexPath.row] isEqualToString:@"1"]){
        cell.statusLabel.text=root_ME_zhengzai_chuli;
        cell.titleView.backgroundColor=COLOR(144, 211, 112, 1);
    }else if([_statusArray[indexPath.row] isEqualToString:@"2"]){
        cell.statusLabel.text= root_ME_yi_chuli;
        cell.titleView.backgroundColor=COLOR(201, 201, 201, 1);
    }
    
    
    cell.titleLabel.text= self.titleArray[indexPath.row];
      // cell.statusLabel.text= self.statusArray[indexPath.row];
       cell.contentLabel.text= self.contentArray[indexPath.row];
    cell.timeLabel.text=self.timeArray[indexPath.row];
    cell.content=self.contentArray[indexPath.row];
    CGRect fcRect = [cell.content boundingRectWithSize:CGSizeMake(300*Width, 1000*HEIGHT_SIZE) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14*HEIGHT_SIZE]} context:nil];
     cell.contentLabel.frame =CGRectMake(10*NOW_SIZE, 45*HEIGHT_SIZE, 300*NOW_SIZE, fcRect.size.height);
   cell.timeLabel.frame=CGRectMake(SCREEN_WIDTH-210*NOW_SIZE, 80*HEIGHT_SIZE+fcRect.size.height,200*NOW_SIZE, 20*HEIGHT_SIZE );
    cell.selectionStyle=UITableViewCellSelectionStyleGray;
     //NSLog(@"content=%@",cell.content);
  
    cell.view1.frame=CGRectMake(0, 80*HEIGHT_SIZE+fcRect.size.height+20*HEIGHT_SIZE,SCREEN_Width, 10*HEIGHT_SIZE );
 
    
    UILongPressGestureRecognizer * longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(cellDidLongPressed:)];
    longPressGesture.minimumPressDuration = 1.0f;
    [cell addGestureRecognizer:longPressGesture];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)cellDidLongPressed:(id)sender{
    UILongPressGestureRecognizer *longPress = (UILongPressGestureRecognizer *)sender;
   // UIGestureRecognizerState state = longPress.state;
    
    CGPoint location = [longPress locationInView:self.tableView];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:location];
    _delQuestionID=_questionID[indexPath.row];
    
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle: nil
                                                                              message: nil
                                                                       preferredStyle:UIAlertControllerStyleActionSheet];
    //添加Button
    [alertController addAction: [UIAlertAction actionWithTitle: root_ME_shanchu_liebiao style: UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
    
        [self delQuestion];
        
    }]];
    [alertController addAction: [UIAlertAction actionWithTitle: root_cancel style: UIAlertActionStyleCancel handler:nil]];
    
    
    [self presentViewController: alertController animated: YES completion: nil];
    
}


-(void)delQuestion{

    [BaseRequest requestWithMethodResponseStringResult:HEAD_URL paramars:@{@"questionId":_delQuestionID} paramarsSite:@"/questionAPI.do?op=deleteQuestion" sucessBlock:^(id content) {
        [self hideProgressView];
        NSLog(@"deleteQuestion=: %@", content);
          id jsonObj = [NSJSONSerialization JSONObjectWithData:content options:NSJSONReadingAllowFragments error:nil];
         NSLog(@"deleteQuestion=: %@", jsonObj);
        if([[jsonObj objectForKey:@"success"] integerValue]==1){
           
             [self showAlertViewWithTitle:nil message:root_shanchu_chenggong cancelButtonTitle:root_Yes];
        }else{
        
             [self showAlertViewWithTitle:nil message:root_shanchu_shibai cancelButtonTitle:root_Yes];
        }
        
        [self netquestion];
    } failure:^(NSError *error) {
        [self hideProgressView];
        [self showToastViewWithTitle:root_Networking];
    }];


}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    myListSecond *second=[[myListSecond alloc]init];
    second.qusetionId=_questionID[indexPath.row];
    second.qusetionType=_questionTypeArray[indexPath.row];
    second.questionPicArray=[NSMutableArray arrayWithArray:_questionPicArray[indexPath.row]];
    second.qusetionContent=_contentSecondArray[indexPath.row];
    [self.navigationController pushViewController:second animated:NO];
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    
    CGRect fcRect = [self.contentArray[indexPath.row] boundingRectWithSize:CGSizeMake(300*Width, 1000*HEIGHT_SIZE) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14 *HEIGHT_SIZE]} context:nil];
    return 110*HEIGHT_SIZE+fcRect.size.height;
    
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
