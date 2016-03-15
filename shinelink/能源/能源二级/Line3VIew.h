//
//  Line3VIew.h
//  shinelink
//
//  Created by sky on 16/3/11.
//  Copyright © 2016年 sky. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Line3VIew : UIView
@property(nonatomic,strong)NSString *flag;
@property (nonatomic, strong) UILabel *unitLabel;
@property (nonatomic, strong) UILabel *energyTitleLabel;

- (void)refreshLineChartViewWithDataDict:(NSMutableDictionary *)dataDict;

- (void)refreshBarChartViewWithDataDict:(NSMutableDictionary *)dataDict chartType:(NSInteger)type;
- (void)refreshLineAndBarWithDataDict:(NSMutableDictionary *)dataDict  barDict:(NSMutableDictionary *)barDict;
@end
