//
//  listTableViewCell.m
//  shinelink
//
//  Created by sky on 16/2/29.
//  Copyright © 2016年 sky. All rights reserved.
//

#import "listTableViewCell.h"


#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define Width [UIScreen mainScreen].bounds.size.width/320.0
#define Height [UIScreen mainScreen].bounds.size.height/568.0

@implementation listTableViewCell

- (void)awakeFromNib {
    // Initialization code
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UIView *titleView=[[UIView alloc]initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH, 40*NOW_SIZE) ];
        titleView.backgroundColor=mainColor;
        [self addSubview:titleView];
        
        _titleLabel =[[UILabel alloc]initWithFrame:CGRectMake(5*NOW_SIZE, 5*NOW_SIZE,200*NOW_SIZE, 30*NOW_SIZE) ];
        _titleLabel.font =[UIFont systemFontOfSize:18];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.textAlignment =NSTextAlignmentLeft;
        [titleView addSubview:_titleLabel];
        
        _statusLabel =[[UILabel alloc]initWithFrame:CGRectMake(205*NOW_SIZE, 5*NOW_SIZE,SCREEN_WIDTH-215*NOW_SIZE, 30*NOW_SIZE) ];
        _statusLabel.font =[UIFont systemFontOfSize:18];
        _statusLabel.textColor = [UIColor whiteColor];
        _statusLabel.textAlignment =NSTextAlignmentRight;
        [titleView addSubview:_statusLabel];
        
    
        
        _contentLabel =[[UILabel alloc]init];
        _contentLabel.font =[UIFont systemFontOfSize:18];
        _contentLabel.textColor = [UIColor grayColor];
        _contentLabel.textAlignment =NSTextAlignmentLeft;
        _contentLabel.numberOfLines=0;
     
      
        [self addSubview:_contentLabel];
        
       _timeLabel=[[UILabel alloc]init];
       _timeLabel.font =[UIFont systemFontOfSize:16];
        _timeLabel.textColor = [UIColor grayColor];
        _timeLabel.textAlignment =NSTextAlignmentRight;
        [self.contentView addSubview:_timeLabel];
        
     
       
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
