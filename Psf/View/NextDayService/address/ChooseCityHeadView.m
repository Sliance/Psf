//
//  ChooseCityHeadView.m
//  Psf
//
//  Created by 燕来秋mac9 on 2018/6/25.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "ChooseCityHeadView.h"

@implementation ChooseCityHeadView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setcornerLayout];
        self.backgroundColor = DSColorFromHex(0xF0F0F0);
    }
    return self;
}
-(void)setcornerLayout{
    [self addSubview:self.bgView];
    [self.bgView addSubview:self.cityBtn];
    [self.bgView addSubview:self.searchImage];
    [self.bgView addSubview:self.lineLabel];
    [self.bgView addSubview:self.searchField];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(16);
        make.right.equalTo(self).offset(-16);
        make.top.equalTo(self).offset(5);
        make.height.mas_equalTo(36);
    }];
    [self.cityBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.bgView);
        make.left.equalTo(self.bgView).offset(5);
        make.width.mas_equalTo(40);
    }];
    [self.searchImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.bgView);
        make.left.equalTo(self.cityBtn.mas_right);
        make.width.mas_equalTo(7);
        make.height.mas_equalTo(4);
    }];
    [self.lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgView).offset(65);
        make.top.equalTo(self.bgView).offset(9);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(1);
    }];
    [self.searchField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lineLabel.mas_right).offset(10);
        make.right.equalTo(self.bgView).offset(-10);
        make.top.equalTo(self.bgView);
        make.bottom.equalTo(self.bgView);
    }];
}
-(UIView *)bgView{
    if (!_bgView) {
        _bgView = [[UIView alloc]init];
        [_bgView.layer setCornerRadius:4];
        [_bgView.layer setMasksToBounds:YES];
        _bgView.backgroundColor= [UIColor whiteColor];
    }
    return _bgView;
}
-(UIButton *)cityBtn{
    if (!_cityBtn) {
        _cityBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cityBtn setTitle:@"上海" forState:UIControlStateNormal];
        [_cityBtn setTitleColor:DSColorFromHex(0x464646) forState:UIControlStateNormal];
        _cityBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    }

    return _cityBtn;
}
-(UILabel *)lineLabel{
    if (!_lineLabel) {
        _lineLabel = [[UILabel alloc]init];
        _lineLabel.backgroundColor = DSColorFromHex(0xDCDCDC);
    }
    return _lineLabel;
}
-(UIImageView *)searchImage{
    if (!_searchImage) {
        _searchImage = [[UIImageView alloc]init];
        _searchImage.image = [UIImage imageNamed:@""];
    }
    return _searchImage;
}
-(UITextField *)searchField{
    if (!_searchField) {
        _searchField = [[UITextField alloc]init];
        _searchField.placeholder = @"请输入收货地址";
        _searchField.font = [UIFont systemFontOfSize:12];
        _searchField.delegate = self;
    }
    return _searchField;
}






@end
