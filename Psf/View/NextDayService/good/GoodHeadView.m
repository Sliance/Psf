//
//  GoodHeadView.m
//  Psf
//
//  Created by 燕来秋mac9 on 2018/6/29.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "GoodHeadView.h"

@implementation GoodHeadView
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setCornerLayout];
    }
    return self;
}
-(void)setCornerLayout{
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.nameLabel];
    [self addSubview:self.contentLabel];
    [self addSubview:self.priceLabel];
    [self addSubview:self.weightLabel];
    [self addSubview:self.soldLabel];
    [self addSubview:self.shareBtn];
    self.nameLabel.frame = CGRectMake(15, 15, SCREENWIDTH-50, 17);
    self.contentLabel.frame = CGRectMake(15, self.nameLabel.ctBottom+11, SCREENWIDTH-30, 15);
    self.priceLabel.frame = CGRectMake(15, self.contentLabel.ctBottom+15, self.contentLabel.ctSize.width, 21);
    self.weightLabel.frame = CGRectMake(self.priceLabel.ctRight, self.contentLabel.ctBottom+15, self.weightLabel.ctSize.width, 21);
    self.shareBtn.frame = CGRectMake(SCREENWIDTH-32, 15, 17, 17);
    self.soldLabel.frame = CGRectMake(SCREENWIDTH-15-100, self.shareBtn.ctBottom+49, 100, 21);
}
-(UIButton *)shareBtn{
    if (!_shareBtn) {
        _shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_shareBtn setImage:[UIImage imageNamed:@"shop_share"] forState:UIControlStateNormal];
        [_shareBtn addTarget:self action:@selector(pressShareBtn:) forControlEvents:UIControlEventTouchUpInside];
        _shareBtn.frame = CGRectMake(0, 20, 40, 40);
    }
    return _shareBtn;
}
-(UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        _nameLabel.font = [UIFont fontWithName:@"PingFang-SC-Bold" size:18];
        _nameLabel.textColor = [UIColor colorWithRed:70.0001/255.0 green:70.0001/255.0 blue:70.0001/255.0 alpha:1];
        _nameLabel.text = @"澳洲牛腱子";
    }
    return _nameLabel;
}
-(UILabel *)contentLabel{
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc]init];
        _contentLabel.textAlignment = NSTextAlignmentLeft;
        _contentLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:15];
        _contentLabel.textColor = DSColorFromHex(0x777777);
        _contentLabel.text = @"澳大利亚牧场直供，精选优质";
    }
    return _contentLabel;
}
-(UILabel *)priceLabel{
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc]init];
        _priceLabel.textAlignment = NSTextAlignmentLeft;
        _priceLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:24];
        _priceLabel.textColor = DSColorFromHex(0xFF4C4D);
        _priceLabel.text = @"￥99.8";
    }
    return _priceLabel;
}
-(UILabel *)weightLabel{
    if (!_weightLabel) {
        _weightLabel = [[UILabel alloc]init];
        _weightLabel.textAlignment = NSTextAlignmentLeft;
        _weightLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:15];
        _weightLabel.textColor =  DSColorFromHex(0xFF4C4D);
        _weightLabel.text = @"/250g";
    }
    return _weightLabel;
}
-(UILabel *)soldLabel{
    if (!_soldLabel) {
        _soldLabel = [[UILabel alloc]init];
        _soldLabel.textAlignment = NSTextAlignmentRight;
        _soldLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:12];
        _soldLabel.textColor = DSColorFromHex(0xB5B5B5);
        _soldLabel.text = @"已售86";
    }
    return _soldLabel;
}

@end
