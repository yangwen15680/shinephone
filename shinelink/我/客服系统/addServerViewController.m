//
//  addServerViewController.m
//  shinelink
//
//  Created by sky on 16/4/5.
//  Copyright © 2016年 sky. All rights reserved.
//

#import "addServerViewController.h"

@interface addServerViewController ()
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSArray *labelArray;
@property (nonatomic, strong) UITextField *userTextField;
@property (nonatomic, strong) UITextField *SNTextField;
@property (nonatomic, strong) UILabel* registLable;
@property (nonatomic, strong) UITextView *contentView;
@end

@implementation addServerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"提交问题";
     _labelArray=[[NSMutableArray alloc]initWithObjects:@"标题：", @"问题类型：", @"序列号：",@"内容：",nil];
    [self initUI];
}
-(void)initUI{
    _scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Height)];
    _scrollView.scrollEnabled=YES;
    _scrollView.contentSize = CGSizeMake(SCREEN_Width,600*NOW_SIZE);
    [self.view addSubview:_scrollView];
    float Size1=50*NOW_SIZE;
    
    for(int i=0;i<_labelArray.count;i++)
    {
    UILabel *PV1Lable=[[UILabel alloc]initWithFrame:CGRectMake(0*NOW_SIZE, 17*NOW_SIZE+Size1*i, 80*NOW_SIZE,20*NOW_SIZE )];
    PV1Lable.text=_labelArray[i];
    PV1Lable.textAlignment=NSTextAlignmentRight;
    PV1Lable.textColor=[UIColor blackColor];
    PV1Lable.font = [UIFont systemFontOfSize:14*NOW_SIZE];
    [_scrollView addSubview:PV1Lable];
    }
    
    for(int i=0;i<3;i++)
    {
        UIImageView *image1=[[UIImageView alloc]initWithFrame:CGRectMake(80*NOW_SIZE, 15*NOW_SIZE+Size1*i, 220*NOW_SIZE,30*NOW_SIZE )];
        image1.userInteractionEnabled = YES;
        image1.image = IMAGE(@"frame2@2x.png");
        [_scrollView addSubview:image1];
    }

            self.userTextField = [[UITextField alloc] initWithFrame:CGRectMake(85*NOW_SIZE, 15*NOW_SIZE, 220*NOW_SIZE,30*NOW_SIZE )];
            self.userTextField.placeholder = @"请输入标题";
            self.userTextField.textColor = [UIColor blackColor];
            self.userTextField.tintColor = [UIColor blackColor];
            [self.userTextField setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
            [self.userTextField setValue:[UIFont systemFontOfSize:12*NOW_SIZE] forKeyPath:@"_placeholderLabel.font"];
            self.userTextField.font = [UIFont systemFontOfSize:14*NOW_SIZE];
            [_scrollView addSubview:_userTextField];
    
            self.SNTextField = [[UITextField alloc] initWithFrame:CGRectMake(85*NOW_SIZE, 15*NOW_SIZE+Size1*2, 220*NOW_SIZE,30*NOW_SIZE )];
            self.SNTextField.placeholder = @"请输入序列号";
            self.SNTextField.textColor = [UIColor blackColor];
            self.SNTextField.tintColor = [UIColor blackColor];
            [self.SNTextField setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
            [self.SNTextField setValue:[UIFont systemFontOfSize:12*NOW_SIZE] forKeyPath:@"_placeholderLabel.font"];
            self.SNTextField.font = [UIFont systemFontOfSize:14*NOW_SIZE];
            [_scrollView addSubview:_SNTextField];
    
    self.registLable= [[UILabel alloc] initWithFrame:CGRectMake(85*NOW_SIZE, 15*NOW_SIZE+Size1*1, 220*NOW_SIZE,30*NOW_SIZE )];
    self.registLable.text=@"请选择问题类型";
    self.registLable.textColor=[UIColor grayColor];
    self.registLable.textAlignment = NSTextAlignmentLeft;
    self.registLable.font = [UIFont systemFontOfSize:14*NOW_SIZE];
    self.registLable.userInteractionEnabled=YES;
    [_scrollView addSubview:self.registLable];
    UITapGestureRecognizer * labelTap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapLable)];
    [self.registLable addGestureRecognizer:labelTap];
    
    UIImageView *image2=[[UIImageView alloc]initWithFrame:CGRectMake(80*NOW_SIZE, 15*NOW_SIZE+Size1*3, 220*NOW_SIZE,105*NOW_SIZE )];
    image2.userInteractionEnabled = YES;
    image2.image = IMAGE(@"frame2@2x.png");
    [_scrollView addSubview:image2];
    
    self.contentView = [[UITextView alloc] initWithFrame:CGRectMake(85*NOW_SIZE, 17*NOW_SIZE+Size1*3, 205*NOW_SIZE,100*NOW_SIZE )];
   // self.contentView.placeholder = @"请输入内容";
    self.contentView.textColor = [UIColor blackColor];
    self.contentView.tintColor = [UIColor blackColor];
   // [self.contentView setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
  //  [self.contentView setValue:[UIFont systemFontOfSize:12*NOW_SIZE] forKeyPath:@"_placeholderLabel.font"];
    self.contentView.font = [UIFont systemFontOfSize:14*NOW_SIZE];
    [_scrollView addSubview:_contentView];

    UILabel *PV1Lable1=[[UILabel alloc]initWithFrame:CGRectMake(0*NOW_SIZE, 17*NOW_SIZE+Size1*3+120*NOW_SIZE, 80*NOW_SIZE,20*NOW_SIZE )];
    PV1Lable1.text=@"附件：";
    PV1Lable1.textAlignment=NSTextAlignmentRight;
    PV1Lable1.textColor=[UIColor blackColor];
    PV1Lable1.font = [UIFont systemFontOfSize:14*NOW_SIZE];
    [_scrollView addSubview:PV1Lable1];
    
    UIImageView *image1=[[UIImageView alloc]initWithFrame:CGRectMake(80*NOW_SIZE, 17*NOW_SIZE+Size1*3+120*NOW_SIZE, 220*NOW_SIZE,30*NOW_SIZE )];
    image1.userInteractionEnabled = YES;
    image1.image = IMAGE(@"frame4@2x.png");
    [_scrollView addSubview:image1];
    
    UILabel *registLable1= [[UILabel alloc] initWithFrame:CGRectMake(85*NOW_SIZE, 17*NOW_SIZE+Size1*3+120*NOW_SIZE, 220*NOW_SIZE,30*NOW_SIZE )];
    registLable1.text=@"请选择要上传图片";
    registLable1.textColor=[UIColor grayColor];
    registLable1.textAlignment = NSTextAlignmentLeft;
    registLable1.font = [UIFont systemFontOfSize:14*NOW_SIZE];
    registLable1.userInteractionEnabled=YES;
    [_scrollView addSubview:registLable1];
    
    /*UIButton *firstB=[[UIButton alloc]initWithFrame:CGRectMake(85*NOW_SIZE, 25*NOW_SIZE+Size1*3+200*NOW_SIZE, 50*NOW_SIZE,50*NOW_SIZE )];
    [firstB setBackgroundImage:[UIImage imageNamed:@"add2@2x.png"] forState:UIControlStateNormal];
    [firstB addTarget:self action:@selector(controlThree) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:firstB];*/
    
    }

-(void)controlThree{

    
}

-(void)tapLable{

    UIAlertController * alertController = [UIAlertController alertControllerWithTitle: nil
                                                                              message: nil
                                                                       preferredStyle:UIAlertControllerStyleActionSheet];
    //添加Button
    [alertController addAction: [UIAlertAction actionWithTitle: @"逆变器故障" style: UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
       
        NSLog(@"问题");
        
    }]];
    [alertController addAction: [UIAlertAction actionWithTitle: @"储能机故障" style: UIAlertActionStyleDefault handler:^(UIAlertAction *action){
      
        
        
    }]];
    [alertController addAction: [UIAlertAction actionWithTitle: @"软件建议" style: UIAlertActionStyleDefault handler:^(UIAlertAction *action){
    
        
        
    }]];
    [alertController addAction: [UIAlertAction actionWithTitle: @"软件故障" style: UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        
        
        
    }]];
    [alertController addAction: [UIAlertAction actionWithTitle: @"其他设备故障" style: UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        
        
        
    }]];
    [alertController addAction: [UIAlertAction actionWithTitle: @"其他问题" style: UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        
        
        
    }]];
    [alertController addAction: [UIAlertAction actionWithTitle: @"取消" style: UIAlertActionStyleCancel handler:nil]];
    
    [self presentViewController: alertController animated: YES completion: nil];


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
