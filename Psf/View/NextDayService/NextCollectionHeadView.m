//
//  NextCollectionHeadView.m
//  Psf
//
//  Created by 燕来秋mac9 on 2018/7/2.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "NextCollectionHeadView.h"

@implementation NextCollectionHeadView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = DSColorFromHex(0xF0F0F0);
        [self setCornerLayout];
    }
    return self;
}
-(void)setCornerLayout{
    [self addSubview:self.bgView];
    [self.bgView addSubview:self.typeBtn];
    [self.bgView addSubview:self.detailLabel];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.top.equalTo(self).offset(5);
    }];
    [self.typeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bgView).offset(15);
        make.width.mas_equalTo(100);
        make.centerX.equalTo(self.bgView);
    }];
}
-(UIButton *)typeBtn{
    if (!_typeBtn) {
        _typeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_typeBtn setTitle:@"牛肉" forState:UIControlStateNormal];
        [_typeBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        _typeBtn.titleLabel.font = [UIFont boldSystemFontOfSize:18];
//        _typeBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -100);
        [_typeBtn addTarget:self action:@selector(pressType:) forControlEvents:UIControlEventTouchUpInside];
        
        [_typeBtn setTitleColor:DSColorFromHex(0x464646) forState:UIControlStateNormal];
    }
    return _typeBtn;
}
-(UIView *)bgView{
    if (!_bgView) {
        _bgView = [[UIView alloc]init];
        _bgView.backgroundColor = [UIColor whiteColor];
    }
    return _bgView;
}
-(void)pressType:(UIButton *)sender{
    self.pressTypeBlock(sender.tag);
}
@end
