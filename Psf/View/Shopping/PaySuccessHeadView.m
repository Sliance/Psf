//
//  PaySuccessHeadView.m
//  Psf
//
//  Created by 燕来秋mac9 on 2018/8/15.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "PaySuccessHeadView.h"

@implementation PaySuccessHeadView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.successBtn];
        [self addSubview:self.lineLabel];
        [self addSubview:self.priceLabel];
        [self addSubview:self.titleLabel];
        [self addSubview:self.homeBtn];
        [self addSubview:self.orderBtn];
        [self.successBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.top.equalTo(self).offset(18);
            
        }];
        [self.lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.top.equalTo(self).offset(133);
            make.height.mas_equalTo(5);
        }];
        [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.top.equalTo(self.successBtn.mas_bottom).offset(10);
        }];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.bottom.equalTo(self);
            make.height.mas_equalTo(50);
        }];
        [self.homeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(120);
            make.height.mas_equalTo(30);
            make.bottom.equalTo(self.lineLabel.mas_top).offset(-15);
            make.right.equalTo(self.mas_centerX).offset(-20);
        }];
        [self.orderBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(120);
            make.height.mas_equalTo(30);
            make.bottom.equalTo(self.lineLabel.mas_top).offset(-15);
            make.left.equalTo(self.mas_centerX).offset(20);
        }];
    }
    return self;
}
-(UIButton *)successBtn{
    if (!_successBtn) {
        _successBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_successBtn setImage:[UIImage imageNamed:@"pay_success"] forState:UIControlStateNormal];
        [_successBtn setTitle:@"支付成功" forState:UIControlStateNormal];
        [_successBtn setTitleColor:DSColorFromHex(0x63C94B) forState:UIControlStateNormal];
        _successBtn.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:18];
        _successBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
    }
    return _successBtn;
}
-(UILabel *)lineLabel{
    if (!_lineLabel) {
        _lineLabel = [[UILabel alloc]init];
        _lineLabel.backgroundColor = DSColorFromHex(0xF0F0F0);
    }
    return _lineLabel;
}

-(UILabel *)priceLabel{
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc]init];
        _priceLabel.font = [UIFont systemFontOfSize:15];
        _priceLabel.textColor = DSColorFromHex(0x454545);
        _priceLabel.textAlignment = NSTextAlignmentCenter;
        _priceLabel.text = @"实付¥0";
    }
    return _priceLabel;
}
-(UIButton *)homeBtn{
    if (!_homeBtn) {
        _homeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_homeBtn setTitleColor:DSColorFromHex(0x454545) forState:UIControlStateNormal];
        [_homeBtn setTitle:@"返回首页" forState:UIControlStateNormal];
        _homeBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_homeBtn.layer setBorderColor:DSColorFromHex(0x787878).CGColor];
        [_homeBtn.layer setBorderWidth:0.5];
        [_homeBtn.layer setMasksToBounds:YES];
        [_homeBtn.layer setCornerRadius:2];
        [_homeBtn addTarget:self action:@selector(pressHome) forControlEvents:UIControlEventTouchUpInside];
    }
    return _homeBtn;
}
-(UIButton *)orderBtn{
    if (!_orderBtn) {
        _orderBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_orderBtn setTitleColor:DSColorFromHex(0x454545) forState:UIControlStateNormal];
        [_orderBtn setTitle:@"查看订单" forState:UIControlStateNormal];
        _orderBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_orderBtn.layer setBorderColor:DSColorFromHex(0x787878).CGColor];
        [_orderBtn.layer setBorderWidth:0.5];
        [_orderBtn.layer setMasksToBounds:YES];
        [_orderBtn.layer setCornerRadius:2];
        [_orderBtn addTarget:self action:@selector(pressOrder) forControlEvents:UIControlEventTouchUpInside];
    }
    return _orderBtn;
}

-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:18];
        _titleLabel.textColor = DSColorFromHex(0x464646);
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.text = @"猜你喜欢";
    }
    return _titleLabel;
}

-(void)pressHome{
    self.homeBlock();
}
-(void)pressOrder{
    self.orderBlock();
}
@end
