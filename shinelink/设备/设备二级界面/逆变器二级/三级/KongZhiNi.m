//
//  KongZhiNi.m
//  shinelink
//
//  Created by sky on 16/3/24.
//  Copyright © 2016年 sky. All rights reserved.
//

#import "KongZhiNi.h"
#import "ASValueTrackingSlider.h"
@interface KongZhiNi ()

@end

@implementation KongZhiNi

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImage *bgImage = IMAGE(@"bg4.png");
    self.view.layer.contents = (id)bgImage.CGImage;
    [self initUI];
    
}

-(void)initUI{
    float buttonSize=70*NOW_SIZE;
    UILabel *buttonLable=[[UILabel alloc]initWithFrame:CGRectMake((SCREEN_Width-100*NOW_SIZE)/2, 60*NOW_SIZE, 100*NOW_SIZE,20*NOW_SIZE )];
    buttonLable.text=@"开关机";
    buttonLable.textAlignment=NSTextAlignmentCenter;
    buttonLable.textColor=[UIColor whiteColor];
    buttonLable.font = [UIFont systemFontOfSize:18*NOW_SIZE];
    [self.view addSubview:buttonLable];
    
    UIButton *firstB=[[UIButton alloc]initWithFrame:CGRectMake((SCREEN_Width-buttonSize)/2, 85*NOW_SIZE, buttonSize,buttonSize)];
    [firstB setImage:[UIImage imageNamed:@"open@2x.png"] forState:UIControlStateNormal];
    [firstB addTarget:self action:@selector(control) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:firstB];
    
    UILabel *PVLable=[[UILabel alloc]initWithFrame:CGRectMake(10*NOW_SIZE, 85*NOW_SIZE+buttonSize+5*NOW_SIZE, 150*NOW_SIZE,20*NOW_SIZE )];
    PVLable.text=@"设置有效功率";
    PVLable.textAlignment=NSTextAlignmentLeft;
    PVLable.textColor=[UIColor whiteColor];
    PVLable.font = [UIFont systemFontOfSize:16*NOW_SIZE];
    [self.view addSubview:PVLable];
    ASValueTrackingSlider *slider=[[ASValueTrackingSlider alloc]initWithFrame:CGRectMake(20*NOW_SIZE, 85*NOW_SIZE+buttonSize+30*NOW_SIZE, SCREEN_Width-40*NOW_SIZE, 40*NOW_SIZE)];
   slider.maximumValue = 1.0;
    [self.view addSubview:slider];
    UILabel *PVLable1=[[UILabel alloc]initWithFrame:CGRectMake(15*NOW_SIZE, 85*NOW_SIZE+buttonSize+5*NOW_SIZE+55*NOW_SIZE, 150*NOW_SIZE,20*NOW_SIZE )];
    PVLable1.text=@"0";
    PVLable1.textAlignment=NSTextAlignmentLeft;
    PVLable1.textColor=[UIColor whiteColor];
    PVLable1.font = [UIFont systemFontOfSize:16*NOW_SIZE];
    [self.view addSubview:PVLable1];
    UILabel *PVLable2=[[UILabel alloc]initWithFrame:CGRectMake(SCREEN_Width-22*NOW_SIZE, 85*NOW_SIZE+buttonSize+5*NOW_SIZE+55*NOW_SIZE, 150*NOW_SIZE,20*NOW_SIZE )];
    PVLable2.text=@"1";
    PVLable2.textAlignment=NSTextAlignmentLeft;
    PVLable2.textColor=[UIColor whiteColor];
    PVLable2.font = [UIFont systemFontOfSize:16*NOW_SIZE];
    [self.view addSubview:PVLable2];
    
    UILabel *PV1Lable=[[UILabel alloc]initWithFrame:CGRectMake(10*NOW_SIZE, 85*NOW_SIZE+buttonSize+5*NOW_SIZE+85*NOW_SIZE, 150*NOW_SIZE,20*NOW_SIZE )];
    PV1Lable.text=@"设置无功功率";
    PV1Lable.textAlignment=NSTextAlignmentLeft;
    PV1Lable.textColor=[UIColor whiteColor];
    PV1Lable.font = [UIFont systemFontOfSize:16*NOW_SIZE];
    [self.view addSubview:PV1Lable];
    ASValueTrackingSlider *slider1=[[ASValueTrackingSlider alloc]initWithFrame:CGRectMake(20*NOW_SIZE, 85*NOW_SIZE+buttonSize+30*NOW_SIZE+85*NOW_SIZE, SCREEN_Width-40*NOW_SIZE, 40*NOW_SIZE)];
    slider1.maximumValue = 1;
    [self.view addSubview:slider1];
    UILabel *PV1Lable1=[[UILabel alloc]initWithFrame:CGRectMake(15*NOW_SIZE, 85*NOW_SIZE+buttonSize+5*NOW_SIZE+55*NOW_SIZE+85*NOW_SIZE, 150*NOW_SIZE,20*NOW_SIZE )];
    PV1Lable1.text=@"0";
    PV1Lable1.textAlignment=NSTextAlignmentLeft;
    PV1Lable1.textColor=[UIColor whiteColor];
    PV1Lable1.font = [UIFont systemFontOfSize:16*NOW_SIZE];
    [self.view addSubview:PV1Lable1];
    UILabel *PV1Lable2=[[UILabel alloc]initWithFrame:CGRectMake(SCREEN_Width-22*NOW_SIZE, 85*NOW_SIZE+buttonSize+5*NOW_SIZE+55*NOW_SIZE+85*NOW_SIZE, 150*NOW_SIZE,20*NOW_SIZE )];
    PV1Lable2.text=@"1";
    PV1Lable2.textAlignment=NSTextAlignmentLeft;
    PV1Lable2.textColor=[UIColor whiteColor];
    PV1Lable2.font = [UIFont systemFontOfSize:16*NOW_SIZE];
    [self.view addSubview:PV1Lable2];
    
    UILabel *PV2Lable=[[UILabel alloc]initWithFrame:CGRectMake(10*NOW_SIZE, 85*NOW_SIZE+buttonSize+5*NOW_SIZE+85*NOW_SIZE*2, 150*NOW_SIZE,20*NOW_SIZE )];
    PV2Lable.text=@"设置PF值";
    PV2Lable.textAlignment=NSTextAlignmentLeft;
    PV2Lable.textColor=[UIColor whiteColor];
    PV2Lable.font = [UIFont systemFontOfSize:16*NOW_SIZE];
    [self.view addSubview:PV2Lable];
    ASValueTrackingSlider *slider2=[[ASValueTrackingSlider alloc]initWithFrame:CGRectMake(20*NOW_SIZE, 85*NOW_SIZE+buttonSize+30*NOW_SIZE+85*NOW_SIZE*2, SCREEN_Width-40*NOW_SIZE, 40*NOW_SIZE)];
    slider2.maximumValue = 0.8;
    slider2.minimumValue=-0.8;
    [self.view addSubview:slider2];
    UILabel *PV2Lable1=[[UILabel alloc]initWithFrame:CGRectMake(15*NOW_SIZE, 85*NOW_SIZE+buttonSize+5*NOW_SIZE+55*NOW_SIZE+85*NOW_SIZE*2, 150*NOW_SIZE,20*NOW_SIZE )];
    PV2Lable1.text=@"-0.8";
    PV2Lable1.textAlignment=NSTextAlignmentLeft;
    PV2Lable1.textColor=[UIColor whiteColor];
    PV2Lable1.font = [UIFont systemFontOfSize:16*NOW_SIZE];
    [self.view addSubview:PV2Lable1];
    UILabel *PV2Lable2=[[UILabel alloc]initWithFrame:CGRectMake(SCREEN_Width-22*NOW_SIZE, 85*NOW_SIZE+buttonSize+5*NOW_SIZE+55*NOW_SIZE+85*NOW_SIZE*2, 150*NOW_SIZE,20*NOW_SIZE )];
    PV2Lable2.text=@"0.8";
    PV2Lable2.textAlignment=NSTextAlignmentLeft;
    PV2Lable2.textColor=[UIColor whiteColor];
    PV2Lable2.font = [UIFont systemFontOfSize:16*NOW_SIZE];
    [self.view addSubview:PV2Lable2];


}

-(void)control{

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
