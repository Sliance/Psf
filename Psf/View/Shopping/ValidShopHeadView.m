//
//  ValidShopHeadView.m
//  Psf
//
//  Created by 燕来秋mac9 on 2018/6/22.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "ValidShopHeadView.h"

@implementation ValidShopHeadView
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setcornerLayout];
    }
    return self;
}
-(void)setcornerLayout{
    [self addSubview:self.collectLabel];
    [self addSubview:self.nameLabel];
    [self addSubview:self.popBtn];
    self.backgroundColor = DSColorFromHex(0xFFF4DA);
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15);
        make.centerY.equalTo(self);
    }];
    [self.collectLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-15);
        make.centerY.equalTo(self);
    }];
    [self.popBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.top.bottom.equalTo(self);
    }];
}
-(UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        _nameLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:14];
        _nameLabel.textColor = DSColorFromHex(0xF29629);
        _nameLabel.text = @"还差28元可免邮费";
    }
    return _nameLabel;
}
-(UILabel *)collectLabel{
    if (!_collectLabel) {
        _collectLabel = [[UILabel alloc]init];
        _collectLabel.textAlignment = NSTextAlignmentLeft;
        _collectLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:14];
        _collectLabel.textColor = DSColorFromHex(0xF29629);
        _collectLabel.text = @"去凑单 >";
    }
    return _collectLabel;
}
-(UIButton *)popBtn{
    if (!_popBtn) {
        _popBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_popBtn addTarget:self action:@selector(pressPopBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _popBtn;
}
-(void)pressPopBtn:(UIButton*)sender{
    
}
@end
