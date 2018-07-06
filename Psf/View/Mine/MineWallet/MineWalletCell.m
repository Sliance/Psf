//
//  MineWalletCell.m
//  Psf
//
//  Created by 燕来秋mac9 on 2018/7/2.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "MineWalletCell.h"

@implementation MineWalletCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setcornerLayout];
    }
    return self;
}
-(void)setcornerLayout{
    [self addSubview:self.priceLabel];
    [self addSubview:self.titleLabel];
    [self addSubview:self.contentLabel];
    [self addSubview:self.rechargeBtn];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(17);
        make.top.equalTo(self).offset(16);
    }];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(16);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(10);
    }];
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(16);
        make.bottom.equalTo(self).offset(-18);
    }];
    [self.rechargeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-15);
        make.centerY.equalTo(self);
        make.width.mas_equalTo(75);
        make.height.mas_equalTo(30);
    }];
}
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = [UIFont systemFontOfSize:15];
        _titleLabel.textColor = DSColorFromHex(0x464646);
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.text = @"余额";
    }
    return _titleLabel;
}
-(UILabel *)contentLabel{
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc]init];
        _contentLabel.font = [UIFont systemFontOfSize:12];
        _contentLabel.textColor = DSColorFromHex(0x969696);
        _contentLabel.textAlignment = NSTextAlignmentLeft;
        _contentLabel.text = @"我的可用余额";
    }
    return _contentLabel;
}
-(UILabel *)priceLabel{
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc]init];
        _priceLabel.font = [UIFont systemFontOfSize:24];
        _priceLabel.textColor = DSColorFromHex(0x464646);
        _priceLabel.textAlignment = NSTextAlignmentLeft;
        _priceLabel.text = @"¥ 231,579.0";
    }
    return _priceLabel;
}
-(UIButton *)rechargeBtn{
    if (!_rechargeBtn) {
        _rechargeBtn = [UIButton buttonWithType:UIButtonTypeCustom] ;
        [_rechargeBtn setBackgroundImage:[UIImage imageNamed:@"shopping_submit"] forState:UIControlStateNormal];
        [_rechargeBtn setTitle:@"充值" forState:UIControlStateNormal];
        [_rechargeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _rechargeBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_rechargeBtn.layer setMasksToBounds:YES];
        [_rechargeBtn addTarget:self action:@selector(pressCharge:) forControlEvents:UIControlEventTouchUpInside];
        [_rechargeBtn.layer setCornerRadius:15];
    }
    return _rechargeBtn;
}
-(void)pressCharge:(UIButton*)sender{
    self.chargeBlock(sender.tag);
}
@end
