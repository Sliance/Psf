//
//  GroupCollectionViewCell.m
//  Psf
//
//  Created by 燕来秋mac9 on 2018/7/3.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "GroupCollectionViewCell.h"

@implementation GroupCollectionViewCell
-(UIImageView *)headImage{
    if (!_headImage) {
        _headImage = [[UIImageView alloc]init];
        _headImage.image = [UIImage imageNamed:@"mei_icon"];
        [_headImage.layer setMasksToBounds:YES];
        [_headImage.layer setCornerRadius:4];
        _headImage.layer.borderWidth = 0.5;
        _headImage.layer.borderColor = [UIColor colorWithRed:127.5/255.0 green:127.5/255.0 blue:127.5/255.0 alpha:0.3].CGColor;
    }
    return _headImage;
}
-(UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        _nameLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:15];
        _nameLabel.textColor = [UIColor colorWithRed:70.0001/255.0 green:70.0001/255.0 blue:70.0001/255.0 alpha:1];
        _nameLabel.text = @"FF4C4D";
    }
    return _nameLabel;
}
-(UILabel *)contentLabel{
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc]init];
        _contentLabel.textAlignment = NSTextAlignmentLeft;
        _contentLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:15];
        _contentLabel.textColor = DSColorFromHex(0xFF4C4D);
        _contentLabel.text = @"2人拼  ¥ 29.8/4个";
    }
    return _contentLabel;
}
-(UILabel *)priceLabel{
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc]init];
        _priceLabel.textAlignment = NSTextAlignmentLeft;
        _priceLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:12];
        _priceLabel.textColor = DSColorFromHex(0xB5B5B5);
        _priceLabel.text = @"￥99.8";
    }
    return _priceLabel;
}
-(UILabel *)weightLabel{
    if (!_weightLabel) {
        _weightLabel = [[UILabel alloc]init];
        _weightLabel.textAlignment = NSTextAlignmentRight;
        _weightLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:12];
        _weightLabel.textColor = DSColorFromHex(0xB4B4B4);
        _weightLabel.text = @"已有68212人拼";
    }
    return _weightLabel;
}

-(UILabel *)lineLabel{
    if (!_lineLabel) {
        _lineLabel = [[UILabel alloc]init];
        _lineLabel.backgroundColor = DSColorFromHex(0xB4B4B4);
    }
    return _lineLabel;
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
    [self addSubview:self.contentLabel];
    [self addSubview:self.priceLabel];
    [self addSubview:self.weightLabel];
    [self addSubview:self.lineLabel];
    [self.headImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self);
        make.width.height.mas_equalTo(165);
        
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headImage.mas_left);
        make.top.equalTo(self.headImage.mas_bottom).offset(12);
        make.width.mas_equalTo(165);
        
    }];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headImage.mas_left);
        make.top.equalTo(self.nameLabel.mas_bottom).offset(8);
        make.width.mas_equalTo(165);
        
    }];
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headImage.mas_left);
        make.top.equalTo(self.contentLabel.mas_bottom).offset(10);
        
    }];
    [self.lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headImage.mas_left);
        make.centerY.equalTo(self.priceLabel);
        make.width.mas_equalTo(self.priceLabel.mas_width);
        make.height.mas_equalTo(1);
    }];
    [self.weightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.headImage.mas_right);
        make.top.equalTo(self.contentLabel.mas_bottom).offset(10);
        
    }];
    
}

@end
