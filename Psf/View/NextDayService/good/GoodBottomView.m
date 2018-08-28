//
//  GoodBottomView.m
//  Psf
//
//  Created by 燕来秋mac9 on 2018/7/5.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "GoodBottomView.h"

@implementation GoodBottomView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.serviceBtn];
        [self addSubview:self.shopBtn];
        [self addSubview:self.addBtn];
        [self.shopBtn addSubview:self.countLabel];
        [self.serviceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(self);
            make.width.height.mas_equalTo(49);
        }];
        [self.shopBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self);
            make.left.equalTo(self.serviceBtn.mas_right);
            make.width.height.mas_equalTo(49);
        }];
        [self.countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(5);
            make.right.equalTo(self.shopBtn.mas_right).offset(-5);
            make.width.height.mas_equalTo(15);
        }];
        [self.addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self);
            make.left.equalTo(self).offset(98);
//            make.right.equalTo(self).offset(0);
            make.height.mas_equalTo(49);
            make.width.mas_equalTo(SCREENWIDTH-98);
        }];
    }
    return self;
}

-(UIButton *)serviceBtn{
    if (!_serviceBtn) {
        _serviceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_serviceBtn.layer setBorderColor:DSColorFromHex(0xDCDCDC).CGColor];
        [_serviceBtn.layer setBorderWidth:0.5];
        [_serviceBtn setImage:[UIImage imageNamed:@"phone_service"] forState:UIControlStateNormal];
    }
    return _serviceBtn;
}
-(UIButton *)shopBtn{
    if (!_shopBtn) {
        _shopBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_shopBtn.layer setBorderColor:DSColorFromHex(0xDCDCDC).CGColor];
        [_shopBtn.layer setBorderWidth:0.5];
        [_shopBtn setImage:[UIImage imageNamed:@"shopping_cart"] forState:UIControlStateNormal];
        [_shopBtn addTarget:self action:@selector(pressShop) forControlEvents:UIControlEventTouchUpInside];
    }
    return _shopBtn;
}
-(UILabel *)countLabel{
    if (!_countLabel) {
        _countLabel = [[UILabel alloc]init];
        _countLabel.textColor = [UIColor whiteColor];
        _countLabel.backgroundColor = DSColorFromHex(0xFF4C4D);
        _countLabel.font = [UIFont systemFontOfSize:10];
        [_countLabel.layer setCornerRadius:7.5];
        [_countLabel.layer setMasksToBounds:YES];
        _countLabel.textAlignment = NSTextAlignmentCenter;
        _countLabel.hidden = YES;
    }
    return _countLabel;
}
-(UIButton *)addBtn{
    if (!_addBtn) {
        _addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_addBtn setBackgroundImage:[UIImage imageNamed:@"shopping_submit"] forState:UIControlStateNormal];
        [_addBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_addBtn setTitle:@"加入购物车" forState:UIControlStateNormal];
        _addBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_addBtn addTarget:self action:@selector(pressAdd) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addBtn;
}
-(void)pressAdd{
    self.pressAddBlock();
}
-(void)pressShop{
    self.shopBlock();
}
@end
