//
//  moreCell.m
//  shinelink
//
//  Created by sky on 16/4/8.
//  Copyright © 2016年 sky. All rights reserved.
//

#import "moreCell.h"

@implementation moreCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor clearColor];
        
        
        float imageSize=80*NOW_SIZE,size1=10*NOW_SIZE,size2=5*NOW_SIZE,kongXi=20*NOW_SIZE;
        
        _typeImageView=[[UIImageView alloc] initWithFrame:CGRectMake(size2, size1, imageSize, imageSize)];
        [_typeImageView setImage:IMAGE(@"客户服务.png")];
        [self.contentView addSubview:_typeImageView];
        
        self.name = [[UILabel alloc] initWithFrame:CGRectMake(size2+imageSize+kongXi, size1/2, imageSize+60*NOW_SIZE, 30*NOW_SIZE)];
        self.name.font=[UIFont systemFontOfSize:16*NOW_SIZE];
        self.name.text=@"逆变器";
        self.name.textAlignment = NSTextAlignmentLeft;
        self.name.textColor = [UIColor blackColor];
        [self.contentView addSubview:_name];
        
        _image=[[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_Width-30*NOW_SIZE, 10*NOW_SIZE, 20*NOW_SIZE,20*NOW_SIZE )];
        _image.image = IMAGE(@"更多产品2.png");
        [self.contentView addSubview:_image];
        
        self.connent = [[UILabel alloc] initWithFrame:CGRectMake(size2+imageSize+kongXi, size1+20*NOW_SIZE, 200*NOW_SIZE, 60*NOW_SIZE)];
        self.connent.font=[UIFont systemFontOfSize:13*NOW_SIZE];
        self.connent.text=@"逆变器逆变器逆变器逆变器逆变器逆变器逆变器逆变器逆变器逆变器逆变器逆变器逆变器逆变器逆变器逆变器逆变器逆变器逆变器逆变器逆变器";
        self.connent.numberOfLines=0;
        self.connent.textAlignment = NSTextAlignmentLeft;
        self.connent.textColor = [UIColor grayColor];
        [self.contentView addSubview:_connent];
        

        
        UIView *view1=[[UIView alloc]initWithFrame:CGRectMake(0, 10*NOW_SIZE+22*NOW_SIZE*4, SCREEN_Width, 10*NOW_SIZE)];
        [view1 setBackgroundColor:colorGary];
        [self.contentView addSubview:view1];
    }
    
    return self;
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
