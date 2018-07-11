//
//  EmptyShoppingHeadView.m
//  Psf
//
//  Created by 燕来秋mac9 on 2018/7/10.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "EmptyShoppingHeadView.h"

@implementation EmptyShoppingHeadView

-(instancetype)init{
    self = [super init];
    if (self) {
        self.backgroundColor = DSColorFromHex(0xF0F0F0);
        [self addSubview:self.headImage];
        [self addSubview:self.titleLabel];
        [self.headImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(78);
            make.width.mas_equalTo(135);
            make.height.mas_equalTo(116);
            make.centerX.equalTo(self);
        }];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.top.equalTo(self.headImage.mas_bottom).offset(22);
        }];
    }
    return self;
}
-(UIImageView *)headImage{
    if (!_headImage) {
        _headImage = [[UIImageView alloc]init];
        _headImage.image = [UIImage imageNamed:@"empty_shopping"];
    }
    return _headImage;
}
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.text = @"快去买点什么吧~";
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont systemFontOfSize:14];
        _titleLabel.textColor = DSColorFromHex(0x808080);
    }
    return _titleLabel;
}
@end
