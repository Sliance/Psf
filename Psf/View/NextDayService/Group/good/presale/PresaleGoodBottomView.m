//
//  PresaleGoodBottomView.m
//  Psf
//
//  Created by 燕来秋mac9 on 2018/7/16.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "PresaleGoodBottomView.h"

@implementation PresaleGoodBottomView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.serviceBtn];
        [self addSubview:self.addBtn];
        [self addSubview:self.shopBtn];
        [self addSubview:self.addShopBtn];
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
        
    }
    return self;
}

-(UIButton *)serviceBtn{
    if (!_serviceBtn) {
        _serviceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_serviceBtn.layer setBorderColor:DSColorFromHex(0xDCDCDC).CGColor];
        [_serviceBtn.layer setBorderWidth:0.5];
        [_serviceBtn setImage:[UIImage imageNamed:@"phone_service"] forState:UIControlStateNormal];
        [_serviceBtn addTarget:self action:@selector(pressService) forControlEvents:UIControlEventTouchUpInside];
    }
    return _serviceBtn;
}


-(UIButton *)addBtn{
    if (!_addBtn) {
        _addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _addBtn.backgroundColor = DSColorFromHex(0xFF8B4C);
        [_addBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_addBtn setTitle:@"马上抢购" forState:UIControlStateNormal];
        _addBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_addBtn addTarget:self action:@selector(pressAdd) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addBtn;
}
-(UIButton *)addShopBtn{
    if (!_addShopBtn) {
        _addShopBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _addShopBtn.backgroundColor = DSColorFromHex(0xFF4C4D);
        [_addShopBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_addShopBtn setTitle:@"加购物车" forState:UIControlStateNormal];
        _addShopBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_addShopBtn addTarget:self action:@selector(pressaddShop) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addShopBtn;
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
-(void)pressShop{
    self.goShopeBlock();
}
-(void)pressAdd{
    self.pressAddBlock();
}
-(void)pressService{
    self.serviceBlock();
}
-(void)pressaddShop{
    self.pressshopBlock();
}
-(void)setPreSaleIsComplete:(BOOL)preSaleIsComplete{
    _preSaleIsComplete = preSaleIsComplete;
    if (preSaleIsComplete ==1) {
        
        _addBtn.backgroundColor = DSColorFromHex(0xB4B4B4);
        [_addBtn setTitle:@"预售已结束" forState:UIControlStateNormal];
        _addBtn.enabled = NO;
        _addShopBtn.hidden = YES;
        _shopBtn.hidden = YES;
        [self.addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self);
            make.left.equalTo(self).offset(0);
            make.height.mas_equalTo(49);
            make.width.mas_equalTo(SCREENWIDTH);
        }];
        
    }else{
        _addBtn.backgroundColor = DSColorFromHex(0xFF8B4C);
        _addShopBtn.backgroundColor = DSColorFromHex(0xFF4C4D);
        [_addBtn setTitle:@"马上抢购" forState:UIControlStateNormal];
        _addShopBtn.hidden = NO;
        _addBtn.enabled = YES;
        _shopBtn.hidden = NO;
        [self.addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self);
            make.left.equalTo(self).offset(98);
            make.height.mas_equalTo(49);
            make.width.mas_equalTo(SCREENWIDTH/2-49);
        }];
        [self.addShopBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self);
            make.left.equalTo(self.addBtn.mas_right);
            make.height.mas_equalTo(49);
            make.width.mas_equalTo(SCREENWIDTH/2-49);
        }];
    }
    
}
@end
