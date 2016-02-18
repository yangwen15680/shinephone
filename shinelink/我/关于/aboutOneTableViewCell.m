//
//  aboutOneTableViewCell.m
//  shinelink
//
//  Created by sky on 16/2/17.
//  Copyright © 2016年 sky. All rights reserved.
//

#import "aboutOneTableViewCell.h"

@implementation aboutOneTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor clearColor];
        
        self.imageLog = [[UIImageView alloc] initWithFrame:CGRectMake(5*NOW_SIZE, 10*NOW_SIZE, SCREEN_Width/5-20, SCREEN_Width/5-20)];
        
        [self.contentView addSubview:_imageLog];
        
        self.tableName = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_Width/5+10, 5*NOW_SIZE, 120*NOW_SIZE, SCREEN_Width/5-10)];
        self.tableName.font=[UIFont systemFontOfSize:18*NOW_SIZE];
        self.tableName.textAlignment = NSTextAlignmentLeft;
        self.tableName.textColor = [UIColor orangeColor];
        [self.contentView addSubview:_tableName];
        
        self.tableDetail = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_Width-200*NOW_SIZE, 7*NOW_SIZE, 200*NOW_SIZE, SCREEN_Width/5-10)];
        self.tableDetail.font=[UIFont systemFontOfSize:15*NOW_SIZE];
        self.tableDetail.textAlignment = NSTextAlignmentRight;
        self.tableDetail.textColor = [UIColor blackColor];
        [self.contentView addSubview:_tableDetail];
        
        
        
        
        
    }
    
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextFillRect(context, rect);
    
    CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:0xE2/255.0f green:0xE2/255.0f blue:0xE2/255.0f alpha:1].CGColor);
    CGContextStrokeRect(context, CGRectMake(0, rect.size.height - 1, rect.size.width, 1));
}

@end
