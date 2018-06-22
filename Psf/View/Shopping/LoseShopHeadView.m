//
//  LoseShopHeadView.m
//  Psf
//
//  Created by 燕来秋mac9 on 2018/6/22.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "LoseShopHeadView.h"

@implementation LoseShopHeadView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setcornerLayout];
    }
    return self;
}
-(void)setcornerLayout{
    [self addSubview:self.topLineLabel];
    [self addSubview:self.nameLabel];
    [self addSubview:self.bottomLineLabel];
    [self addSubview:self.clearBtn];
    [self.topLineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        make.height.mas_equalTo(5);
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15);
        make.top.equalTo(self.topLineLabel.mas_bottom).offset(17);
    }];
    [self.bottomLineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15);
        make.bottom.equalTo(self);
        make.right.equalTo(self);
        make.height.mas_equalTo(1);
    }];
    [self.clearBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-10);
        make.top.equalTo(self.topLineLabel.mas_bottom).offset(8);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(30);
    }];
}
-(UILabel *)topLineLabel{
    if (!_topLineLabel) {
        _topLineLabel = [[UILabel alloc]init];
        _topLineLabel.backgroundColor = DSColorFromHex(0xF0F0F0);
    }
    return _topLineLabel;
}
-(UILabel *)bottomLineLabel{
    if (!_bottomLineLabel) {
        _bottomLineLabel = [[UILabel alloc]init];
        _bottomLineLabel.backgroundColor = DSColorFromHex(0xF0F0F0);
    }
    return _bottomLineLabel;
}
-(UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        _nameLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:15];
        _nameLabel.textColor = DSColorFromHex(0x474747);
        _nameLabel.text = @"失效商品";
    }
    return _nameLabel;
}
-(UIButton *)clearBtn{
    if (!_clearBtn) {
        _clearBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_clearBtn setTitle:@"清除失效商品" forState:UIControlStateNormal];
        [_clearBtn setTitleColor:DSColorFromHex(0x474747) forState:UIControlStateNormal];
        [_clearBtn.layer setCornerRadius:2];
        [_clearBtn.layer setMasksToBounds:YES];
        [_clearBtn.layer setBorderWidth:0.5];
        _clearBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [_clearBtn.layer setBorderColor:DSColorFromHex(0x474747).CGColor];
        [_clearBtn addTarget:self action:@selector(pressClearBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _clearBtn;
}
-(void)pressClearBtn:(UIButton*)sender{
    
}
@end
