//
//  GetCouponsCellView.m
//  Psf
//
//  Created by 燕来秋mac9 on 2018/6/29.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "GetCouponsCellView.h"

@implementation GetCouponsCellView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setCornerLayout];
    }
    return self;
}
-(void)setCornerLayout{
    self.backgroundColor = [UIColor whiteColor];
    
    
    [self addSubview:self.titleLabel];
    [self addSubview:self.detailLabel];
    [self addSubview:self.rightImage];
    [self addSubview:self.topLine];
    [self addSubview:self.topBtn];
    self.topLine.frame = CGRectMake(0, 0, SCREENWIDTH, 5);
    self.titleLabel.frame = CGRectMake(15, 5, 40, 45);
    self.detailLabel.frame = CGRectMake(60, 5, SCREENWIDTH-83, 45);
    self.rightImage.frame = CGRectMake(SCREENWIDTH-28, 20, 8, 14);
    self.topBtn.frame = CGRectMake(0, 0, SCREENWIDTH, 45);
    self.lineLabel.frame = CGRectMake(15, 50, SCREENWIDTH-15, 0.5);
}
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.text = @"领券";
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.font = [UIFont systemFontOfSize:15];
        _titleLabel.textColor = DSColorFromHex(0x787878);
    }
    return _titleLabel;
}
-(UILabel *)detailLabel{
    if (!_detailLabel) {
        _detailLabel = [[UILabel alloc]init];
        _detailLabel.text = @"";
        _detailLabel.textAlignment = NSTextAlignmentLeft;
        _detailLabel.font = [UIFont systemFontOfSize:15];
        _detailLabel.textColor = DSColorFromHex(0x474747);
    }
    return _detailLabel;
}


-(UIImageView *)rightImage{
    if (!_rightImage) {
        _rightImage = [[UIImageView alloc]init];
        _rightImage.image = [UIImage imageNamed:@"icon_right"];
    }
    return _rightImage;
}
-(UIButton *)topBtn{
    if (!_topBtn) {
        _topBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_topBtn addTarget:self action:@selector(pressTopBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _topBtn;
}
-(UILabel *)topLine{
    if (!_topLine) {
        _topLine = [[UILabel alloc]init];
        _topLine.backgroundColor =  DSColorFromHex(0xF0F0F0);
    }
    return _topLine;
}
-(void)pressTopBtn:(UIButton*)sender{
    self.pressCoupBlock(sender.tag);
}

@end
