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
        
        self.coverImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5*NOW_SIZE, 5*HEIGHT_SIZE, 50*HEIGHT_SIZE, 50*HEIGHT_SIZE)];
        
        [self.contentView addSubview:_coverImageView];
        
//        
//        _titleView=[[UIView alloc]initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH, 40*HEIGHT_SIZE) ];
//      //  titleView.backgroundColor=mainColor;
//        [self addSubview:_titleView];
        
        _titleLabel =[[UILabel alloc]initWithFrame:CGRectMake(55*NOW_SIZE, 5*HEIGHT_SIZE,200*NOW_SIZE, 30*HEIGHT_SIZE) ];
        _titleLabel.font =[UIFont systemFontOfSize:14*HEIGHT_SIZE];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.textAlignment =NSTextAlignmentLeft;
        [self.contentView  addSubview:_titleLabel];
        
        _timeLabel=[[UILabel alloc]initWithFrame:CGRectMake(260*NOW_SIZE, 5*HEIGHT_SIZE,50*NOW_SIZE, 30*HEIGHT_SIZE) ];
        _timeLabel.font =[UIFont systemFontOfSize:10*HEIGHT_SIZE];
        _timeLabel.textColor = [UIColor grayColor];
        _timeLabel.textAlignment =NSTextAlignmentRight;
        [self.contentView addSubview:_timeLabel];
        
//        _statusLabel =[[UILabel alloc]initWithFrame:CGRectMake(205*NOW_SIZE, 5*HEIGHT_SIZE,SCREEN_WIDTH-215*NOW_SIZE, 30*HEIGHT_SIZE) ];
//        _statusLabel.font =[UIFont systemFontOfSize:14*HEIGHT_SIZE];
//        _statusLabel.textColor = [UIColor whiteColor];
//        _statusLabel.textAlignment =NSTextAlignmentRight;
//        [_titleView addSubview:_statusLabel];
        
    
        
        _contentLabel =[[UILabel alloc]initWithFrame:CGRectMake(55*NOW_SIZE, 35*HEIGHT_SIZE,50*NOW_SIZE, 20*HEIGHT_SIZE) ];
        _contentLabel.font =[UIFont systemFontOfSize:12*HEIGHT_SIZE];
        _contentLabel.textColor = [UIColor grayColor];
        _contentLabel.textAlignment =NSTextAlignmentLeft;
        //_contentLabel.numberOfLines=0;
     
      
        [self.contentView addSubview:_contentLabel];
        
  
        
//        _view1=[[UIView alloc]init];
//        [_view1 setBackgroundColor:COLOR(240, 242, 239, 1)];
//        [self.contentView addSubview:_view1];
       
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
