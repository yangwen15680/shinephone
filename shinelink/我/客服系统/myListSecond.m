//
//  myListSecond.m
//  shinelink
//
//  Created by sky on 16/4/12.
//  Copyright © 2016年 sky. All rights reserved.
//

#import "myListSecond.h"
#import "myListSecondTableViewCell.h"
#import "AnswerViewController.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define Width [UIScreen mainScreen].bounds.size.width/320.0
#define Height [UIScreen mainScreen].bounds.size.height/568.0

@interface myListSecond ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIScrollView *scrollView2;
@property (nonatomic, strong) NSMutableArray *labelArray;
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *nameArray;
@property(nonatomic,strong)NSMutableArray *contentArray;
@property(nonatomic,strong)NSMutableArray *timeArray;

@end

@implementation myListSecond

- (void)viewDidLoad {
    [super viewDidLoad];
    _labelArray=[[NSMutableArray alloc]initWithObjects:@"标题：", @"类型：", @"回复记录：",nil];
    self.nameArray =[NSMutableArray arrayWithObjects:@"张三",@"李四",@"王老五",nil];
    self.contentArray =[NSMutableArray arrayWithObjects:@"这个是比较简单的图文混排这个是比较简单的图文混排这个是比较简单的图文混排这个是比较简单的图文混排这个是是比较简单的图这个是比较简单的图文混排这个是比较简单的图文混排这个是比较简单的图",
                        @"自适应宽高这个是比较简单的图文混排,自适应宽高自适应宽高这个是比较简单的图文混排,自适应宽高自适应宽高这个是比较简单的图文混排,自适应宽高自适应宽高这个是比较简单的图文混排,自高",
                        @"这个是比较简单的图文混排自适应宽高这个是比较简单的图文混排自适应宽高这个是比较简单的图文混排自适应宽高这个是比较简单的图文混排自适应宽高这个是比较简单的图文混排", nil];
    self.timeArray=[NSMutableArray arrayWithObjects:@"2016.3.3",@"2016.3.3",@"2016.3.3",nil];
    
    [self initUI];

}

-(void)initUI{
    _scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Height)];
    _scrollView.scrollEnabled=YES;
    _scrollView.contentSize = CGSizeMake(SCREEN_Width,600*NOW_SIZE);
    [self.view addSubview:_scrollView];
    float Size1=40*NOW_SIZE;
    
    for(int i=0;i<_labelArray.count;i++)
    {
        UILabel *PV1Lable=[[UILabel alloc]initWithFrame:CGRectMake(0*NOW_SIZE, 17*NOW_SIZE+Size1*i, 80*NOW_SIZE,20*NOW_SIZE )];
        PV1Lable.text=_labelArray[i];
        PV1Lable.textAlignment=NSTextAlignmentRight;
        PV1Lable.textColor=[UIColor blackColor];
        PV1Lable.font = [UIFont systemFontOfSize:14*NOW_SIZE];
        [_scrollView addSubview:PV1Lable];
    }
    
    for(int i=0;i<2;i++)
    {
        UIImageView *image1=[[UIImageView alloc]initWithFrame:CGRectMake(80*NOW_SIZE, 15*NOW_SIZE+Size1*i, 220*NOW_SIZE,30*NOW_SIZE )];
        image1.userInteractionEnabled = YES;
        image1.image = IMAGE(@"frame2@2x.png");
        [_scrollView addSubview:image1];
    }
    
    UIImageView *image2=[[UIImageView alloc]initWithFrame:CGRectMake(5*NOW_SIZE, 5*NOW_SIZE+Size1*3, 310*NOW_SIZE,300*NOW_SIZE )];
    image2.userInteractionEnabled = YES;
    image2.image = IMAGE(@"frame2@2x.png");
    [_scrollView addSubview:image2];
    
    /*_scrollView2=[[UIScrollView alloc]initWithFrame:CGRectMake(10*NOW_SIZE, 55*NOW_SIZE+Size1*3, 300*NOW_SIZE,300*NOW_SIZE )];
    _scrollView2.scrollEnabled=YES;
    _scrollView2.contentSize = CGSizeMake(300*NOW_SIZE,600*NOW_SIZE);
    [self.view addSubview:_scrollView2];*/
    
    _tableView =[[UITableView alloc]initWithFrame:CGRectMake(10*NOW_SIZE, 6*NOW_SIZE+Size1*3, 300*NOW_SIZE,290*NOW_SIZE )];
    _tableView.delegate = self;
    _tableView.dataSource = self;
       [_scrollView addSubview:_tableView];
    
    UIImageView *image3=[[UIImageView alloc]initWithFrame:CGRectMake(10*NOW_SIZE, 315*NOW_SIZE+Size1*3, 300*NOW_SIZE,30*NOW_SIZE )];
    image3.userInteractionEnabled = YES;
    image3.image = IMAGE(@"frame2@2x.png");
    UITapGestureRecognizer * forget=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(Answer)];
    [image3 addGestureRecognizer:forget];
    
    [_scrollView addSubview:image3];
    
    
    UILabel *answerLable=[[UILabel alloc]initWithFrame:CGRectMake(10*NOW_SIZE, 0, 270*NOW_SIZE,30*NOW_SIZE )];
    answerLable.text=@"回 复";
    answerLable.textAlignment=NSTextAlignmentCenter;
    answerLable.textColor=[UIColor blueColor];
    answerLable.font = [UIFont systemFontOfSize:14*NOW_SIZE];
    [image3 addSubview:answerLable];
    
}

-(void)Answer{
    AnswerViewController *AN=[[AnswerViewController alloc]init];
    [self.navigationController pushViewController:AN animated:NO];

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    myListSecondTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[myListSecondTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    [cell.contentView setBackgroundColor: [UIColor whiteColor] ];
    
    cell.nameLabel.text= self.nameArray[indexPath.row];
    cell.timeLabel.text= self.timeArray[indexPath.row];
    cell.contentLabel.text= self.contentArray[indexPath.row];
   
    cell.content=self.contentArray[indexPath.row];
    CGRect fcRect = [cell.content boundingRectWithSize:CGSizeMake(300*Width, 1000*Height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18 *Width]} context:nil];
    cell.contentLabel.frame =CGRectMake(10*Width, 25*Width, 280*Width, fcRect.size.height);
  //  cell.timeLabel.frame=CGRectMake(SCREEN_WIDTH-100*NOW_SIZE, 45*NOW_SIZE+fcRect.size.height,100*NOW_SIZE, 20*NOW_SIZE );
    cell.selectionStyle=UITableViewCellSelectionStyleGray;
    //NSLog(@"content=%@",cell.content);
    
    return cell;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _contentArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    CGRect fcRect = [self.contentArray[indexPath.row] boundingRectWithSize:CGSizeMake(300*Width, 1000*Height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18 *Width]} context:nil];
    return 5*Height+fcRect.size.height;
    
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
