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
      
        [self.serviceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(self);
            make.width.height.mas_equalTo(49);
        }];
       
        [self.addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self);
            make.left.equalTo(self).offset(49);
            make.height.mas_equalTo(49);
            make.width.mas_equalTo(SCREENWIDTH-49);
        }];
    }
    return self;
}

-(UIButton *)serviceBtn{
    if (!_serviceBtn) {
        _serviceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_serviceBtn.layer setBorderColor:DSColorFromHex(0xDCDCDC).CGColor];
        [_serviceBtn.layer setBorderWidth:0.5];
        [_serviceBtn setImage:[UIImage imageNamed:@"online_service"] forState:UIControlStateNormal];
        [_serviceBtn addTarget:self action:@selector(pressService) forControlEvents:UIControlEventTouchUpInside];
    }
    return _serviceBtn;
}


-(UIButton *)addBtn{
    if (!_addBtn) {
        _addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_addBtn setBackgroundImage:[UIImage imageNamed:@"shopping_submit"] forState:UIControlStateNormal];
        [_addBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_addBtn setTitle:@"马上抢购" forState:UIControlStateNormal];
        _addBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_addBtn addTarget:self action:@selector(pressAdd) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addBtn;
}
-(void)pressAdd{
    self.pressAddBlock();
}
-(void)pressService{
    self.serviceBlock();
}
-(void)setPreSaleIsComplete:(BOOL)preSaleIsComplete{
    _preSaleIsComplete = preSaleIsComplete;
    if (preSaleIsComplete ==1) {
        [_addBtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        _addBtn.backgroundColor = DSColorFromHex(0xB4B4B4);
        [_addBtn setTitle:@"预售已结束" forState:UIControlStateNormal];
        _addBtn.enabled = NO;
    }else{
        [_addBtn setBackgroundImage:[UIImage imageNamed:@"shopping_submit"] forState:UIControlStateNormal];
        [_addBtn setTitle:@"马上抢购" forState:UIControlStateNormal];
        _addBtn.enabled = YES;
    }
    
}
@end
