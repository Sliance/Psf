//
//  NavgationView.m
//  TheWorker
//
//  Created by apple on 2018/4/26.
//  Copyright © 2018年 huying. All rights reserved.
//

#import "NavgationView.h"

@implementation NavgationView

-(instancetype)init{
    if (self = [super init]) {
        [self setContentLayout];
    }
    return self;
}
-(void)setContentLayout{
    [self addSubview:self.bgView];
    [self.bgView addSubview:self.backBtn];
    [self.bgView addSubview:self.titleLabel];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self);
    }];
    [self.backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgView);
        make.bottom.equalTo(self.bgView.mas_bottom);
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(40);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.bgView);
        make.height.mas_equalTo(15);
        make.bottom.equalTo(self.bgView).offset(-15);
    }];
}
-(UIImageView *)bgView{
    if (!_bgView) {
        _bgView = [[UIImageView alloc]init];
        _bgView.backgroundColor = [UIColor redColor];
        _bgView.userInteractionEnabled = YES;
    }
    return _bgView;
}
-(UIButton *)backBtn{
    if (!_backBtn) {
        _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backBtn setImage:[UIImage imageNamed:@"icon_back"] forState:UIControlStateNormal];
        [_backBtn addTarget:self action:@selector(backBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backBtn;
}
-(void)backBtnAction{
    if ([self.delegate respondsToSelector:@selector(pressBackBtn)]) {
        [self.delegate pressBackBtn];
    }
}
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = [UIFont systemFontOfSize:15];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}
@end
