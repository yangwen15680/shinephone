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
#import "AddCellectViewController.h"

@interface registerViewController ()<UITextFieldDelegate>
@property(nonatomic,strong) UILabel *name;
@property(nonatomic,strong)NSMutableArray *textFieldMutableArray;
@property (nonatomic, strong) NSMutableDictionary *dataDic;
@property(nonatomic,strong)UIScrollView *backScroll;

@end

@implementation registerViewController

- (instancetype)initWithDataDict:(NSMutableDictionary *)dataDict {
    if (self = [super init]) {
        self.dataDic = [NSMutableDictionary dictionaryWithDictionary:dataDict];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
    //获取本地语言
    NSArray *languages = [NSLocale preferredLanguages];
    NSString *regLanguage = [languages objectAtIndex:0];
 
     //获取时区
    NSTimeZone *regTimeZone1 = [NSTimeZone systemTimeZone];
    NSInteger regTimeZone = [regTimeZone1 secondsFromGMT]/3600;
   
     [_dataDic setObject:regLanguage forKey:@"regLanguage"];
    [_dataDic setObject:[NSNumber numberWithInteger:regTimeZone] forKey:@"regTimeZone"];
    //[NSNumber numberWithInt:i
   
}

-(void)initUI{
    UIImage *bgImage = IMAGE(@"loginbg.jpg");
    self.view.layer.contents = (id)bgImage.CGImage;
     _textFieldMutableArray=[NSMutableArray new];
    
     self.automaticallyAdjustsScrollViewInsets = NO;
    _backScroll=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Height+60*NOW_SIZE)];
    _backScroll.scrollEnabled=YES;
       _backScroll.contentSize = CGSizeMake(SCREEN_Width,750*NOW_SIZE);
    [self.view addSubview:_backScroll];
    
    NSArray *imageArray=[NSArray arrayWithObjects:@"icon---Name.png", @"icon---Password.png", @"icon---Password.png", @"icon---Email.png", @"iconfont-shouji.png",nil];
    NSArray *labelArray=[NSArray arrayWithObjects:@"用户名", @"密码", @"重复密码",@"电子邮箱", @"联系电话", nil];
    NSArray *textFieldArray=[NSArray arrayWithObjects:root_Enter_your_username,root_Enter_your_pwd, @"Enter your pwd again", root_Enter_email, root_Enter_phone_number, nil];
   
    for (int i=0; i<5; i++) {
        UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(30*NOW_SIZE,17*NOW_SIZE+i*60*NOW_SIZE+moveHeight,15*NOW_SIZE, 15*NOW_SIZE)];
        imageView.contentMode=UIViewContentModeScaleAspectFit;
        imageView.clipsToBounds=YES;
        imageView.image=[UIImage imageNamed:imageArray[i]];
        [_backScroll addSubview:imageView];
        
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(50*NOW_SIZE,10*NOW_SIZE+i*60*NOW_SIZE+moveHeight, 100*NOW_SIZE, 30*NOW_SIZE)];
        label.text=labelArray[i];
        label.font = [UIFont systemFontOfSize:12*NOW_SIZE];
        label.textColor=[UIColor whiteColor];
        [_backScroll addSubview:label];
        
        UIView *line=[[UIView alloc]initWithFrame:CGRectMake(30*NOW_SIZE,40*NOW_SIZE+i*60*NOW_SIZE+moveHeight, 260*NOW_SIZE, 0.5)];
        line.backgroundColor=[UIColor whiteColor];
        [_backScroll addSubview:line];
        
        UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(155*NOW_SIZE,10*NOW_SIZE+i*60*NOW_SIZE+moveHeight, 135*NOW_SIZE, 30*NOW_SIZE)];
        textField.placeholder =textFieldArray[i];
        textField.textColor = [UIColor whiteColor];
        textField.tintColor = [UIColor whiteColor];
        [textField setValue:[UIColor lightTextColor] forKeyPath:@"_placeholderLabel.textColor"];
        [textField setValue:[UIFont systemFontOfSize:11*NOW_SIZE] forKeyPath:@"_placeholderLabel.font"];
        textField.font = [UIFont systemFontOfSize:11*NOW_SIZE];
        textField.tag = i;
        textField.delegate = self;
        [_backScroll addSubview:textField];
         [_textFieldMutableArray addObject:textField];
        if (i == 1|| i == 2) {
            textField.keyboardType = UIKeyboardTypeEmailAddress;
            textField.secureTextEntry = YES;
        }
        if (i == 3) {
            textField.keyboardType = UIKeyboardTypeEmailAddress;
        }
        if (i == 4) {
            textField.keyboardType = UIKeyboardTypeEmailAddress;
        }
    }
    
    
    
    UIButton *goBut =  [UIButton buttonWithType:UIButtonTypeCustom];
    goBut.frame=CGRectMake(60*NOW_SIZE,310*NOW_SIZE+moveHeight, 200*NOW_SIZE, 40*NOW_SIZE);
    [goBut.layer setMasksToBounds:YES];
    [goBut.layer setCornerRadius:25.0];
    goBut.backgroundColor = [UIColor colorWithRed:130/255.0f green:200/255.0f blue:250/255.0f alpha:1];
    [goBut setTitle:@"下一步" forState:UIControlStateNormal];
    [goBut addTarget:self action:@selector(PresentGo) forControlEvents:UIControlEventTouchUpInside];
  //  goBut.highlighted=[UIColor grayColor];
    [_backScroll addSubview:goBut];
    

}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    for (UITextField *textField in _textFieldMutableArray) {
        [textField resignFirstResponder];
    }
    
    return YES;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
   for (UITextField *textField in _textFieldMutableArray) {
        [textField resignFirstResponder];
    }
}

- (void)showToastViewWithTitle:(NSString *)title {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.animationType = MBProgressHUDAnimationZoom;
    hud.labelText = title;
    hud.margin = 10.f;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:1.5];
}


//判断是否是正确的email
-(BOOL)isValidateEmail:(NSString *)email {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}



//判断手机号码
- (BOOL)isValidateTel:(NSString *)tel {
    NSString *regex = @"^((13[0-9])|(147)|(15[^4,\\D])|(18[0-9]))\\d{8}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [pred evaluateWithObject:tel];
}

-(void)PresentGo{
    NSArray *array=[[NSArray alloc]initWithObjects:@"请输入用户名",@"请输入密码",@"请输入密码",@"请输入邮箱",@"请输入电话",nil];
    for (int i=0; i<5; i++) {
        if ([[_textFieldMutableArray[i] text] isEqual:@""]) {
            [self showToastViewWithTitle:array[i]];
            return;
        }
    }
    
    if (![[_textFieldMutableArray[1] text] isEqual:[_textFieldMutableArray[2] text] ]) {
        [self showToastViewWithTitle:@"请输入相同的密码"];
        return;
    }
    
    if ([[_textFieldMutableArray[0] text] length]<3) {
        [self showToastViewWithTitle:@"用户名必须大于3位"];
        return;
    }
    
    if ([[_textFieldMutableArray[1] text] length]<6) {
        [self showToastViewWithTitle:@"密码必须大于6位"];
        return;
    }
    
    if (![self isValidateEmail:[_textFieldMutableArray[3] text]]) {
        [self showToastViewWithTitle:@"请输入正确邮箱格式"];
        return;
    }
    if (![self isValidateTel:[_textFieldMutableArray[4] text]]) {
        [self showToastViewWithTitle:@"请输入正确电话"];
        return;
    }
    
     [_dataDic setObject:[_textFieldMutableArray[0] text] forKey:@"regUserName"];
     [_dataDic setObject:[_textFieldMutableArray[1] text] forKey:@"regPassword"];
     [_dataDic setObject:[_textFieldMutableArray[3] text] forKey:@"regEmail"];
     [_dataDic setObject:[_textFieldMutableArray[4] text] forKey:@"regPhoneNumber"];
    
    AddCellectViewController *reg=[[AddCellectViewController alloc]initWithDataDict:_dataDic];
    //[self presentViewController:reg animated:YES completion:nil];
   [self. navigationController pushViewController:reg animated:YES];
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
