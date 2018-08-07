//
//  InvoiceRuleView.m
//  Psf
//
//  Created by 燕来秋mac9 on 2018/8/7.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "InvoiceRuleView.h"

@implementation InvoiceRuleView

-(instancetype)init{
    self = [super init];
    if (self) {
        self.backgroundColor = DSColorFromHex(0xF0F0F0);
        [self addSubview:self.titleLabel];
         [self addSubview:self.oneLabel];
         [self addSubview:self.twoLabel];
         [self addSubview:self.threeLabel];
         [self addSubview:self.fourLabel];
         [self addSubview:self.fiveLabel];
        self.titleLabel.frame = CGRectMake(15, 5, SCREENWIDTH-30, [self.titleLabel.text heightForFont:[UIFont systemFontOfSize:13] width:SCREENWIDTH-30]);
        self.oneLabel.frame =CGRectMake(15, self.titleLabel.ctBottom, SCREENWIDTH-30, [self.oneLabel.text heightForFont:[UIFont systemFontOfSize:13] width:SCREENWIDTH-30]);
        self.twoLabel.frame =CGRectMake(15, self.oneLabel.ctBottom, SCREENWIDTH-30, [self.twoLabel.text heightForFont:[UIFont systemFontOfSize:13] width:SCREENWIDTH-30]);
        self.threeLabel.frame =CGRectMake(15, self.twoLabel.ctBottom, SCREENWIDTH-30, [self.threeLabel.text heightForFont:[UIFont systemFontOfSize:13] width:SCREENWIDTH-30]);
        self.fourLabel.frame =CGRectMake(15, self.threeLabel.ctBottom, SCREENWIDTH-30, [self.fourLabel.text heightForFont:[UIFont systemFontOfSize:13] width:SCREENWIDTH-30]);
        self.fiveLabel.frame =CGRectMake(15, self.fourLabel.ctBottom, SCREENWIDTH-30, [self.fiveLabel.text heightForFont:[UIFont systemFontOfSize:13] width:SCREENWIDTH-30]);
    }
    return self;
}

-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.text = @"发票须知:";
        _titleLabel.font = [UIFont systemFontOfSize:12];
        _titleLabel.textColor = DSColorFromHex(0x959595);
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.numberOfLines =0;
    }
    return _titleLabel;
}
-(UILabel *)oneLabel{
    if (!_oneLabel) {
        _oneLabel = [[UILabel alloc]init];
        _oneLabel.text = @"1.依照税局最新开票法规，纸质普通发票和电子普通发票，开具内容均为明细";
        _oneLabel.font = [UIFont systemFontOfSize:12];
        _oneLabel.textColor = DSColorFromHex(0x959595);
        _oneLabel.textAlignment = NSTextAlignmentLeft;
        _oneLabel.numberOfLines =0;
    }
    return _oneLabel;
}
-(UILabel *)twoLabel{
    if (!_twoLabel) {
        _twoLabel = [[UILabel alloc]init];
        _twoLabel.text = @"2.开票金额为用户实际支付的金额（不含红包，优惠券等不支持该发票类型的商品实付金额）";
        _twoLabel.font = [UIFont systemFontOfSize:12];
        _twoLabel.textColor = DSColorFromHex(0x959595);
        _twoLabel.textAlignment = NSTextAlignmentLeft;
        _twoLabel.numberOfLines =0;
    }
    return _twoLabel;
}
-(UILabel *)threeLabel{
    if (!_threeLabel) {
        _threeLabel = [[UILabel alloc]init];
        _threeLabel.text = @"3.未随商品寄出的纸质发票会在发货后15-30个工作日单独寄出";
        _threeLabel.font = [UIFont systemFontOfSize:12];
        _threeLabel.textColor = DSColorFromHex(0x959595);
        _threeLabel.textAlignment = NSTextAlignmentLeft;
        _threeLabel.numberOfLines =0;
    }
    return _threeLabel;
}
-(UILabel *)fourLabel{
    if (!_fourLabel) {
        _fourLabel = [[UILabel alloc]init];
        _fourLabel.text = @"4.增值税专用发票将会在所有商品发货后15-30个工作日单独寄出";
        _fourLabel.font = [UIFont systemFontOfSize:12];
        _fourLabel.textColor = DSColorFromHex(0x959595);
        _fourLabel.textAlignment = NSTextAlignmentLeft;
        _fourLabel.numberOfLines =0;
    }
    return _fourLabel;
}
-(UILabel *)fiveLabel{
    if (!_fiveLabel) {
        _fiveLabel = [[UILabel alloc]init];
        _fiveLabel.text = @"5.单笔订单只支持开具一种类型的发票";
        _fiveLabel.font = [UIFont systemFontOfSize:12];
        _fiveLabel.textColor = DSColorFromHex(0x959595);
        _fiveLabel.textAlignment = NSTextAlignmentLeft;
        _fiveLabel.numberOfLines =0;
    }
    return _fiveLabel;
}
@end
