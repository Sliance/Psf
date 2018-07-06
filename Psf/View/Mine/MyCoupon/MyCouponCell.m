//
//  MyCouponCell.m
//  Psf
//
//  Created by 燕来秋mac9 on 2018/6/25.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "MyCouponCell.h"

@implementation MyCouponCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(UIImageView *)headImage{
    if (!_headImage) {
        _headImage = [[UIImageView alloc]init];
        _headImage.image = [UIImage imageNamed:@""];
        [_headImage.layer setMasksToBounds:YES];
        [_headImage.layer setCornerRadius:2];
        _headImage.layer.borderWidth = 0.5;
        _headImage.layer.borderColor = [UIColor colorWithRed:127.5/255.0 green:127.5/255.0 blue:127.5/255.0 alpha:0.3].CGColor;
    }
    return _headImage;
}
-(UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        _nameLabel.font = [UIFont fontWithName:@"PingFang-SC-Bold" size:15];
        _nameLabel.textColor = [UIColor colorWithRed:70.0001/255.0 green:70.0001/255.0 blue:70.0001/255.0 alpha:1];
        _nameLabel.text = @"10元犁小农全场优惠券";
    }
    return _nameLabel;
}
-(UILabel *)contentLabel{
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc]init];
        _contentLabel.textAlignment = NSTextAlignmentLeft;
        _contentLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:12];
        _contentLabel.textColor = [UIColor colorWithRed:119.001/255.0 green:119.001/255.0 blue:119.001/255.0 alpha:1];
        _contentLabel.text = @"2018.05.12-2018.07.08";
    }
    return _contentLabel;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = DSColorFromHex(0xF0F0F0);
        [self setcornerLayout];
    }
    return self;
}
-(UIView *)bgView{
    if (!_bgView) {
        _bgView = [[UIView alloc]init];
        _bgView.backgroundColor = [UIColor whiteColor];
        [_bgView.layer setCornerRadius:4];
        [_bgView.layer setMasksToBounds:YES];
    }
    return _bgView;
}
-(UIButton *)getBtn{
    if (!_getBtn) {
        _getBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _getBtn.hidden = YES;
        [_getBtn setTitle:@"领取" forState:UIControlStateNormal];
        [_getBtn setTitleColor:DSColorFromHex(0x646464) forState:UIControlStateNormal];
        _getBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_getBtn addTarget:self action:@selector(pressGetBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _getBtn;
}
-(void)setIndex:(NSInteger)index{
    _index = index;
    _getBtn.tag = index;
}
-(void)pressGetBtn:(UIButton*)sender{
    self.getBlock(sender.tag);
}
-(void)setcornerLayout{
    [self addSubview:self.bgView];
    [self.bgView addSubview:self.headImage];
    [self.bgView addSubview:self.nameLabel];
    [self.bgView addSubview:self.contentLabel];
    [self.bgView addSubview:self.getBtn];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15);
        make.right.equalTo(self).offset(-15);
        make.top.equalTo(self).offset(10);
        make.bottom.equalTo(self);
    }];
    [self.headImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgView).offset(10);
        make.width.height.mas_equalTo(70);
        make.centerY.equalTo(self.bgView);
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headImage.mas_right).offset(10);
        make.top.equalTo(self.bgView).offset(25);
        
    }];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headImage.mas_right).offset(10);
        make.top.equalTo(self.nameLabel.mas_bottom).offset(10);
    }];
    [self.getBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.equalTo(self.bgView);
        make.width.mas_equalTo(70);
    }];
   
}
@end
