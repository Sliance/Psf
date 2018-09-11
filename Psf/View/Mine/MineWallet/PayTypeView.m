//
//  PayTypeView.m
//  Psf
//
//  Created by 燕来秋mac9 on 2018/7/3.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "PayTypeView.h"

@implementation PayTypeView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.imageLabel];
        [self addSubview:self.typeLabel];
        [self addSubview:self.chooseBtn];
        [self.imageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(15);
            make.height.mas_equalTo(24);
            make.centerY.equalTo(self);
        }];
        [self.typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.imageLabel.mas_right).offset(15);
            make.top.bottom.equalTo(self);
        }];
        [self.chooseBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).offset(-15);
            make.width.height.mas_equalTo(20);
            make.centerY.equalTo(self);
        }];
    }
    return self;
}
-(UIButton *)imageLabel{
    if (!_imageLabel) {
        _imageLabel = [[UIButton alloc]init];
        [_imageLabel setImage:[UIImage imageNamed:@"aiplay"] forState:UIControlStateNormal];
    }
    return _imageLabel;
}
-(UILabel *)typeLabel{
    if (!_typeLabel) {
        _typeLabel = [[UILabel alloc]init];
        _typeLabel.font = [UIFont systemFontOfSize:15];
        _typeLabel.textColor = DSColorFromHex(0x474747);
        _typeLabel.textAlignment = NSTextAlignmentLeft;
        _typeLabel.text = @"支付宝支付";
    }
    return _typeLabel;
}
-(UIButton *)chooseBtn{
    if (!_chooseBtn) {
        _chooseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_chooseBtn setImage:[UIImage imageNamed:@"shopping_normal"] forState:UIControlStateNormal];
        [_chooseBtn setImage:[UIImage imageNamed:@"shopping_selected"] forState:UIControlStateSelected];
        [_chooseBtn addTarget:self action:@selector(pressBtn:) forControlEvents:UIControlEventTouchUpInside];
        _chooseBtn.selected = YES;
    }
    return _chooseBtn;
}
-(void)pressBtn:(UIButton *)sender{
    sender.selected = !sender.selected;
    self.chooseBlock(sender.selected);
}
@end
