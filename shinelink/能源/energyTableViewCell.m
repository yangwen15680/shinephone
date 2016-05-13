//
//  energyTableViewCell.m
//  shinelink
//
//  Created by sky on 16/3/8.
//  Copyright © 2016年 sky. All rights reserved.
//

#import "energyTableViewCell.h"
#define labelWidth  65*NOW_SIZE
#define labelWidth1  48*NOW_SIZE
#define labelHeight  20*HEIGHT_SIZE
#define fontSize  11*HEIGHT_SIZE
#define labelColor  grayColor

@implementation energyTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor clearColor];
        
        
        self.coverImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5*NOW_SIZE, 5*HEIGHT_SIZE, 55*HEIGHT_SIZE, 55*HEIGHT_SIZE)];
        
        [self.contentView addSubview:_coverImageView];
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(55*HEIGHT_SIZE+10*NOW_SIZE, 0, 120*NOW_SIZE, 50*HEIGHT_SIZE)];
        
        self.titleLabel.font=[UIFont systemFontOfSize:16*HEIGHT_SIZE];
        self.titleLabel.textAlignment = NSTextAlignmentLeft;
        
        [self.contentView addSubview:_titleLabel];
        
        UIImageView *arrowView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_Width-30*NOW_SIZE, 25*HEIGHT_SIZE, 20*NOW_SIZE, 15*HEIGHT_SIZE)];
        arrowView.image = IMAGE(@"frag4.png");
        [self.contentView addSubview:arrowView];
        
//        self.detail = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_Width-60*NOW_SIZE, 12*HEIGHT_SIZE, 40*NOW_SIZE, 30*HEIGHT_SIZE)];
//        self.detail.text = root_xianQing;
//        self.detail.font=[UIFont systemFontOfSize:16*HEIGHT_SIZE];
//        self.detail.textAlignment = NSTextAlignmentLeft;
//        self.detail.textColor = [UIColor labelColor];
//        [self.contentView addSubview:_detail];
        
        
        self.state = [[UILabel alloc] initWithFrame:CGRectMake( SCREEN_Width/5, 40*HEIGHT_SIZE, labelWidth1, labelHeight)];
        
        self.state.font=[UIFont systemFontOfSize:fontSize];
        self.state.textAlignment = NSTextAlignmentRight;
        self.state.textColor = [UIColor labelColor];
        [self.contentView addSubview:_state];
        
        self.stateValue = [[UILabel alloc] initWithFrame:CGRectMake( SCREEN_Width/5+labelWidth-12*NOW_SIZE, 40*HEIGHT_SIZE, labelWidth, labelHeight)];
        self.stateValue.font=[UIFont systemFontOfSize:fontSize];
        self.stateValue.textAlignment = NSTextAlignmentLeft;
        self.stateValue.textColor = [UIColor labelColor];
        [self.contentView addSubview:_stateValue];
        
     
        
      
        
        self.electric = [[UILabel alloc] initWithFrame:CGRectMake( SCREEN_Width/5+2*labelWidth, 40*HEIGHT_SIZE, labelWidth1+5, labelHeight)];
        
        self.electric.font=[UIFont systemFontOfSize:fontSize];
        self.electric.textAlignment = NSTextAlignmentRight;
        self.electric.textColor = [UIColor labelColor];
        [self.contentView addSubview:_electric];
        
        self.electricValue = [[UILabel alloc] initWithFrame:CGRectMake( SCREEN_Width/5-12*NOW_SIZE+2*labelWidth+labelWidth, 40*HEIGHT_SIZE, labelWidth+5, labelHeight)];
        
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
