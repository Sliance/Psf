//
//  NextCollectionViewCell.m
//  Psf
//
//  Created by 燕来秋mac9 on 2018/6/19.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "NextCollectionViewCell.h"
#import <Masonry.h>

@implementation NextCollectionViewCell
-(UIImageView *)headImage{
    if (!_headImage) {
        _headImage = [[UIImageView alloc]init];
        _headImage.image = [UIImage imageNamed:@"niu"];
        [_headImage.layer setMasksToBounds:YES];
        [_headImage.layer setCornerRadius:4];
        _headImage.layer.borderWidth = 0.5;
        _headImage.layer.borderColor = [UIColor colorWithRed:127.5/255.0 green:127.5/255.0 blue:127.5/255.0 alpha:0.3].CGColor;
    }
    return _headImage;
}
-(UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        _nameLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:15];
        _nameLabel.textColor = [UIColor colorWithRed:70.0001/255.0 green:70.0001/255.0 blue:70.0001/255.0 alpha:1];
        _nameLabel.text = @"澳洲牛腱子";
    }
    return _nameLabel;
}
-(UILabel *)contentLabel{
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc]init];
        _contentLabel.textAlignment = NSTextAlignmentLeft;
        _contentLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:12];
        _contentLabel.textColor = [UIColor colorWithRed:119.001/255.0 green:119.001/255.0 blue:119.001/255.0 alpha:1];
        _contentLabel.text = @"澳大利亚牧场直供，精选优质";
    }
    return _contentLabel;
}
-(UILabel *)presaleLabel{
    if (!_presaleLabel) {
        _presaleLabel = [[UILabel alloc]init];
        _presaleLabel.textAlignment = NSTextAlignmentRight;
        _presaleLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:12];
        _presaleLabel.textColor = [UIColor colorWithRed:119.001/255.0 green:119.001/255.0 blue:119.001/255.0 alpha:1];
        _presaleLabel.text = @"";
    }
    return _presaleLabel;
}
-(UILabel *)priceLabel{
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc]init];
        _priceLabel.textAlignment = NSTextAlignmentLeft;
        _priceLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:15];
        _priceLabel.textColor = [UIColor colorWithRed:255/255.0 green:75.9977/255.0 blue:77.0024/255.0 alpha:1];
        _priceLabel.text = @"￥99.8";
    }
    return _priceLabel;
}
-(UILabel *)weightLabel{
    if (!_weightLabel) {
        _weightLabel = [[UILabel alloc]init];
        _weightLabel.textAlignment = NSTextAlignmentLeft;
        _weightLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:12];
        _weightLabel.textColor = [UIColor colorWithRed:255/255.0 green:75.9977/255.0 blue:77.0024/255.0 alpha:1];
        _weightLabel.text = @"/250g";
    }
    return _weightLabel;
}
-(UILabel *)raiseLabel{
    if (!_raiseLabel) {
        _raiseLabel = [[UILabel alloc]init];
        _raiseLabel.textAlignment = NSTextAlignmentCenter;
        _raiseLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:11];
        _raiseLabel.backgroundColor = [UIColor colorWithRed:208/255.0 green:181/255.0 blue:151/255.0 alpha:1];
        [_raiseLabel.layer setCornerRadius:1];
        [_raiseLabel.layer setMasksToBounds:YES];
        _raiseLabel.textColor = [UIColor whiteColor];
        _raiseLabel.hidden = YES;
        _raiseLabel.text = @"加价购";
    }
    return _raiseLabel;
}
-(UILabel *)quickLabel{
    if (!_quickLabel) {
        _quickLabel = [[UILabel alloc]init];
        _quickLabel.textAlignment = NSTextAlignmentCenter;
        _quickLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:11];
        _quickLabel.backgroundColor = [UIColor colorWithRed:215/255.0 green:133/255.0 blue:131/255.0 alpha:1];
        _quickLabel.hidden = YES;
        [_quickLabel.layer setCornerRadius:1];
        [_quickLabel.layer setMasksToBounds:YES];
        _quickLabel.textColor = [UIColor whiteColor];
        _quickLabel.text = @"爆款";
    }
    return _quickLabel;
}
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setcornerLayout];
    }
    return self;
}
-(void)setcornerLayout{
    [self addSubview:self.headImage];
    [self addSubview:self.nameLabel];
    [self addSubview:self.contentLabel];
    [self addSubview:self.priceLabel];
    [self addSubview:self.weightLabel];
    [self addSubview:self.raiseLabel];
    [self addSubview:self.quickLabel];
    [self addSubview:self.presaleLabel];
    [self.headImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self).offset(15);
        make.width.height.mas_equalTo(165);
        
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headImage.mas_left);
        make.top.equalTo(self.headImage.mas_bottom).offset(10);
        make.width.mas_equalTo(165);
        
    }];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headImage.mas_left);
        make.top.equalTo(self.nameLabel.mas_bottom).offset(4);
        make.width.mas_equalTo(165);
        
    }];
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headImage.mas_left);
        make.top.equalTo(self.contentLabel.mas_bottom).offset(6);
        
    }];
    [self.weightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.priceLabel.mas_right);
        make.bottom.equalTo(self.priceLabel.mas_bottom);
        
    }];
    [self.presaleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-15);
        make.bottom.equalTo(self.priceLabel.mas_bottom);
        
    }];
    [self.raiseLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headImage.mas_left);
        make.top.equalTo(self.priceLabel.mas_bottom).offset(8);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(18);
    }];
    [self.quickLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.raiseLabel.mas_right).offset(5);
        make.top.equalTo(self.priceLabel.mas_bottom).offset(8);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(18);
    }];
}
-(void)setModel:(StairCategoryListRes *)model{
    _model = model;
    self.nameLabel.text = model.productName;
    NSString *url = [NSString stringWithFormat:@"%@%@",IMAGEHOST,model.productImagePath];
    [self.headImage sd_setImageWithURL:[NSURL URLWithString:url]];
    self.contentLabel.text = model.productTitle;
    self.priceLabel.text = [NSString stringWithFormat:@"￥%@/",model.productPrice];
    self.weightLabel.text = model.productUnit;
}
-(void)setGroupmodel:(GroupListRes *)groupmodel{
    _groupmodel = groupmodel;
    self.nameLabel.text = groupmodel.productName;
    NSString *url = [NSString stringWithFormat:@"%@%@",IMAGEHOST,groupmodel.productImagePath];
    [self.headImage sd_setImageWithURL:[NSURL URLWithString:url]];
    self.contentLabel.text = groupmodel.productTitle;
   
    if (groupmodel.preSaleId.length>0) {
        
        self.priceLabel.text = [NSString stringWithFormat:@"￥%@/",groupmodel.productPrice];
        self.presaleLabel.text = [NSString stringWithFormat:@"%ld人已预定",(long)groupmodel.preSaleQuantity];
    }else{
        self.priceLabel.text = [NSString stringWithFormat:@"￥%@/",groupmodel.grouponPrice];
    }
    self.weightLabel.text = groupmodel.productUnit;
}
@end
