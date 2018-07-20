//
//  GroupBuyView.m
//  Psf
//
//  Created by 燕来秋mac9 on 2018/7/16.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "GroupBuyView.h"

@implementation GroupBuyView
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setCortentLayout];
        
    }
    return self;
}
-(void)setCortentLayout{
    [self addSubview:self.yinBGview];
    [self addSubview:self.BGview];
    [self.BGview addSubview:self.buyLabel];
    [self.BGview addSubview:self.addBtn];
    [self.BGview addSubview:self.subBtn];
    [self.BGview addSubview:self.countField];
    [self.BGview addSubview:self.submitBtn];
    
    
}

-(void)setHeight:(NSInteger )height{
    _height = height;
    [self.yinBGview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self);
        make.height.mas_equalTo(SCREENHEIGHT-184-height);
    }];
    [self.BGview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self).offset(SCREENHEIGHT-184-height);
        make.height.mas_equalTo(120+height);
    }];
    [self.buyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.BGview).offset(15);
        make.top.equalTo(self.BGview);
        make.height.mas_equalTo(100);
        make.width.mas_equalTo(SCREENWIDTH/2);
    }];
    [self.addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-15);
        make.centerY.equalTo(self.buyLabel);
        make.height.mas_equalTo(26);
        make.width.mas_equalTo(36);
    }];
    [self.subBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-86);
        make.centerY.equalTo(self.buyLabel);
        make.height.mas_equalTo(26);
        make.width.mas_equalTo(36);
    }];
    [self.countField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-50);
        make.centerY.equalTo(self.buyLabel);
        make.height.mas_equalTo(26);
        make.width.mas_equalTo(36);
    }];
    [self.submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.BGview).offset(15);
        make.right.equalTo(self.BGview).offset(-15);
        make.top.equalTo(self.buyLabel.mas_bottom);
        make.height.mas_equalTo(44);
    }];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pressTap)];
    [self.yinBGview addGestureRecognizer:tap];
}
-(UIView *)yinBGview{
    if (!_yinBGview) {
        _yinBGview = [[UIView alloc]init];
        _yinBGview.backgroundColor = DSColorAlphaFromHex(0x000000, 0.3);
    }
    return _yinBGview;
}
-(UIView *)BGview{
    if (!_BGview) {
        _BGview = [[UIView alloc]init];
        _BGview.backgroundColor = [UIColor whiteColor];
    }
    return _BGview;
}
-(UILabel *)buyLabel{
    if (!_buyLabel) {
        _buyLabel = [[UILabel alloc]init];
        _buyLabel.text = @"购买数量";
        _buyLabel.textColor = DSColorFromHex(0x464646);
        _buyLabel.font = [UIFont systemFontOfSize:18];
    }
    return _buyLabel;
}
-(UIButton *)subBtn{
    if (!_subBtn) {
        _subBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_subBtn setTitle:@"-" forState:UIControlStateNormal];
        [_subBtn setTitleColor:DSColorFromHex(0x707070) forState:UIControlStateNormal];
        [_subBtn.layer setCornerRadius:2];
        [_subBtn.layer setMasksToBounds:YES];
        [_subBtn.layer setBorderWidth:0.5];
        [_subBtn.layer setBorderColor:DSColorFromHex(0x707070).CGColor];
        [_subBtn addTarget:self action:@selector(pressSubBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    return _subBtn;
}
-(UIButton *)addBtn{
    if (!_addBtn) {
        _addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_addBtn setTitle:@"+" forState:UIControlStateNormal];
        [_addBtn setTitleColor:DSColorFromHex(0x707070) forState:UIControlStateNormal];
        [_addBtn.layer setCornerRadius:2];
        [_addBtn.layer setMasksToBounds:YES];
        [_addBtn.layer setBorderWidth:0.5];
        [_addBtn.layer setBorderColor:DSColorFromHex(0x707070).CGColor];
        [_addBtn addTarget:self action:@selector(pressAddBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addBtn;
}

-(UITextField *)countField{
    if (!_countField) {
        _countField = [[UITextField alloc]init];
        [_countField.layer setBorderColor:DSColorFromHex(0x707070).CGColor];
        [_countField.layer setBorderWidth:0.5];
        _countField.font = [UIFont systemFontOfSize:12];
        _countField.textAlignment = NSTextAlignmentCenter;
        _countField.text = @"1";
    }
    return _countField;
}
-(UIButton *)submitBtn{
    if (!_submitBtn) {
        _submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_submitBtn setBackgroundImage:[UIImage imageNamed:@"shopping_submit"] forState:UIControlStateNormal];
        [_submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_submitBtn setTitle:@"马上购买" forState:UIControlStateNormal];
        _submitBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_submitBtn addTarget:self action:@selector(pressSubmit) forControlEvents:UIControlEventTouchUpInside];
    }
    return _submitBtn;
}
-(void)pressAddBtn{
    self.pressAddBlock();
}
-(void)pressSubBtn{
    self.subBlock();
}
-(void)pressSubmit{
    self.submitBlock();
}
-(void)pressTap{
    self.tapBlock();
}
@end
