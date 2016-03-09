//
//  secondViewController.m
//  shinelink
//
//  Created by sky on 16/3/9.
//  Copyright © 2016年 sky. All rights reserved.
//

#import "secondViewController.h"
#import "CircleView.h"
#import"DTKDropdownMenuView.h"

#define ColorWithRGB(r,g,b) [UIColor colorWithRed:r/255. green:g/255. blue:b/255. alpha:1]

@interface secondViewController ()
// 进度增长步长
@property (nonatomic, assign) CGFloat step;

@property (nonatomic, strong) CircleView *progressView;

@property (nonatomic, strong) NSTimer *timer;
@end

@implementation secondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView *processView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 200*NOW_SIZE)];
    [self.view addSubview:processView];
        [self addRightItem];
    
    _progressView = [[CircleView alloc] initWithFrame:CGRectMake(0, 0, 150, 150)];
    CGPoint center = CGPointMake(CGRectGetMidX( [UIScreen mainScreen].bounds), 100*NOW_SIZE);
    _progressView.center = center;
    _progressView.startAngle = - M_PI*1 ;
    _progressView.endAngle   = 0;
    [processView addSubview:_progressView];
    self.step = 1.0 / 30;
    _timer = [NSTimer scheduledTimerWithTimeInterval:self.step target:self selector:@selector(updateProgress) userInfo:nil repeats:YES];
    
}
- (void)addRightItem
{

    DTKDropdownItem *item0 = [DTKDropdownItem itemWithTitle:@"高级设置" iconName:@"DTK_jiangbei" callBack:^(NSUInteger index, id info) {
        NSLog(@"rightItem%lu",(unsigned long)index);
      
    }];
    DTKDropdownItem *item1 = [DTKDropdownItem itemWithTitle:@"基本信息" iconName:@"DTK_renwu" callBack:^(NSUInteger index, id info) {
        NSLog(@"rightItem%lu",(unsigned long)index);
    
    }];
    DTKDropdownItem *item2 = [DTKDropdownItem itemWithTitle:@"日志" iconName:@"DTK_update" callBack:^(NSUInteger index, id info) {
        NSLog(@"rightItem%lu",(unsigned long)index);

    }];
   
    DTKDropdownMenuView *menuView = [DTKDropdownMenuView dropdownMenuViewWithType:dropDownTypeRightItem frame:CGRectMake(0, 0, 44.f, 44.f) dropdownItems:@[item0,item1,item2] icon:@"DTK_bi"];
    
    menuView.dropWidth = 150.f;
    menuView.titleFont = [UIFont systemFontOfSize:18.f];
    menuView.textColor = ColorWithRGB(102.f, 102.f, 102.f);
    menuView.textFont = [UIFont systemFontOfSize:13.f];
    menuView.cellSeparatorColor = ColorWithRGB(229.f, 229.f, 229.f);
    menuView.textFont = [UIFont systemFontOfSize:14.f];
    menuView.animationDuration = 0.2f;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:menuView];
}

- (void)updateProgress {
    CGFloat progress = self.progressView.progress;
    if (progress > 100) {
        [_timer invalidate];
        _timer = nil;
        return;
    }
    progress += 0.3;
    self.progressView.progress = progress;
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
