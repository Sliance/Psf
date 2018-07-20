//
//  MyCouponHeadView.m
//  Psf
//
//  Created by 燕来秋mac9 on 2018/6/28.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "MyCouponHeadView.h"

@implementation MyCouponHeadView
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
    self.allBtn.selected = YES;
    self.allLine.hidden = NO;
    [self.bgView addSubview:self.allTitle];
    [self.bgView addSubview:self.allType];
    [self.bgView addSubview:self.allLine];
    [self.bgView addSubview:self.allBtn];
//    [self.bgView addSubview:self.sortBtn];
//    [self.bgView addSubview:self.sortLine];
//    [self.bgView addSubview:self.sortType];
//    [self.bgView addSubview:self.sortTitle];
    [self.bgView addSubview:self.singleBtn];
    [self.bgView addSubview:self.singleLine];
    [self.bgView addSubview:self.singleType];
    [self.bgView addSubview:self.singleTitle];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15);
        make.right.equalTo(self).offset(-15);
        make.top.equalTo(self).offset(15);
        make.height.mas_equalTo(105);
    }];
    [self.allTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgView);
        make.width.mas_equalTo(SCREENWIDTH/2-15);
        make.top.equalTo(self.bgView).offset(31);
    }];
    [self.allType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgView);
        make.width.mas_equalTo(SCREENWIDTH/2-15);
        make.top.equalTo(self.allTitle.mas_bottom).offset(14);
    }];
//    [self.sortTitle mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.allTitle.mas_right);
//        make.width.mas_equalTo(SCREENWIDTH/3-10);
//        make.top.equalTo(self.bgView).offset(31);
//    }];
//    [self.sortType mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.allTitle.mas_right);
//        make.width.mas_equalTo(SCREENWIDTH/3-10);
//        make.top.equalTo(self.sortTitle.mas_bottom).offset(14);
//    }];
    [self.singleTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.allTitle.mas_right);
        make.width.mas_equalTo(SCREENWIDTH/2-15);
        make.top.equalTo(self.bgView).offset(31);
    }];
    [self.singleType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.allTitle.mas_right);
        make.width.mas_equalTo(SCREENWIDTH/2-15);
        make.top.equalTo(self.singleTitle.mas_bottom).offset(14);
    }];
    [self.allLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgView).offset(20);
        make.width.mas_equalTo(SCREENWIDTH/2-55);
        make.top.equalTo(self.bgView).offset(102);
        make.height.mas_equalTo(3);
    }];
//    [self.sortLine mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.allTitle.mas_right).offset(20);
//        make.width.mas_equalTo(SCREENWIDTH/3-50);
//        make.top.equalTo(self.bgView).offset(102);
//        make.height.mas_equalTo(3);
//    }];
    [self.singleLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.allTitle.mas_right).offset(20);
        make.width.mas_equalTo(SCREENWIDTH/2-55);
        make.top.equalTo(self.bgView).offset(102);
        make.height.mas_equalTo(3);
    }];
    [self.allBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgView);
        make.width.mas_equalTo(SCREENWIDTH/2-15);
        make.top.equalTo(self.bgView);
        make.height.mas_equalTo(105);
    }];
//    [self.sortBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.bgView).offset(SCREENWIDTH/3-10);
//        make.width.mas_equalTo(SCREENWIDTH/3-10);
//        make.top.equalTo(self.bgView);
//        make.height.mas_equalTo(105);
//    }];
    [self.singleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgView).offset(SCREENWIDTH*2/3-20);
        make.width.mas_equalTo(SCREENWIDTH/2-15);
        make.top.equalTo(self.bgView);
        make.height.mas_equalTo(105);
    }];
}
-(UIView *)bgView{
    if (!_bgView) {
        _bgView = [[UIView alloc]init];
        [_bgView.layer setCornerRadius:4];
        [_bgView.layer setMasksToBounds:YES];
        _bgView.backgroundColor = [UIColor whiteColor];
    }
    return _bgView;
}
-(UILabel *)allTitle{
    if (!_allTitle) {
        _allTitle = [[UILabel alloc]init];
        _allTitle.textAlignment = NSTextAlignmentCenter;
        _allTitle.font = [UIFont systemFontOfSize:24];
        _allTitle.textColor = DSColorFromHex(0x646464);
        _allTitle.text = @"0张";
    }
    return _allTitle;
}
-(UILabel *)sortTitle{
    if (!_sortTitle) {
        _sortTitle = [[UILabel alloc]init];
        _sortTitle.textAlignment = NSTextAlignmentCenter;
        _sortTitle.font = [UIFont systemFontOfSize:24];
        _sortTitle.textColor = DSColorFromHex(0x646464);
        _sortTitle.text = @"0张";
    }
    return _sortTitle;
}
-(UILabel *)singleTitle{
    if (!_singleTitle) {
        _singleTitle = [[UILabel alloc]init];
        _singleTitle.textAlignment = NSTextAlignmentCenter;
        _singleTitle.font = [UIFont systemFontOfSize:24];
        _singleTitle.textColor = DSColorFromHex(0x646464);
        _singleTitle.text = @"1张";
    }
    return _singleTitle;
}
-(UILabel *)allType{
    if (!_allType) {
        _allType = [[UILabel alloc]init];
        _allType.textAlignment = NSTextAlignmentCenter;
        _allType.font = [UIFont systemFontOfSize:12];
        _allType.textColor = DSColorFromHex(0x646464);
        _allType.text = @"全场";
    }
    return _allType;
}
-(UILabel *)sortType{
    if (!_sortType) {
        _sortType = [[UILabel alloc]init];
        _sortType.textAlignment = NSTextAlignmentCenter;
        _sortType.font = [UIFont systemFontOfSize:12];
        _sortType.textColor = DSColorFromHex(0x646464);
        _sortType.text = @"分类";
    }
    return _sortType;
}
-(UILabel *)singleType{
    if (!_singleType) {
        _singleType = [[UILabel alloc]init];
        _singleType.textAlignment = NSTextAlignmentCenter;
        _singleType.font = [UIFont systemFontOfSize:12];
        _singleType.textColor = DSColorFromHex(0x646464);
        _singleType.text = @"单品";
    }
    return _singleType;
}
-(UILabel *)allLine{
    if (!_allLine) {
        _allLine = [[UILabel alloc]init];
        _allLine.hidden = YES;
        _allLine.backgroundColor = DSColorFromHex(0xFF4C4D);
    }
    return _allLine;
}
-(UILabel *)sortLine{
    if (!_sortLine) {
        _sortLine = [[UILabel alloc]init];
        _sortLine.hidden = YES;
        _sortLine.backgroundColor = DSColorFromHex(0xFF4C4D);
    }
    return _sortLine;
}
-(UILabel *)singleLine{
    if (!_singleLine) {
        _singleLine = [[UILabel alloc]init];
        _singleLine.hidden = YES;
        _singleLine.backgroundColor = DSColorFromHex(0xFF4C4D);
    }
    return _singleLine;
}
-(UIButton *)allBtn{
    if (!_allBtn) {
        _allBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_allBtn addTarget:self action:@selector(pressBtn:) forControlEvents:UIControlEventTouchUpInside];
        _allBtn.tag = 0;
    }
    return _allBtn;
}
-(UIButton *)sortBtn{
    if (!_sortBtn) {
        _sortBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_sortBtn addTarget:self action:@selector(pressBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sortBtn;
}
-(UIButton *)singleBtn{
    if (!_singleBtn) {
        _singleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_singleBtn addTarget:self action:@selector(pressBtn:) forControlEvents:UIControlEventTouchUpInside];
        _singleBtn.tag = 2;
    }
    return _singleBtn;
}
-(void)pressBtn:(UIButton*)sender{
    if (_tmpBtn == nil){
        sender.selected = YES;
        _tmpBtn = sender;
    }
    else if (_tmpBtn !=nil && _tmpBtn == sender){
        sender.selected = YES;
        
    }
    else if (_tmpBtn!= sender && _tmpBtn!=nil){
        _tmpBtn.selected = NO;
        sender.selected = YES;
        _tmpBtn = sender;
    }
    if (_tmpBtn== _allBtn) {
        _allLine.hidden = NO;
        _sortLine.hidden = YES;
        _singleLine.hidden = YES;
    }else if (_tmpBtn==_sortBtn){
        _allLine.hidden = YES;
        _sortLine.hidden = NO;
        _singleLine.hidden = YES;
    }else if (_tmpBtn==_singleBtn){
        _allLine.hidden = YES;
        _sortLine.hidden = YES;
        _singleLine.hidden = NO;
    }
    self.typeBlock(sender.tag);
}
@end
