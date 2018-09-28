//
//  ShopFootView.m
//  Psf
//
//  Created by 燕来秋mac9 on 2018/6/22.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "ShopFootView.h"

@implementation ShopFootView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setcornerLayout];
        self.backgroundColor = DSColorFromHex(0xFAFAFA);
    }
    return self;
}
-(void)setcornerLayout{
    [self addSubview:self.chooseBtn];
    [self addSubview:self.titleLabel];
    [self addSubview:self.priceLabel];
    [self addSubview:self.submitBtn];
    [self addSubview:self.lineLabel];
    [self.chooseBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(20);
        make.centerY.equalTo(self);
        make.left.equalTo(self).offset(15);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.left.equalTo(self.chooseBtn.mas_right).offset(15);
    }];
    [self.submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.right.equalTo(self);
        make.width.mas_equalTo(114);
    }];
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.right.equalTo(self.submitBtn.mas_left).offset(-15);
    }];
    [self.lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self);
        make.height.mas_equalTo(1);
    }];
}
-(UIButton *)chooseBtn{
    if (!_chooseBtn) {
        _chooseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_chooseBtn setImage:[UIImage imageNamed:@"shopping_selected"] forState:UIControlStateSelected];
        [_chooseBtn setImage:[UIImage imageNamed:@"shopping_normal"] forState:UIControlStateNormal];
        [_chooseBtn addTarget:self action:@selector(pressChooseBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _chooseBtn;
}
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:15];
        _titleLabel.textColor = DSColorFromHex(0x777777);
        _titleLabel.text = @"已选(0)";
    }
    return _titleLabel;
}
-(UILabel *)priceLabel{
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc]init];
        _priceLabel.textAlignment = NSTextAlignmentRight;
        _priceLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:15];
        _priceLabel.textColor = DSColorFromHex(0xFF4C4D);
        _priceLabel.text = @"￥0";
    }
    return _priceLabel;
}
-(UIButton *)submitBtn{
    if (!_submitBtn) {
        _submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_submitBtn setTitle:@"结算(0)" forState:UIControlStateNormal];
        [_submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_submitBtn setBackgroundImage:[UIImage imageNamed:@"shopping_submit"] forState:UIControlStateNormal];
        [_submitBtn addTarget:self action:@selector(pressSumitBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _submitBtn;
}
-(UILabel *)lineLabel{
    if (!_lineLabel) {
        _lineLabel = [[UILabel alloc]init];
        _lineLabel.backgroundColor = DSColorFromHex(0xDCDCDC);
    }
    return _lineLabel;
}
-(void)pressChooseBtn:(UIButton*)sender{
        sender.selected = !sender.selected;
    self.AllBlock(sender.selected);
}
-(void)pressSumitBtn:(UIButton*)sender{
    
}
-(void)setModel:(ShoppingListRes *)model{
    self.titleLabel.text = [NSString stringWithFormat:@"已选(%@)",model.productActiveQuantity];
    [self.submitBtn setTitle:[NSString stringWithFormat:@"结算(%@)",model.productActiveQuantity] forState:UIControlStateNormal];
    self.priceLabel.text = [NSString stringWithFormat:@"￥%@",model.cartPayAmount];
    self.chooseBtn.selected = model.cartIsActive;
}
@end
