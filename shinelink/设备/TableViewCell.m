//
//  TableViewCell.m
//  shinelink
//
//  Created by sky on 16/2/15.
//  Copyright © 2016年 sky. All rights reserved.
//

#import "TableViewCell.h"
#import "EGOCache.h"

#define labelWidth  38*NOW_SIZE
#define labelWidth1  38*NOW_SIZE
#define labelHeight  20*NOW_SIZE
#define fontSize  11*NOW_SIZE
#define labelColor  grayColor


@interface TableViewCell ()



@end

@implementation TableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
     self.backgroundColor = [UIColor clearColor];

    self.coverImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5*NOW_SIZE, 5*NOW_SIZE, SCREEN_Width/5-10, SCREEN_Width/5-10)];
    [self.contentView addSubview:_coverImageView];
    
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_Width/5+10, 0, 100*NOW_SIZE, 50*NOW_SIZE)];
    self.titleLabel.font=[UIFont systemFontOfSize:16*NOW_SIZE];
    self.titleLabel.textAlignment = NSTextAlignmentLeft;
    
    [self.contentView addSubview:_titleLabel];
    
    UIImageView *arrowView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_Width-30, 19*NOW_SIZE, 20*NOW_SIZE, 15*NOW_SIZE)];
    arrowView.image = IMAGE(@"frag4.png");
    [self.contentView addSubview:arrowView];
    
    self.detail = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_Width-60*NOW_SIZE, 12*NOW_SIZE, 40*NOW_SIZE, 30*NOW_SIZE)];
    self.detail.text = @"详情";
    self.detail.font=[UIFont systemFontOfSize:16];
    self.detail.textAlignment = NSTextAlignmentLeft;
    self.detail.textColor = [UIColor labelColor];
    [self.contentView addSubview:_detail];
    
    
    /*self.state = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_Width/5+80*NOW_SIZE, 18*NOW_SIZE, labelWidth1, labelHeight)];
    self.state.text = @"状态：";
    self.state.font=[UIFont systemFontOfSize:fontSize];
    self.state.textAlignment = NSTextAlignmentLeft;
    self.state.textColor = [UIColor labelColor];
    [self.contentView addSubview:_state];*/
    
   _stateView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_Width/5+80*NOW_SIZE+labelWidth1, 18*NOW_SIZE, labelWidth1/2, labelWidth1/2)];
  
    [self.contentView addSubview:_stateView];
    
    self.stateValue = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_Width/5+80*NOW_SIZE+labelWidth1+labelWidth1/2, 18*NOW_SIZE, labelWidth1, labelHeight)];
    self.stateValue.font=[UIFont systemFontOfSize:fontSize];
    self.stateValue.textAlignment = NSTextAlignmentLeft;
    self.stateValue.textColor = [UIColor labelColor];
    [self.contentView addSubview:_stateValue];
    
    self.power = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_Width/5+10*NOW_SIZE, 40*NOW_SIZE, labelWidth1, labelHeight)];
    self.power.text = @"功率：";
    self.power.font=[UIFont systemFontOfSize:fontSize];
    self.power.textAlignment = NSTextAlignmentLeft;
    self.power.textColor = [UIColor labelColor];
    [self.contentView addSubview:_power];
    
    self.powerValue = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_Width/5+10*NOW_SIZE+labelWidth-12*NOW_SIZE, 40*NOW_SIZE, labelWidth+30*NOW_SIZE, labelHeight)];
    self.powerValue.font=[UIFont systemFontOfSize:fontSize];
    self.powerValue.textAlignment = NSTextAlignmentLeft;
    self.powerValue.textColor = [UIColor labelColor];
    [self.contentView addSubview:_powerValue];
    
    self.electric = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_Width/5+80*NOW_SIZE+labelWidth1, 40*NOW_SIZE, labelWidth1+5, labelHeight)];
    self.electric.text = @"日电量:";
    self.electric.font=[UIFont systemFontOfSize:fontSize];
    self.electric.textAlignment = NSTextAlignmentLeft;
    self.electric.textColor = [UIColor labelColor];
    [self.contentView addSubview:_electric];
    
    self.electricValue = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_Width/5+80*NOW_SIZE+labelWidth1+labelWidth, 40*NOW_SIZE, labelWidth+30*NOW_SIZE, labelHeight)];
   
    self.electricValue.font=[UIFont systemFontOfSize:fontSize];
    self.electricValue.textAlignment = NSTextAlignmentLeft;
    self.electricValue.textColor = [UIColor labelColor];
    [self.contentView addSubview:_electricValue];
    
 
    
    
    
    
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


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
