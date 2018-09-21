//
//  PaymentCardView.m
//  Psf
//
//  Created by 燕来秋mac9 on 2018/9/20.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "PaymentCardView.h"
#import "CreatQRCodeAndBarCodeFromLeon.h"
@implementation PaymentCardView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.titleLabel];
        [self addSubview:self.cardLabel];
        [self addSubview:self.vImage];
        [self addSubview:self.cardImage];
        [self addSubview:self.detailLabel];
        [self.vImage addSubview:self.headImge];
         [self addSubview:self.yanBtn];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(self);
            make.height.mas_equalTo(45);
        }];
        [self.cardImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).offset(-15);
            make.left.equalTo(self).offset(15);
            make.top.equalTo(self).offset(45);
        }];
        [self.cardLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.top.equalTo(self.cardImage.mas_bottom);
        }];
        [self.vImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo(160);
            make.top.equalTo(self.cardLabel.mas_bottom).offset(5);
            make.centerX.equalTo(self);
        }];
        [self.headImge mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo(38);
            make.centerY.equalTo(self.vImage);
            make.centerX.equalTo(self.vImage);
        }];
        [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self).offset(-20);
            make.centerX.equalTo(self.vImage).offset(-10);
        }];
        [self.yanBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.detailLabel.mas_right);
            make.width.height.mas_equalTo(30);
            make.centerY.equalTo(self.detailLabel);
        }];
    }
    return self;
}

-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.text = @"   付款码";
        _titleLabel.textColor = DSColorFromHex(0x464646);
        _titleLabel.font = [UIFont systemFontOfSize:15];
        _titleLabel.backgroundColor = DSColorFromHex(0xEFEFEF);
    }
    return _titleLabel;
}

-(UIImageView *)headImge{
    if (!_headImge) {
        _headImge = [[UIImageView alloc]init];
        _headImge.image = [UIImage imageNamed:@"qr_icon"];
        _headImge.userInteractionEnabled = YES;
    }
    return _headImge;
}

-(UIImageView *)vImage{
    if (!_vImage) {
        _vImage = [[UIImageView alloc]init];
        
        _vImage.userInteractionEnabled = YES;
    }
    return _vImage;
}
-(UIImageView *)cardImage{
    if (!_cardImage) {
        _cardImage = [[UIImageView alloc]init];
        
        _cardImage.userInteractionEnabled = YES;
    }
    return _cardImage;
}




-(UIButton *)cardLabel{
    if (!_cardLabel) {
        _cardLabel = [UIButton buttonWithType:UIButtonTypeCustom];
        
        _cardLabel.titleLabel.font = [UIFont systemFontOfSize:15];
        [_cardLabel setTitle:@"点击可查看付款码数字" forState:UIControlStateNormal];
        [_cardLabel setTitleColor:DSColorFromHex(0x464646) forState:UIControlStateNormal];
        [_cardLabel addTarget:self action:@selector(pressCard:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cardLabel;
}

-(UILabel *)detailLabel{
    if (!_detailLabel) {
        _detailLabel = [[UILabel alloc]init];
        _detailLabel.font = [UIFont systemFontOfSize:15];
        _detailLabel.textColor = DSColorFromHex(0x464646);
        _detailLabel.text = @"账户余额   ****元";
        _detailLabel.textAlignment = NSTextAlignmentCenter;
        
    }
    return _detailLabel;
}

-(UIButton *)yanBtn{
    if (!_yanBtn) {
        _yanBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_yanBtn setImage:[UIImage imageNamed:@"open_eye_mine"] forState:UIControlStateSelected];
         [_yanBtn setImage:[UIImage imageNamed:@"close_eye_mine"] forState:UIControlStateNormal];
        [_yanBtn addTarget:self action:@selector(pressYan:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _yanBtn;
}

-(void)pressCard:(UIButton*)sender{
    sender.selected = !sender.selected;
}
-(void)pressYan:(UIButton*)sender{
    sender.selected = !sender.selected;
    if (sender.selected ==YES) {
        _detailLabel.text = [NSString stringWithFormat:@"账户余额   %@元",_money];
    }else{
        _detailLabel.text = @"账户余额   ****元";
    }
}


-(void)setPayCode:(NSString *)payCode{
    _vImage.image = [CreatQRCodeAndBarCodeFromLeon qrImageWithString:payCode size:CGSizeMake(160, 160) color:[UIColor blackColor] backGroundColor:[UIColor whiteColor]];
    _cardImage.image = [CreatQRCodeAndBarCodeFromLeon generateBarCode:payCode size:CGSizeMake(SCREENWIDTH-30, 80) color:[UIColor blackColor] backGroundColor:[UIColor whiteColor]];
    [_cardLabel setTitle:payCode forState:UIControlStateSelected];
}
-(void)setMoney:(NSString *)money{
    _money= money;
}


@end
