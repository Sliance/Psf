//
//  CardHeadView.m
//  Psf
//
//  Created by 燕来秋mac9 on 2018/9/20.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "CardHeadView.h"
#import "CreatQRCodeAndBarCodeFromLeon.h"

@implementation CardHeadView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.headImge];
        [self.headImge addSubview:self.yinView];
        [self.headImge addSubview:self.titleLabel];
        [self.headImge addSubview:self.nameLabel];
        [self.headImge addSubview:self.vImage];
        [self.headImge addSubview:self.cardImage];
        [self.headImge addSubview:self.cardLabel];
        [self.headImge addSubview:self.detailLabel];
        [self.headImge mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.equalTo(self);
        }];
        [self.yinView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(self.headImge);
            make.height.mas_equalTo(40);
        }];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.headImge).offset(-26);
            make.top.equalTo(self.headImge).offset(25);
        }];
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.headImge).offset(-26);
            make.top.equalTo(self.titleLabel.mas_bottom).offset(40);
        }];
        [self.vImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.headImge).offset(-26);
            make.top.equalTo(self.nameLabel.mas_bottom).offset(10);
        }];
        [self.cardImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.headImge).offset(-15);
            make.left.equalTo(self.headImge).offset(15);
            make.top.equalTo(self.headImge).offset(167);
        }];
         [self.cardLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.headImge).offset(-30);
            make.left.equalTo(self.headImge).offset(30);
            make.top.equalTo(self.cardImage.mas_bottom).offset(-5);
        }];
        [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.headImge).offset(-30);
            make.left.equalTo(self.headImge).offset(30);
            make.bottom.equalTo(self.headImge.mas_bottom).offset(-15);
        }];
        
    }
    return self;
}
-(UIView *)yinView{
    if (!_yinView) {
        _yinView = [[UIView alloc]init];
        _yinView.backgroundColor = DSColorAlphaFromHex(0x000000, 0.3);
        _yinView.hidden = YES;
    }
    return _yinView;
}
-(UIImageView *)headImge{
    if (!_headImge) {
        _headImge = [[UIImageView alloc]init];
        _headImge.image = [UIImage imageNamed:@"huiyuan_bg_mine"];
        _headImge.userInteractionEnabled = YES;
    }
    return _headImge;
}

-(UIImageView *)vImage{
    if (!_vImage) {
        _vImage = [[UIImageView alloc]init];
        _vImage.image = [UIImage imageNamed:@"qr_v_icon"];
        _vImage.userInteractionEnabled = YES;
    }
    return _vImage;
}
-(UIImageView *)cardImage{
    if (!_cardImage) {
        _cardImage = [[UIImageView alloc]init];
        _cardImage.image = [CreatQRCodeAndBarCodeFromLeon generateBarCode:@"1238479786843" size:CGSizeMake(SCREENWIDTH-30, 80) color:[UIColor blackColor] backGroundColor:[UIColor whiteColor]];
        _cardImage.userInteractionEnabled = YES;
    }
    return _cardImage;
}
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = [UIFont boldSystemFontOfSize:24];
        _titleLabel.textColor = DSColorFromHex(0x464646);
        _titleLabel.text = @"会员卡";
        _titleLabel.textAlignment = NSTextAlignmentRight;
        
    }
    return _titleLabel;
}

-(UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.font = [UIFont systemFontOfSize:18];
        _nameLabel.textColor = DSColorFromHex(0x464646);
        _nameLabel.text = @"陈景峰";
        _nameLabel.textAlignment = NSTextAlignmentRight;
        
    }
    return _nameLabel;
}


-(UILabel *)cardLabel{
    if (!_cardLabel) {
        _cardLabel = [[UILabel alloc]init];
        _cardLabel.font = [UIFont systemFontOfSize:15];
        _cardLabel.textColor = DSColorFromHex(0x464646);
        _cardLabel.text = @"卡号：1238479786843";
        _cardLabel.textAlignment = NSTextAlignmentLeft;
        
    }
    return _cardLabel;
}

-(UILabel *)detailLabel{
    if (!_detailLabel) {
        _detailLabel = [[UILabel alloc]init];
        _detailLabel.font = [UIFont systemFontOfSize:12];
        _detailLabel.textColor = DSColorFromHex(0xC7C7C7);
        _detailLabel.text = @"*持会员卡可享特价积分优惠";
        _detailLabel.textAlignment = NSTextAlignmentLeft;
        
    }
    return _detailLabel;
}


@end
