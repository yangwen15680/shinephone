//
//  ExtensionTwoViewController.m
//  shinelink
//
//  Created by sky on 16/5/18.
//  Copyright © 2016年 sky. All rights reserved.
//

#import "ExtensionTwoViewController.h"

  #define  headH2 100*HEIGHT_SIZE

@interface ExtensionTwoViewController ()
@property (nonatomic, strong) UIScrollView *scrollView2;
@property (nonatomic, strong) UILabel *title1;
@property (nonatomic, strong) UITextView *detail;
@property (nonatomic, strong) NSString *outline;
@property (nonatomic, strong) NSString *area;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSString *phoneNum;
@property (nonatomic, strong) NSString *reconmend;
@property (nonatomic, strong) NSString *supplier;
@end

@implementation ExtensionTwoViewController
{

    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self netExtension];
    
}

-(void)netExtension{

    [BaseRequest requestWithMethodResponseJsonByGet:HEAD_URL paramars:@{@"id":_idString} paramarsSite:@"/newExtensionAPI.do?op=getExtensionInfo" sucessBlock:^(id content) {
        [self hideProgressView];
        NSLog(@"getExtensionInfo=: %@", content);
        
        if(content){
           
            _outline=content[@"outline"];
            _supplier=content[@"supplier"];
            _area=content[@"area"];
            _price=content[@"price"];
            _phoneNum=content[@"phoneNum"];
            _reconmend=content[@"recommend"];
            
            [self uiOne];
        }
        
    } failure:^(NSError *error) {
        [self hideProgressView];
        
    }];

    
}


-(void)uiOne{
    
    _scrollView2=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Height)];
    _scrollView2.scrollEnabled=YES;
    _scrollView2.contentSize = CGSizeMake(SCREEN_Width,1000*NOW_SIZE);
    [self.view addSubview:_scrollView2];
    
    _title1=[[UILabel alloc]initWithFrame:CGRectMake(10*NOW_SIZE,10*HEIGHT_SIZE, 300*NOW_SIZE,25*HEIGHT_SIZE )];
    _title1.text=_name2;
    _title1.textAlignment=NSTextAlignmentCenter;
    _title1.textColor=COLOR(0, 0, 0, 1);
    _title1.font = [UIFont systemFontOfSize:16*HEIGHT_SIZE];
    [_scrollView2 addSubview:_title1];
    
    UIView *line3=[[UIView alloc]initWithFrame:CGRectMake(10*NOW_SIZE,10*HEIGHT_SIZE+30*HEIGHT_SIZE, 300*NOW_SIZE,1*HEIGHT_SIZE )];
    line3.backgroundColor=[UIColor grayColor];
    [_scrollView2 addSubview:line3];
    
    
    UILabel *outlineTitle=[[UILabel alloc]initWithFrame:CGRectMake(10*NOW_SIZE,45*HEIGHT_SIZE, 300*NOW_SIZE,20*HEIGHT_SIZE )];
    outlineTitle.text=@"概述";
    outlineTitle.textAlignment=NSTextAlignmentLeft;
    outlineTitle.textColor=COLOR(0, 0, 0, 1);
    outlineTitle.font = [UIFont systemFontOfSize:14*HEIGHT_SIZE];
    [_scrollView2 addSubview:outlineTitle];
    
    _detail=[[UITextView alloc]initWithFrame:CGRectMake(10*NOW_SIZE,70*HEIGHT_SIZE, 300*NOW_SIZE,headH2)];
    _detail.text=_outline;
    _detail.editable=NO;
    _detail.textAlignment=NSTextAlignmentLeft;
    _detail.textColor=COLOR(60, 60, 60, 1);
    _detail.font = [UIFont systemFontOfSize:12*HEIGHT_SIZE];
    [_scrollView2 addSubview:_detail];
    

    
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
