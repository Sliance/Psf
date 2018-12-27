//
//  TopicTopCell.m
//  Psf
//
//  Created by zhangshu on 2018/12/24.
//  Copyright © 2018 zhangshu. All rights reserved.
//

#import "TopicTopCell.h"
#import "ZSConfig.h"
@implementation TopicTopCell
-(UIView *)bgView{
    if (!_bgView) {
        _bgView = [[UIView alloc]init];
        [_bgView.layer setCornerRadius:6];
        [_bgView.layer setBorderWidth:1];
        [_bgView.layer setBorderColor:DSColorFromHex(0xE6E6E6).CGColor];
    }
    return _bgView;
}
-(UIImageView *)headImage{
    if (!_headImage) {
        _headImage = [[UIImageView alloc]init];
        
    }
    return _headImage;
}
-(UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.textColor = DSColorFromHex(0x464646);
        _nameLabel.font = [UIFont systemFontOfSize:15];
    }
    return _nameLabel;
}
-(UILabel *)priceLabel{
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc]init];
        _priceLabel.textColor = DSColorFromHex(0x646464);
        _priceLabel.font = [UIFont systemFontOfSize:15];
    }
    return _priceLabel;
}
-(UIButton *)goBtn{
    if (!_goBtn) {
        _goBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _goBtn.backgroundColor = DSColorFromHex(0x646464);
        [_goBtn setTitle:@"去抢购" forState:UIControlStateNormal];
        [_goBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _goBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [_goBtn.layer setCornerRadius:2];
        [_goBtn addTarget:self action:@selector(pressGo) forControlEvents:UIControlEventTouchUpInside];
    }
    return _goBtn;
}
-(instancetype)initWithFrame:(CGRect)frame{
   self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.bgView];
        [self.bgView addSubview:self.nameLabel];
        [self.bgView addSubview:self.headImage];
        [self.bgView addSubview:self.priceLabel];
        [self.bgView addSubview:self.goBtn];
        [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(15);
            make.right.equalTo(self).offset(-15);
            make.top.equalTo(self).offset(20);
            make.height.mas_equalTo(145*SCREENWIDTH/345+55);
        }];
        [self.headImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.bgView);
            make.right.equalTo(self.bgView);
            make.top.equalTo(self.bgView);
            make.height.mas_equalTo(145*SCREENWIDTH/345);
        }];
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.bgView).offset(10);
            make.top.equalTo(self.headImage.mas_bottom).offset(10);
        }];
        [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.bgView).offset(10);
            make.top.equalTo(self.nameLabel.mas_bottom).offset(5);
        }];
        [self.goBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.headImage.mas_bottom).offset(13);
            make.right.equalTo(self.bgView).offset(-16);
            make.width.mas_equalTo(80);
            make.height.mas_equalTo(30);
        }];
    }
    return self;
}
-(void)pressGo{
    self.goBlock();
}
-(void)setModel:(StairCategoryListRes *)model{
    _model = model;
    NSString*url = [NSString stringWithFormat:@"%@%@",IMAGEHOST,model.subjectProductImagePath];
    [self.headImage sd_setImageWithURL:[NSURL URLWithString:url]];
    self.nameLabel.text = model.productName;
    if (model.productPrice) {
        if (model.productStyle ==1) {
            double price = [model.productPrice doubleValue]*[[UserCacheBean share].userInfo.productDefaultWeight doubleValue];
            NSString* productPrice = [NSString stringWithFormat:@"￥%.2f",price];
            self.priceLabel.text = productPrice;
        }else{
            self.priceLabel.text = [NSString stringWithFormat:@"￥%@",model.productPrice];
        }
        
    }
}
@end
