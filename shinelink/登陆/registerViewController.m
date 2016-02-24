//
//  registerViewController.m
//  shinelink
//
//  Created by sky on 16/2/23.
//  Copyright © 2016年 sky. All rights reserved.
//
#define moveHeight 100*NOW_SIZE
#import "registerViewController.h"
#import "loginViewController.h"
#import "countryViewController.h"

@interface registerViewController ()<UITextFieldDelegate>
@property(nonatomic,strong) UILabel *name;

@end

@implementation registerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initUI];
}

-(void)initUI{
    UIImage *bgImage = IMAGE(@"loginbg.jpg");
    self.view.layer.contents = (id)bgImage.CGImage;
    
    NSArray *imageArray=[NSArray arrayWithObjects:@"icon---Name.png", @"icon---Password.png", @"icon---Email.png", @"iconfont-shouji.png",nil];
    NSArray *labelArray=[NSArray arrayWithObjects:@"用户名", @"密码", @"电子邮箱", @"联系电话", nil];
    NSArray *textFieldArray=[NSArray arrayWithObjects:root_Enter_your_username, root_Enter_your_pwd, root_Enter_email, root_Enter_phone_number, nil];
   
    for (int i=0; i<4; i++) {
        UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(30*NOW_SIZE,17*NOW_SIZE+i*60*NOW_SIZE+moveHeight,15*NOW_SIZE, 15*NOW_SIZE)];
        imageView.contentMode=UIViewContentModeScaleAspectFit;
        imageView.clipsToBounds=YES;
        imageView.image=[UIImage imageNamed:imageArray[i]];
        [self.view addSubview:imageView];
        
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(50*NOW_SIZE,10*NOW_SIZE+i*60*NOW_SIZE+moveHeight, 100*NOW_SIZE, 30*NOW_SIZE)];
        label.text=labelArray[i];
        label.font = [UIFont systemFontOfSize:12*NOW_SIZE];
        label.textColor=[UIColor whiteColor];
        [self.view addSubview:label];
        
        UIView *line=[[UIView alloc]initWithFrame:CGRectMake(30*NOW_SIZE,40*NOW_SIZE+i*60*NOW_SIZE+moveHeight, 260*NOW_SIZE, 0.5)];
        line.backgroundColor=[UIColor whiteColor];
        [self.view addSubview:line];
        
        UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(155*NOW_SIZE,10*NOW_SIZE+i*60*NOW_SIZE+moveHeight, 135*NOW_SIZE, 30*NOW_SIZE)];
        textField.placeholder =textFieldArray[i];
        textField.textColor = [UIColor whiteColor];
        textField.tintColor = [UIColor whiteColor];
        [textField setValue:[UIColor lightTextColor] forKeyPath:@"_placeholderLabel.textColor"];
        [textField setValue:[UIFont systemFontOfSize:11*NOW_SIZE] forKeyPath:@"_placeholderLabel.font"];
        textField.font = [UIFont systemFontOfSize:11*NOW_SIZE];
        textField.tag = i;
        textField.delegate = self;
        [self.view addSubview:textField];
        if (i == 1 ) {
            textField.keyboardType = UIKeyboardTypeASCIICapable;
            textField.secureTextEntry = YES;
        }
        if (i == 2) {
            textField.keyboardType = UIKeyboardTypeEmailAddress;
        }
        if (i == 3) {
            textField.keyboardType = UIKeyboardTypePhonePad;
        }
    }
    
    UIButton *backBut =  [UIButton buttonWithType:UIButtonTypeCustom];
    backBut.frame=CGRectMake(30*NOW_SIZE,280*NOW_SIZE+moveHeight, 100*NOW_SIZE, 30*NOW_SIZE);
    [backBut.layer setMasksToBounds:YES];
    [backBut.layer setCornerRadius:15.0];
    backBut.backgroundColor = [UIColor colorWithRed:130/255.0f green:200/255.0f blue:250/255.0f alpha:1];
    [backBut setTitle:@"返回" forState:UIControlStateNormal];
    [backBut addTarget:self action:@selector(Presentback) forControlEvents:UIControlEventTouchUpInside];
    backBut.highlighted=[UIColor grayColor];
    [self.view addSubview:backBut];
    
    UIButton *goBut =  [UIButton buttonWithType:UIButtonTypeCustom];
    goBut.frame=CGRectMake(190*NOW_SIZE,280*NOW_SIZE+moveHeight, 100*NOW_SIZE, 30*NOW_SIZE);
    [goBut.layer setMasksToBounds:YES];
    [goBut.layer setCornerRadius:15.0];
    goBut.backgroundColor = [UIColor colorWithRed:130/255.0f green:200/255.0f blue:250/255.0f alpha:1];
    [goBut setTitle:@"完成" forState:UIControlStateNormal];
    [goBut addTarget:self action:@selector(PresentGo) forControlEvents:UIControlEventTouchUpInside];
    goBut.highlighted=[UIColor grayColor];
    [self.view addSubview:goBut];
    

}

-(void)PresentGo{
    loginViewController *reg=[[loginViewController alloc]init];
    [self presentViewController:reg animated:YES completion:nil];
    // [self. navigationController pushViewController:reg animated:YES];
}

-(void)Presentback{
    countryViewController *log=[[countryViewController alloc]init];
    
    [self presentViewController:log animated:YES completion:nil];
    
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
