//
//  PaymentCardView.m
//  Psf
//
//  Created by 燕来秋mac9 on 2018/9/20.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "PaymentCardView.h"
#import "CreatQRCodeAndBarCodeFromLeon.h"
@implementation PaymentCardView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(self);
            make.height.mas_equalTo(45);
        }];
    }
    return self;
}

-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.text = @"   付款码";
        _titleLabel.textColor = DSColorFromHex(0x464646);
        _titleLabel.font = [UIFont systemFontOfSize:15];
        _titleLabel.backgroundColor = DSColorFromHex(0xEFEFEF);
    }
    return _titleLabel;
}






@end
