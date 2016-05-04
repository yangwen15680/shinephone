//
//  qualityCell.m
//  shinelink
//
//  Created by sky on 16/4/7.
//  Copyright © 2016年 sky. All rights reserved.
//

#import "qualityCell.h"

@implementation qualityCell

- (void)awakeFromNib {
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor clearColor];
        _nameArray=[NSMutableArray arrayWithObjects:@"是否有质保信息:", @"序列号:",@"出厂时间:",@"到期时间:",nil];
        //NSMutableArray *textArray=[NSMutableArray arrayWithObjects:@"12344413", @"124312321",@"123123132",@"1231233",nil];
        
        float imageSize=60*NOW_SIZE,size1=20*NOW_SIZE,size2=5*NOW_SIZE,kongXi=5*NOW_SIZE;
         _typeImageView=[[UIImageView alloc] initWithFrame:CGRectMake(size2, size1, imageSize, imageSize)];
        [_typeImageView setImage:IMAGE(@"客户服务.png")];
        [self.contentView addSubview:_typeImageView];
        
        self.name = [[UILabel alloc] initWithFrame:CGRectMake(size2+imageSize+kongXi+5*NOW_SIZE, 9*NOW_SIZE, imageSize, imageSize+30*NOW_SIZE)];
        self.name.font=[UIFont systemFontOfSize:18*NOW_SIZE];
        //self.name.text=@"逆变器";
        self.name.textAlignment = NSTextAlignmentLeft;
        self.name.textColor = [UIColor blackColor];
        [self.contentView addSubview:_name];
        
        for (int i=0; i<_nameArray.count; i++) {
            UILabel *nameLabel=[[UILabel alloc] initWithFrame:CGRectMake(size2+imageSize+imageSize+20*NOW_SIZE, 10*NOW_SIZE+22*NOW_SIZE*i, 80*NOW_SIZE, 15*NOW_SIZE)];
            nameLabel.font=[UIFont systemFontOfSize:11*NOW_SIZE];
            nameLabel.text=_nameArray[i];
            nameLabel.textAlignment = NSTextAlignmentRight;
            nameLabel.textColor = [UIColor blackColor];
            [self.contentView addSubview:nameLabel];
        }
        
        _alia=[[UILabel alloc] initWithFrame:CGRectMake(size2+imageSize+imageSize+25*NOW_SIZE+80*NOW_SIZE, 10*NOW_SIZE+22*NOW_SIZE*0, 100*NOW_SIZE, 15*NOW_SIZE)];
        _alia.font=[UIFont systemFontOfSize:11*NOW_SIZE];
        //_alia.text=textArray[0];
        _alia.textAlignment = NSTextAlignmentLeft;
        _alia.textColor = [UIColor blackColor];
        [self.contentView addSubview:_alia];
        
        _SN=[[UILabel alloc] initWithFrame:CGRectMake(size2+imageSize+imageSize+25*NOW_SIZE+80*NOW_SIZE, 10*NOW_SIZE+22*NOW_SIZE*1, 100*NOW_SIZE, 15*NOW_SIZE)];
        _SN.font=[UIFont systemFontOfSize:11*NOW_SIZE];
      //  _SN.text=textArray[0];
        _SN.textAlignment = NSTextAlignmentLeft;
        _SN.textColor = [UIColor blackColor];
        [self.contentView addSubview:_SN];
        
        _beginTime=[[UILabel alloc] initWithFrame:CGRectMake(size2+imageSize+imageSize+25*NOW_SIZE+80*NOW_SIZE, 10*NOW_SIZE+22*NOW_SIZE*2, 100*NOW_SIZE, 15*NOW_SIZE)];
        _beginTime.font=[UIFont systemFontOfSize:11*NOW_SIZE];
      //  _beginTime.text=textArray[0];
        _beginTime.textAlignment = NSTextAlignmentLeft;
        _beginTime.textColor = [UIColor blackColor];
        [self.contentView addSubview:_beginTime];
        
        _overTime=[[UILabel alloc] initWithFrame:CGRectMake(size2+imageSize+imageSize+25*NOW_SIZE+80*NOW_SIZE, 10*NOW_SIZE+22*NOW_SIZE*3, 100*NOW_SIZE, 15*NOW_SIZE)];
        _overTime.font=[UIFont systemFontOfSize:11*NOW_SIZE];
        //_overTime.text=textArray[0];
        _overTime.textAlignment = NSTextAlignmentLeft;
        _overTime.textColor = [UIColor blackColor];
        [self.contentView addSubview:_overTime];
        
        UIView *view1=[[UIView alloc]initWithFrame:CGRectMake(0, 10*NOW_SIZE+22*NOW_SIZE*4, SCREEN_Width, 10*NOW_SIZE)];
        [view1 setBackgroundColor:colorGary];
        [self.contentView addSubview:view1];
    }
    
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
