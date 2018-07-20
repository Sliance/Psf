//
//  GoodCollectionViewCell.m
//  Psf
//
//  Created by 燕来秋mac9 on 2018/6/29.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "GoodCollectionViewCell.h"

@implementation GoodCollectionViewCell
-(UIImageView *)headImage{
    if (!_headImage) {
        _headImage = [[UIImageView alloc]init];
        _headImage.image = [UIImage imageNamed:@"mei_icon"];
        [_headImage.layer setMasksToBounds:YES];
        [_headImage.layer setCornerRadius:4];
        [_headImage.layer setBorderWidth:0.5];
        [_headImage.layer setBorderColor:DSColorFromHex(0xDCDCDC).CGColor];
    }
    return _headImage;
}
-(UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        _nameLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:15];
        _nameLabel.textColor = DSColorFromHex(0x474747);
        _nameLabel.text = @"墨西哥牛油果";
    }
    return _nameLabel;
}
-(UILabel *)priceLabel{
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc]init];
        _priceLabel.textAlignment = NSTextAlignmentLeft;
        _priceLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:15];
        _priceLabel.textColor = DSColorFromHex(0xFF4C4D);
        _priceLabel.text = @"¥ 21";
    }
    return _priceLabel;
}
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setcornerLayout];
    }
    return self;
}
-(void)setcornerLayout{
    [self addSubview:self.headImage];
    [self addSubview:self.nameLabel];
    [self addSubview:self.priceLabel];
    [self.headImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self).offset(15);
        make.width.height.mas_equalTo(123);
        
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headImage.mas_left);
        make.top.equalTo(self.headImage.mas_bottom).offset(5);
        make.width.mas_equalTo(123);
        
    }];
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headImage.mas_left);
        make.top.equalTo(self.nameLabel.mas_bottom).offset(5);
        make.width.mas_equalTo(123);
        
    }];
}
-(void)setModel:(GoodDetailRes *)model{
    NSString *url = [NSString stringWithFormat:@"%@%@",IMAGEHOST,model.productImagePath];
    [self.headImage sd_setImageWithURL:[NSURL URLWithString:url]];
    self.nameLabel.text = model.productName;
    self.priceLabel.text = [NSString stringWithFormat:@"￥%@",model.productPrice];
}
@end
