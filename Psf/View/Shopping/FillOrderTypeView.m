//
//  FillOrderTypeView.m
//  Psf
//
//  Created by 燕来秋mac9 on 2018/6/29.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "FillOrderTypeView.h"

@implementation FillOrderTypeView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setCornerLayout];
    }
    return self;
}
-(void)setCornerLayout{
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.lineLabel];
    [self addSubview:self.kanBtn];
    [self addSubview:self.kanLabel];
    [self addSubview:self.reBtn];
    [self addSubview:self.reLabel];
    
    self.lineLabel.frame = CGRectMake(0, 45, SCREENWIDTH, 1);
    self.kanBtn.frame = CGRectMake(0, 0, SCREENWIDTH/2, 46);
    self.reBtn.frame = CGRectMake(SCREENWIDTH/2, 0, SCREENWIDTH/2, 46);
    self.kanLabel.frame = CGRectMake(0, 45, SCREENWIDTH/2, 2);
    self.reLabel.frame = CGRectMake(SCREENWIDTH/2, 45, SCREENWIDTH/2, 2);
}
-(UILabel *)lineLabel{
    if (!_lineLabel) {
        _lineLabel = [[UILabel alloc]init];
        _lineLabel.backgroundColor = DSColorFromHex(0xDCDCDC);
    }
    return _lineLabel;
}
-(UIButton *)kanBtn{
    if (!_kanBtn) {
        _kanBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_kanBtn setTitle:@"送货上门" forState:UIControlStateNormal];
        [_kanBtn setTitleColor:DSColorFromHex(0x474747) forState:UIControlStateNormal];
        _kanBtn.selected = YES;
        [_kanBtn setTitleColor:DSColorFromHex(0xFF4C4D) forState:UIControlStateSelected];
        _kanBtn.tag = 1;
        [_kanBtn addTarget:self action:@selector(pressBtn:) forControlEvents:UIControlEventTouchUpInside];
        _kanBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    }
    return _kanBtn;
}
-(UIButton *)reBtn{
    if (!_reBtn) {
        _reBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_reBtn setTitle:@"门店自提" forState:UIControlStateNormal];
        [_reBtn setTitleColor:DSColorFromHex(0x474747) forState:UIControlStateNormal];
        [_reBtn setTitleColor:DSColorFromHex(0xFF4C4D) forState:UIControlStateSelected];
        _reBtn.tag = 2;
        [_reBtn addTarget:self action:@selector(pressBtn:) forControlEvents:UIControlEventTouchUpInside];
        _reBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    }
    return _reBtn;
}
-(UILabel *)kanLabel{
    if (!_kanLabel) {
        _kanLabel = [[UILabel alloc]init];
        _kanLabel.backgroundColor = DSColorFromHex(0xFF4C4D);
    }
    return _kanLabel;
}
-(UILabel *)reLabel{
    if (!_reLabel) {
        _reLabel = [[UILabel alloc]init];
        _reLabel.backgroundColor = DSColorFromHex(0xFF4C4D);
        _reLabel.hidden = YES;
    }
    return _reLabel;
}
-(void)pressBtn:(UIButton*)sender{
    _kanBtn.selected = NO;
    if (_tmpBtn == nil){
        sender.selected = YES;
        _tmpBtn = sender;
    }else if (_tmpBtn !=nil && _tmpBtn == sender){
        sender.selected = YES;
        
    }else if (_tmpBtn!= sender && _tmpBtn!=nil){
        _tmpBtn.selected = NO;
        sender.selected = YES;
        _tmpBtn = sender;
    }
    if (_tmpBtn== _kanBtn) {
        _kanLabel.hidden = NO;
        _reLabel.hidden = YES;
        
    }else if (_tmpBtn==_reBtn){
        _reLabel.hidden = NO;
        _kanLabel.hidden = YES;
    }
    self.chooseTypeBlock(sender.tag);
}
@end
