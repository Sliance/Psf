//
//  DNCommentInputBar.m
//  DnaerApp
//
//  Created by 燕来秋 on 2018/11/5.
//  Copyright © 2018 燕来秋. All rights reserved.
//

#import "DNCommentInputBar.h"
#import "ZSConfig.h"
@interface DNCommentInputBar ()

@property (nonatomic, strong) UIView *inputBgView;
@property (nonatomic, strong) UIView *favourView;

@property (nonatomic, strong) UIButton *commentIcon;

@property(nonatomic,strong)UILabel *lineLabel;
@end

@implementation DNCommentInputBar

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self setup];
    }
    return self;
}

- (instancetype)init {
    if (self = [super init]) {
        [self setup];
    }
    return self;
}

- (void)setup {

    [self addSubview:self.favourView];
    [self.favourView addSubview:self.inputField];
    [self addSubview:self.commentIcon];
    [self addSubview:self.lineLabel];
    
    // 添加约束
    [self add_mas_constraints];
}

- (void)add_mas_constraints {
    [self.favourView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(SCREENWIDTH-60);
        make.top.mas_equalTo(self).offset(10);
        make.height.mas_equalTo(30);
        make.left.equalTo(self).offset(10);
    }];
    [self.commentIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(49);
        make.top.mas_equalTo(self);
    }];
    
    
    [self.inputField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.favourView).offset(10);
        make.right.equalTo(self.favourView);
        make.height.mas_equalTo(30);
        make.centerY.equalTo(self.favourView);
    }];
    [self.lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self);
        make.height.mas_equalTo(0.5);
    }];
}

#pragma mark - 懒加载
- (UIView *)inputBgView {
    if (!_inputBgView) {
        _inputBgView = [UIView new];
        [_inputBgView setBackgroundColor:DSColorFromHex(0xF0F0F0)];
    }
    return _inputBgView;
}
-(UILabel *)lineLabel{
    if (!_lineLabel) {
        _lineLabel = [[UILabel alloc]init];
        _lineLabel.backgroundColor = DSColorFromHex(0xF0F0F0);
    }
    return _lineLabel;
}
- (UITextField *)inputField {
    if (!_inputField) {
        _inputField = [[UITextField alloc]init];
        _inputField.placeholder = @"说点什么吧";
        _inputField.font = [UIFont systemFontOfSize:14];
    }
    return _inputField;
}

- (UIView *)favourView {
    if (!_favourView) {
        _favourView = [UIView new];
        _favourView.backgroundColor = DSColorFromHex(0xF0F0F0);
        [_favourView.layer setMasksToBounds:YES];
        [_favourView.layer setCornerRadius:15];
    }
    return _favourView;
}


- (UIButton *)commentIcon {
    if (!_commentIcon) {
        _commentIcon = [UIButton buttonWithType:UIButtonTypeCustom];
        [_commentIcon setTitle:@"发送" forState:UIControlStateNormal];
        [_commentIcon setTitleColor:DSColorFromHex(0x323232) forState:UIControlStateNormal];
        _commentIcon.titleLabel.font = [UIFont systemFontOfSize:16];
        [_commentIcon addTarget:self action:@selector(pressSend) forControlEvents:UIControlEventTouchUpInside];
    }
    return _commentIcon;
}

-(void)pressSend{
    self.sendBlock(self.inputField.text);
}
@end
