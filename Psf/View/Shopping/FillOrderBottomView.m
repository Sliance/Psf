//
//  FillOrderBottomView.m
//  Psf
//
//  Created by 燕来秋mac9 on 2018/6/29.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "FillOrderBottomView.h"

@implementation FillOrderBottomView

-(UIButton *)remindBtn{
    if (!_remindBtn) {
        _remindBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _remindBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_remindBtn setTitle:@"去付款" forState:UIControlStateNormal];
        [_remindBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_remindBtn setBackgroundImage:[UIImage imageNamed:@"shopping_submit"] forState:UIControlStateNormal];
        
    }
    return _remindBtn;
}

-(UILabel *)payableLabel{
    if (!_payableLabel) {
        _payableLabel = [[UILabel alloc]init];
        _payableLabel.textAlignment = NSTextAlignmentLeft;
        _payableLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:15];
        _payableLabel.textColor = DSColorFromHex(0xFF4C4D);
        _payableLabel.text = @"应付:￥39.8";
    }
    return _payableLabel;
}
-(UILabel *)lineLabel{
    if (!_lineLabel) {
        _lineLabel = [[UILabel alloc]init];
        _lineLabel.backgroundColor = DSColorFromHex(0xDCDCDC);
    }
    return _lineLabel;
}
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setcornerLayout];
        self.backgroundColor = DSColorFromHex(0xFAFAFA);
    }
    return self;
}
-(void)setcornerLayout{
    [self addSubview:self.remindBtn];
    [self addSubview:self.lineLabel];
   
    [self addSubview:self.payableLabel];
    [self.lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        make.height.mas_equalTo(0.5);
    }];
    [self.payableLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.left.equalTo(self).offset(15);
        make.height.mas_equalTo(49);
    }];
    [self.remindBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(114);
        make.height.mas_equalTo(49);
        make.right.equalTo(self);
        make.top.equalTo(self);
    }];
    
}

@end
