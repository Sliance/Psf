//
//  StoreGoodsBuyView.m
//  Psf
//
//  Created by 燕来秋mac9 on 2018/9/27.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "StoreGoodsBuyView.h"

@implementation StoreGoodsBuyView

-(UIView *)yinBGview{
    if (!_yinBGview) {
        _yinBGview = [[UIView alloc]init];
        _yinBGview.backgroundColor = DSColorAlphaFromHex(0x000000, 0.3);
    }
    return _yinBGview;
}
-(UIView *)BGview{
    if (!_BGview) {
        _BGview = [[UIView alloc]init];
        _BGview.backgroundColor = [UIColor whiteColor];
    }
    return _BGview;
}
-(UILabel *)buyLabel{
    if (!_buyLabel) {
        _buyLabel = [[UILabel alloc]init];
        _buyLabel.text = @"输入购买重量";
        _buyLabel.textColor = DSColorFromHex(0x464646);
        _buyLabel.font = [UIFont systemFontOfSize:15];
    }
    return _buyLabel;
}

-(UITextField *)countField{
    if (!_countField) {
        _countField = [[UITextField alloc]init];
        [_countField.layer setBorderColor:DSColorFromHex(0x707070).CGColor];
        [_countField.layer setBorderWidth:0.5];
        _countField.font = [UIFont systemFontOfSize:12];
        _countField.keyboardType = UIKeyboardTypeNumberPad;
        _countField.textAlignment = NSTextAlignmentCenter;
        _countField.text = @"";
    }
    return _countField;
}
-(UIButton *)submitBtn{
    if (!_submitBtn) {
        _submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_submitBtn setBackgroundImage:[UIImage imageNamed:@"shopping_submit"] forState:UIControlStateNormal];
        [_submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_submitBtn setTitle:@"加入购物车" forState:UIControlStateNormal];
        _submitBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_submitBtn addTarget:self action:@selector(pressSubmit) forControlEvents:UIControlEventTouchUpInside];
    }
    return _submitBtn;
}
-(UIImageView *)headImage{
    if (!_headImage) {
        _headImage = [[UIImageView alloc]init];
        _headImage.image = [UIImage imageNamed:@""];
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
        _nameLabel.textColor = DSColorFromHex(0x474747);
        _nameLabel.text = @"";
    }
    return _nameLabel;
}
-(UILabel *)contentLabel{
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc]init];
        _contentLabel.textAlignment = NSTextAlignmentCenter;
        _contentLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:15];
        _contentLabel.textColor = DSColorFromHex(0x464646);
        _contentLabel.text = @"kg";
    }
    return _contentLabel;
}
-(UILabel *)priceLabel{
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc]init];
        _priceLabel.textAlignment = NSTextAlignmentLeft;
        _priceLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:15];
        _priceLabel.textColor = DSColorFromHex(0xFF4C4D);
        _priceLabel.text = @"￥0";
    }
    return _priceLabel;
}
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setCortentLayout];
        
    }
    return self;
}
-(void)setCortentLayout{
    [self addSubview:self.yinBGview];
    [self addSubview:self.BGview];
    [self.BGview addSubview:self.buyLabel];
   
    [self.BGview addSubview:self.countField];
    [self.BGview addSubview:self.submitBtn];
    [self.BGview addSubview:self.headImage];
    [self.BGview addSubview:self.nameLabel];
    [self.BGview addSubview:self.contentLabel];
    [self.BGview addSubview:self.priceLabel];
    
    
}
-(void)setHeight:(NSInteger )height{
    _height = height;
    
    self.yinBGview.frame = CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT-250+49-height);
    self.BGview.frame = CGRectMake(0, SCREENHEIGHT-250+49-height, SCREENWIDTH, 250-49+height);
    [self.submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.BGview).offset(15);
        make.right.equalTo(self.BGview).offset(-15);
        make.bottom.equalTo(self.BGview.mas_bottom).offset(39-height);
        make.height.mas_equalTo(44);
    }];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.BGview);
        make.bottom.equalTo(self.submitBtn.mas_top).offset(-33);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(26);
    }];
    [self.countField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-50);
        make.centerY.equalTo(self.contentLabel);
        make.height.mas_equalTo(26);
        make.width.mas_equalTo(90);
    }];
    [self.buyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.BGview).offset(15);
        make.centerY.equalTo(self.contentLabel);
        make.height.mas_equalTo(26);
        make.width.mas_equalTo(SCREENWIDTH/2);
    }];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pressTap)];
    [self.yinBGview addGestureRecognizer:tap];
    self.headImage.frame = CGRectMake(15, 10, 90, 90);
    self.nameLabel.frame = CGRectMake(109, 20, SCREENWIDTH-114, 15);
    self.priceLabel.frame = CGRectMake(109, 50, SCREENWIDTH-114, 15);
    
}


-(void)pressSubmit{
    self.submitBlock(_countField.text,_model,_catemodel);
}
-(void)pressTap{
    self.tapBlock();
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    _countField.text = textField.text;
    
    return [textField resignFirstResponder];
}

-(void)setModel:(GoodDetailRes *)model{
    _model = model;
    NSString *url = [NSString stringWithFormat:@"%@%@",IMAGEHOST,model.productImagePath];
    [self.headImage sd_setImageWithURL:[NSURL URLWithString:url]];
    self.nameLabel.text = model.productName;
    self.priceLabel.text = [NSString stringWithFormat:@"￥%@/%@",model.productPrice,model.productUnit];
}
-(void)setCatemodel:(StairCategoryListRes *)catemodel{
    _catemodel = catemodel;
    NSString *url = [NSString stringWithFormat:@"%@%@",IMAGEHOST,catemodel.productImagePath];
    [self.headImage sd_setImageWithURL:[NSURL URLWithString:url]];
    self.nameLabel.text = catemodel.productName;
    self.priceLabel.text = [NSString stringWithFormat:@"￥%@/%@",catemodel.productPrice,catemodel.productUnit];
}







@end
