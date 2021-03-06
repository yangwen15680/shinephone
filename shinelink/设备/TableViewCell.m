//
//  TableViewCell.m
//  shinelink
//
//  Created by sky on 16/2/15.
//  Copyright © 2016年 sky. All rights reserved.
//

#import "TableViewCell.h"
#define labelWidth  38*NOW_SIZE
#define labelWidth1  38*NOW_SIZE
#define labelHeight  20*NOW_SIZE
#define fontSize  11*NOW_SIZE
#define labelColor  grayColor


@interface TableViewCell ()
@property (nonatomic, strong) UIImageView *coverImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *detail;
@property (nonatomic, strong) UILabel *state;
@property (nonatomic, strong) UILabel *stateValue;
@property (nonatomic, strong) UILabel *power;
@property (nonatomic, strong) UILabel *powerValue;
@property (nonatomic, strong) UILabel *electric;
@property (nonatomic, strong) UILabel *electricValue;
@end

@implementation TableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
     self.backgroundColor = [UIColor clearColor];

    self.coverImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5*NOW_SIZE, 5*NOW_SIZE, SCREEN_Width/5-10, SCREEN_Width/5-10)];
    [self.coverImageView setImage:[UIImage imageNamed:@"demo2.png"]];
    [self.contentView addSubview:_coverImageView];
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_Width/5+10, 0, 120*NOW_SIZE, 50*NOW_SIZE)];
    self.titleLabel.text = @"逆变器";
    self.titleLabel.font=[UIFont systemFontOfSize:16*NOW_SIZE];
    self.titleLabel.textAlignment = NSTextAlignmentLeft;
    self.titleLabel.textColor = [UIColor orangeColor];
    [self.contentView addSubview:_titleLabel];
    
    UIImageView *arrowView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_Width-30, 21, 20*NOW_SIZE, 15*NOW_SIZE)];
    arrowView.image = IMAGE(@"frag4.png");
    [self.contentView addSubview:arrowView];
    
    self.detail = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_Width-30-30, 12, 40*NOW_SIZE, 30*NOW_SIZE)];
    self.detail.text = @"详情";
    self.detail.font=[UIFont systemFontOfSize:16];
    self.detail.textAlignment = NSTextAlignmentLeft;
    self.detail.textColor = [UIColor labelColor];
    [self.contentView addSubview:_detail];
    
    
    self.state = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_Width/5+10, 50*NOW_SIZE-10, labelWidth1, labelHeight)];
    self.state.text = @"状态：";
    self.state.font=[UIFont systemFontOfSize:fontSize];
    self.state.textAlignment = NSTextAlignmentLeft;
    self.state.textColor = [UIColor labelColor];
    [self.contentView addSubview:_state];
    
    self.stateValue = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_Width/5+10+labelWidth-12, 50*NOW_SIZE-10, labelWidth, labelHeight)];
    self.stateValue.text = @"已连接";
    self.stateValue.font=[UIFont systemFontOfSize:fontSize];
    self.stateValue.textAlignment = NSTextAlignmentLeft;
    self.stateValue.textColor = [UIColor labelColor];
    [self.contentView addSubview:_stateValue];
    
    self.power = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_Width/5+labelWidth+labelWidth, 50*NOW_SIZE-10, labelWidth1,labelHeight)];
    self.power.text = @"功率：";
    self.power.font=[UIFont systemFontOfSize:fontSize];
    self.power.textAlignment = NSTextAlignmentLeft;
    self.power.textColor = [UIColor labelColor];
    [self.contentView addSubview:_power];
    
    self.powerValue = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_Width/5+labelWidth+labelWidth+labelWidth-12, 50*NOW_SIZE-10, labelWidth+5, labelHeight)];
    self.powerValue.text = @"500KW";
    self.powerValue.font=[UIFont systemFontOfSize:fontSize];
    self.powerValue.textAlignment = NSTextAlignmentLeft;
    self.powerValue.textColor = [UIColor labelColor];
    [self.contentView addSubview:_powerValue];
    
    self.electric = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_Width/5+labelWidth+labelWidth+labelWidth+labelWidth-5, 50*NOW_SIZE-10, labelWidth1+5, labelHeight)];
    self.electric.text = @"日电量:";
    self.electric.font=[UIFont systemFontOfSize:fontSize];
    self.electric.textAlignment = NSTextAlignmentLeft;
    self.electric.textColor = [UIColor labelColor];
    [self.contentView addSubview:_electric];
    
    self.electricValue = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_Width/5+labelWidth+labelWidth+labelWidth+labelWidth+labelWidth-5, 50*NOW_SIZE-10, labelWidth+5, labelHeight)];
    self.electricValue.text = @"50kw/h";
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
