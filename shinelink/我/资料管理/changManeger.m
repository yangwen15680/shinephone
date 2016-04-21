//
//  changManeger.m
//  shinelink
//
//  Created by sky on 16/4/21.
//  Copyright © 2016年 sky. All rights reserved.
//

#import "changManeger.h"

@interface changManeger ()
@property (nonatomic, strong)UITextField *textField;
@property (nonatomic, strong)UITextField *textField1;
@property (nonatomic, strong)UITextField *textField2;
@property (nonatomic, strong)UITextField *textField3;

@end

@implementation changManeger

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImage *bgImage = IMAGE(@"bg4.png");
    self.view.layer.contents = (id)bgImage.CGImage;
    
    [self initUI];
    
}

-(void)initUI{
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    //将触摸事件添加到当前view
    [self.view addGestureRecognizer:tapGestureRecognizer];

    float Size1=40*NOW_SIZE;
    
      if([_type isEqualToString:@"0"]){
    UILabel *PV1=[[UILabel alloc]initWithFrame:CGRectMake(10*NOW_SIZE,75*NOW_SIZE+10*NOW_SIZE, 180*NOW_SIZE,20*NOW_SIZE )];
    PV1.text=@"请输入密码：";
    PV1.textAlignment=NSTextAlignmentLeft;
    PV1.textColor=[UIColor whiteColor];
    PV1.font = [UIFont systemFontOfSize:16*NOW_SIZE];
    [self.view addSubview:PV1];
    
    UIView *line3=[[UIView alloc]initWithFrame:CGRectMake(160*NOW_SIZE,75*NOW_SIZE+30*NOW_SIZE, 150*NOW_SIZE,1*NOW_SIZE )];
    line3.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:line3];
    
    _textField = [[UITextField alloc] initWithFrame:CGRectMake(200*NOW_SIZE,75*NOW_SIZE+10*NOW_SIZE, 300*NOW_SIZE,20*NOW_SIZE )];
    _textField.textColor = [UIColor whiteColor];
    _textField.tintColor = [UIColor whiteColor];
    _textField.font = [UIFont systemFontOfSize:16*NOW_SIZE];
    //_textField.delegate=self;
    [self.view addSubview:_textField];
          
          UILabel *PV2=[[UILabel alloc]initWithFrame:CGRectMake(10*NOW_SIZE,75*NOW_SIZE+10*NOW_SIZE+Size1, 180*NOW_SIZE,20*NOW_SIZE )];
          PV2.text=@"请再次输入密码：";
          PV2.textAlignment=NSTextAlignmentLeft;
          PV2.textColor=[UIColor whiteColor];
          PV2.font = [UIFont systemFontOfSize:16*NOW_SIZE];
          [self.view addSubview:PV2];
          
          UIView *line4=[[UIView alloc]initWithFrame:CGRectMake(160*NOW_SIZE,75*NOW_SIZE+30*NOW_SIZE+Size1, 150*NOW_SIZE,1*NOW_SIZE )];
          line4.backgroundColor=[UIColor whiteColor];
          [self.view addSubview:line4];
          
          _textField1 = [[UITextField alloc] initWithFrame:CGRectMake(200*NOW_SIZE,75*NOW_SIZE+10*NOW_SIZE+Size1, 300*NOW_SIZE,20*NOW_SIZE )];
          _textField1.textColor = [UIColor whiteColor];
          _textField1.tintColor = [UIColor whiteColor];
          _textField1.font = [UIFont systemFontOfSize:16*NOW_SIZE];
          //_textField.delegate=self;
          [self.view addSubview:_textField1];
          
      }

    if([_type isEqualToString:@"1"]){
        UILabel *PV2=[[UILabel alloc]initWithFrame:CGRectMake(10*NOW_SIZE,75*NOW_SIZE+10*NOW_SIZE+Size1, 180*NOW_SIZE,20*NOW_SIZE )];
        PV2.text=@"请输入手机号：";
        PV2.textAlignment=NSTextAlignmentLeft;
        PV2.textColor=[UIColor whiteColor];
        PV2.font = [UIFont systemFontOfSize:16*NOW_SIZE];
        [self.view addSubview:PV2];
        
        UIView *line4=[[UIView alloc]initWithFrame:CGRectMake(160*NOW_SIZE,75*NOW_SIZE+30*NOW_SIZE+Size1, 150*NOW_SIZE,1*NOW_SIZE )];
        line4.backgroundColor=[UIColor whiteColor];
        [self.view addSubview:line4];
        
        _textField2 = [[UITextField alloc] initWithFrame:CGRectMake(200*NOW_SIZE,75*NOW_SIZE+10*NOW_SIZE+Size1, 300*NOW_SIZE,20*NOW_SIZE )];
        _textField2.textColor = [UIColor whiteColor];
        _textField2.tintColor = [UIColor whiteColor];
        _textField2.font = [UIFont systemFontOfSize:16*NOW_SIZE];
        //_textField.delegate=self;
        [self.view addSubview:_textField2];
    }
    
    if([_type isEqualToString:@"2"]){
        UILabel *PV2=[[UILabel alloc]initWithFrame:CGRectMake(10*NOW_SIZE,75*NOW_SIZE+10*NOW_SIZE+Size1, 180*NOW_SIZE,20*NOW_SIZE )];
        PV2.text=@"请输入邮箱地址：";
        PV2.textAlignment=NSTextAlignmentLeft;
        PV2.textColor=[UIColor whiteColor];
        PV2.font = [UIFont systemFontOfSize:16*NOW_SIZE];
        [self.view addSubview:PV2];
        
        UIView *line4=[[UIView alloc]initWithFrame:CGRectMake(160*NOW_SIZE,75*NOW_SIZE+30*NOW_SIZE+Size1, 150*NOW_SIZE,1*NOW_SIZE )];
        line4.backgroundColor=[UIColor whiteColor];
        [self.view addSubview:line4];
        
        _textField3 = [[UITextField alloc] initWithFrame:CGRectMake(200*NOW_SIZE,75*NOW_SIZE+10*NOW_SIZE+Size1, 300*NOW_SIZE,20*NOW_SIZE )];
        _textField3.textColor = [UIColor whiteColor];
        _textField3.tintColor = [UIColor whiteColor];
        _textField3.font = [UIFont systemFontOfSize:16*NOW_SIZE];
        //_textField.delegate=self;
        [self.view addSubview:_textField3];
    }
    
    UIButton *goBut =  [UIButton buttonWithType:UIButtonTypeCustom];
    goBut.frame=CGRectMake(60*NOW_SIZE,210*NOW_SIZE, 200*NOW_SIZE, 40*NOW_SIZE);
    [goBut.layer setMasksToBounds:YES];
    [goBut.layer setCornerRadius:25.0];
    [goBut setBackgroundImage:IMAGE(@"按钮2.png") forState:UIControlStateNormal];
    [goBut setTitle:@"完成" forState:UIControlStateNormal];
    [goBut addTarget:self action:@selector(finishSet1) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:goBut];
    
}

-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    [_textField resignFirstResponder];
    [_textField1 resignFirstResponder];
     [_textField2 resignFirstResponder];
     [_textField3 resignFirstResponder];
}

-(void)finishSet1{


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
