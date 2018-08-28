//
//  GroupGoodBottomView.m
//  Psf
//
//  Created by 燕来秋mac9 on 2018/7/16.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "GroupGoodBottomView.h"

@implementation GroupGoodBottomView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.serviceBtn];
        [self addSubview:self.singleView];
        [self addSubview:self.groupView];
        [self.singleView addSubview:self.singlePrice];
        [self.singleView addSubview:self.singleLabel];
        [self.groupView addSubview:self.groupPrice];
        [self.groupView addSubview:self.groupLabel];
        [self.singleView addSubview:self.shopBtn];
        [self.groupView addSubview:self.addBtn];
        [self.serviceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(self);
            make.width.height.mas_equalTo(49);
        }];
        [self.singleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self);
            make.left.equalTo(self).offset(49);
            make.height.mas_equalTo(49);
            make.width.mas_equalTo(SCREENWIDTH/2-49/2);
        }];
        [self.singlePrice mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.singleView);
            make.top.equalTo(self.singleView).offset(6);
        }];
        [self.singleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.singleView);
            make.top.equalTo(self.singlePrice.mas_bottom).offset(2);
        }];
        [self.groupView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self);
            make.left.equalTo(self.singleView.mas_right);
            make.height.mas_equalTo(49);
            make.width.mas_equalTo(SCREENWIDTH/2-49/2);
        }];
        [self.groupPrice mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.groupView);
            make.top.equalTo(self.groupView).offset(6);
        }];
        [self.groupLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.groupView);
            make.top.equalTo(self.groupPrice.mas_bottom).offset(2);
        }];
        [self.shopBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.top.equalTo(self.singleView);
        }];
        [self.addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.top.equalTo(self.groupView);
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
         [_shopBtn addTarget:self action:@selector(pressSingle) forControlEvents:UIControlEventTouchUpInside];
    }
    return _shopBtn;
}
-(UIButton *)addBtn{
    if (!_addBtn) {
        _addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_addBtn addTarget:self action:@selector(pressgroup) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addBtn;
}
-(UIView *)singleView{
    if (!_singleView) {
        _singleView = [[UIView alloc]init];
        _singleView.backgroundColor = DSColorFromHex(0xFF8B4C);
    }
    return _singleView;
}
-(UIView *)groupView{
    if (!_groupView) {
        _groupView = [[UIView alloc]init];
        _groupView.backgroundColor = DSColorFromHex(0xFF4C4D);
    }
    return _groupView;
}
-(UILabel *)singlePrice{
    if (!_singlePrice) {
        _singlePrice = [[UILabel alloc]init];
        
        _singlePrice.textColor = [UIColor whiteColor];
        _singlePrice.font = [UIFont systemFontOfSize:18];
        _singlePrice.textAlignment = NSTextAlignmentCenter;
    }
    return _singlePrice;
}
-(UILabel *)groupPrice{
    if (!_groupPrice) {
        _groupPrice = [[UILabel alloc]init];
        _groupPrice.textColor = [UIColor whiteColor];
        _groupPrice.font = [UIFont systemFontOfSize:18];
        _groupPrice.textAlignment = NSTextAlignmentCenter;
    }
    return _groupPrice;
}
-(UILabel *)singleLabel{
    if (!_singleLabel) {
        _singleLabel = [[UILabel alloc]init];
        _singleLabel.text = @"单独购买";
        _singleLabel.textColor = [UIColor whiteColor];
        _singleLabel.font = [UIFont systemFontOfSize:12];
        _singleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _singleLabel;
}
-(UILabel *)groupLabel{
    if (!_groupLabel) {
        _groupLabel = [[UILabel alloc]init];
        _groupLabel.text = @"我要开团";
        _groupLabel.textColor = [UIColor whiteColor];
        _groupLabel.font = [UIFont systemFontOfSize:12];
        _groupLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _groupLabel;
}
-(void)pressSingle
{
    self.SingleBlock();
}
-(void)pressgroup{
    self.GroupBlock();
}
-(void)setModel:(GoodDetailRes *)model{
    _model = model;
    _groupPrice.text = [NSString stringWithFormat:@"¥%@",model.grouponPrice];
    _singlePrice.text = [NSString stringWithFormat:@"¥%@",model.productPrice];
}
@end
