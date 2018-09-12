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
        [self.serviceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(self);
            make.width.height.mas_equalTo(49);
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
-(UIButton *)shopBtn{
    if (!_shopBtn) {
        _shopBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _shopBtn.backgroundColor = DSColorFromHex(0xFF4C4D);
        [_shopBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_shopBtn setTitle:@"加购物车" forState:UIControlStateNormal];
        _shopBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_shopBtn addTarget:self action:@selector(pressShop) forControlEvents:UIControlEventTouchUpInside];
    }
    return _shopBtn;
}
-(void)pressAdd{
    self.pressAddBlock();
}
-(void)pressService{
    self.serviceBlock();
}
-(void)pressShop{
    self.pressshopBlock();
}
-(void)setPreSaleIsComplete:(BOOL)preSaleIsComplete{
    _preSaleIsComplete = preSaleIsComplete;
    if (preSaleIsComplete ==1) {
        
        _addBtn.backgroundColor = DSColorFromHex(0xB4B4B4);
        [_addBtn setTitle:@"预售已结束" forState:UIControlStateNormal];
        _addBtn.enabled = NO;
        _shopBtn.hidden = YES;
        [self.addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self);
            make.left.equalTo(self).offset(49);
            make.height.mas_equalTo(49);
            make.width.mas_equalTo(SCREENWIDTH-49);
        }];
        
    }else{
        _addBtn.backgroundColor = DSColorFromHex(0xFF8B4C);
        _shopBtn.backgroundColor = DSColorFromHex(0xFF4C4D);
        [_addBtn setTitle:@"马上抢购" forState:UIControlStateNormal];
        _shopBtn.hidden = NO;
        _addBtn.enabled = YES;
        [self.addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self);
            make.left.equalTo(self).offset(49);
            make.height.mas_equalTo(49);
            make.width.mas_equalTo(SCREENWIDTH/2-49/2);
        }];
        [self.shopBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self);
            make.left.equalTo(self.addBtn.mas_right);
            make.height.mas_equalTo(49);
            make.width.mas_equalTo(SCREENWIDTH/2-49/2);
        }];
    }
    
}
@end
