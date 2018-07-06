//
//  OrderDetailBottomView.m
//  Psf
//
//  Created by 燕来秋mac9 on 2018/6/28.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "OrderDetailBottomView.h"

@implementation OrderDetailBottomView

-(UIButton *)remindBtn{
    if (!_remindBtn) {
        _remindBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _remindBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_remindBtn setTitle:@"提醒发货" forState:UIControlStateNormal];
        [_remindBtn.layer setCornerRadius:2];
        [_remindBtn.layer setMasksToBounds:YES];
        [_remindBtn setTitleColor:DSColorFromHex(0x464646) forState:UIControlStateNormal];
        [_remindBtn.layer setBorderWidth:0.5];
        [_remindBtn.layer setBorderColor:DSColorFromHex(0x464646).CGColor];
    }
    return _remindBtn;
}
-(UIButton *)sendBtn{
    if (!_sendBtn) {
        _sendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _sendBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_sendBtn setTitle:@"查看物流" forState:UIControlStateNormal];
        [_sendBtn.layer setCornerRadius:2];
//        _sendBtn.hidden = YES;
        [_sendBtn.layer setMasksToBounds:YES];
        [_sendBtn setTitleColor:DSColorFromHex(0x464646) forState:UIControlStateNormal];
        [_sendBtn.layer setBorderWidth:0.5];
        [_sendBtn.layer setBorderColor:DSColorFromHex(0x464646).CGColor];
    }
    return _sendBtn;
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
    [self addSubview:self.sendBtn];
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
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(39);
        make.right.equalTo(self).offset(-10);
        make.centerY.equalTo(self);
    }];
    [self.sendBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(39);
        make.right.equalTo(self.remindBtn.mas_left).offset(-10);
        make.centerY.equalTo(self);
    }];
}
@end
