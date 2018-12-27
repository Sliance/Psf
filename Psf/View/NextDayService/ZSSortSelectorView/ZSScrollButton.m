//
//  ZSScrollButton.m
//  ZSSortSelectorView
//
//  Created by 燕来秋mac9 on 2018/6/15.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "ZSScrollButton.h"

@interface ZSScrollButton()
{
    CGFloat _width;
    CGFloat _height;
   
}

@property (nonatomic , strong) UILabel *titleLbl;//文本

@property (nonatomic , strong) UILabel  *countLbl;//角标

@property (nonatomic , strong) UIImageView *lineIV;//下划线

@end
@implementation ZSScrollButton

- (instancetype)initWithFrame:(CGRect)frame miantitle:(NSString *)title count:(NSString *)count {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        _width = frame.size.width;
        _height = frame.size.height;
        
        count = @"";
        [self addSubview:self.titleLbl];
        [self addSubview:self.countLbl];
        [self addSubview:self.lineIV];
        self.titleLbl.text = title;
        self.countLbl.text = count;
        if([count isEqualToString:@"0"]||count.length<1){
            self.countLbl.hidden = YES;
        }
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(chooseButton)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

- (void)changeStatus:(BOOL)sender {
    if (sender) {
        self.titleLbl.textColor = DSColorFromHex(0xFF4C4D);
        self.lineIV.hidden = !_isShow;
    }else{
        self.titleLbl.textColor = DSColorFromHex(0x464646);
        self.lineIV.hidden = _isShow;
    }
}

- (void)chooseButton {
    if (self.delegate) {
        [self.delegate selectedButton:self.tag];
    }
    
}

#pragma mark lazy_load
- (UILabel *)titleLbl {
    if (!_titleLbl) {
        _titleLbl = [[UILabel alloc]initWithFrame:CGRectMake(0, 1, _width, _height-1)];
        _titleLbl.textAlignment = NSTextAlignmentCenter;
        _titleLbl.font = [UIFont systemFontOfSize:14];
        _titleLbl.textColor = DSColorFromHex(0x464646);
        
    }
    return _titleLbl;
}

- (UILabel *)countLbl {
    if (!_countLbl) {
        _countLbl = [[UILabel alloc]initWithFrame:CGRectMake(_width-30, 10, 20, 20)];
        _countLbl.backgroundColor = [UIColor redColor];
        _countLbl.layer.cornerRadius = 10;
        _countLbl.clipsToBounds = YES;
        _countLbl.textColor = [UIColor whiteColor];
        _countLbl.font = [UIFont systemFontOfSize:9];
        _countLbl.textAlignment = NSTextAlignmentCenter;
    }
    return _countLbl;
}

- (UIImageView *)lineIV {
    if (!_lineIV) {
        _lineIV = [[UIImageView alloc]initWithFrame:CGRectMake(15, _height-2, _width-30, 2)];
        _lineIV.backgroundColor = [UIColor redColor];
        _lineIV.hidden = YES;
    }
    return _lineIV;
}
-(void)setIsShow:(BOOL)isShow{
    _isShow = isShow;
    _lineIV.hidden = !isShow;
}
@end
