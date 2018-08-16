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
        [self.successBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.top.equalTo(self).offset(18);
            
        }];
        [self.successBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.top.equalTo(self).offset(133);
            make.height.mas_equalTo(5);
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
        _successBtn.titleLabel.font = [UIFont fontWithName:@"PingFang-SC-Bold" size:18];
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
@end
