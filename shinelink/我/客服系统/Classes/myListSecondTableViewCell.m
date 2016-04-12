//
//  myListSecondTableViewCell.m
//  shinelink
//
//  Created by sky on 16/4/12.
//  Copyright © 2016年 sky. All rights reserved.
//

#import "myListSecondTableViewCell.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define Width [UIScreen mainScreen].bounds.size.width/320.0
#define Height [UIScreen mainScreen].bounds.size.height/568.0

@implementation myListSecondTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UIView *titleView=[[UIView alloc]initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH, 5*NOW_SIZE) ];
        titleView.backgroundColor=mainColor;
        [self addSubview:titleView];
        
        _image=[[UIImageView alloc]initWithFrame:CGRectMake(5*NOW_SIZE, 10*NOW_SIZE, 40*NOW_SIZE,40*NOW_SIZE )];
        _image.image = IMAGE(@"service@3x.png");
        [self.contentView addSubview:_image];
        
        
        _nameLabel =[[UILabel alloc]initWithFrame:CGRectMake(55*NOW_SIZE, 10*NOW_SIZE,150*NOW_SIZE, 15*NOW_SIZE) ];
        _nameLabel.font =[UIFont systemFontOfSize:14];
        _nameLabel.textColor = [UIColor blackColor];
        _nameLabel.textAlignment =NSTextAlignmentLeft;
        [self.contentView addSubview:_nameLabel];
        
        _timeLabel =[[UILabel alloc]initWithFrame:CGRectMake(55*NOW_SIZE, 32*NOW_SIZE,150*NOW_SIZE, 15*NOW_SIZE) ];
        _timeLabel.font =[UIFont systemFontOfSize:14];
        _timeLabel.textColor = [UIColor blackColor];
        _timeLabel.textAlignment =NSTextAlignmentLeft;
        [self.contentView addSubview:_timeLabel];
        
        
        
        _contentLabel =[[UILabel alloc]init];
        _contentLabel.font =[UIFont systemFontOfSize:12];
        _contentLabel.textColor = [UIColor grayColor];
        _contentLabel.textAlignment =NSTextAlignmentLeft;
        _contentLabel.numberOfLines=0;
        [self addSubview:_contentLabel];
        
      
        
        
        
    }
    return self;
}

@end
