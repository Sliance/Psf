//
//  RechargeBtn.m
//  Psf
//
//  Created by 燕来秋mac9 on 2018/7/3.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "RechargeBtn.h"

@implementation RechargeBtn

-(instancetype)init{
    self = [super init];
    if (self) {
        self.backgroundColor = DSColorFromHex(0xF0F0F0);
        [self.layer setMasksToBounds:YES];
        [self.layer setCornerRadius:5];
        [self addSubview:self.numLabel];
        [self addSubview:self.detailLabel];
        self.layer.borderWidth =1;
        self.layer.borderColor = DSColorFromHex(0xF0F0F0).CGColor;
        [self.numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(self).offset(15);
        }];
        [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(15);
            make.top.equalTo(self.numLabel.mas_bottom).offset(15);
        }];
    }
    return self;
}
-(UILabel *)numLabel{
    if (!_numLabel) {
        _numLabel = [[UILabel alloc]init];
        _numLabel.textColor = DSColorFromHex(0x323232);
        _numLabel.font = [UIFont systemFontOfSize:15];
        _numLabel.textAlignment = NSTextAlignmentLeft;
        _numLabel.text = @"充值 100元";
    }
    return _numLabel;
}
-(UILabel *)detailLabel{
    if (!_detailLabel) {
        _detailLabel = [[UILabel alloc]init];
        _detailLabel.textColor = DSColorFromHex(0x969696);
        _detailLabel.font = [UIFont systemFontOfSize:15];
        _detailLabel.textAlignment = NSTextAlignmentLeft;
        _detailLabel.text = @"充值 100元";
    }
    return _detailLabel;
}
@end
