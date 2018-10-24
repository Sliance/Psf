//
//  PresaleBuyView.m
//  Psf
//
//  Created by 燕来秋mac9 on 2018/7/16.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "PresaleBuyView.h"

@implementation PresaleBuyView

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
    [self.BGview addSubview:self.addBtn];
    [self.BGview addSubview:self.subBtn];
    [self.BGview addSubview:self.countField];
    [self.BGview addSubview:self.submitBtn];
    [self.BGview addSubview:self.headImage];
    [self.BGview addSubview:self.nameLabel];
    [self.BGview addSubview:self.contentLabel];
    [self.BGview addSubview:self.priceLabel];
    
}

-(void)setHeight:(NSInteger )height{
    _height = height;

    self.yinBGview.frame = CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT-300+49-height);
    self.BGview.frame = CGRectMake(0, SCREENHEIGHT-300+49-height, SCREENWIDTH, 300-49+height);
    [self.submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.BGview).offset(15);
        make.right.equalTo(self.BGview).offset(-15);
        make.bottom.equalTo(self.BGview.mas_bottom).offset(39-height);
        make.height.mas_equalTo(44);
    }];
    [self.buyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.BGview).offset(15);
        make.bottom.equalTo(self.submitBtn.mas_top);
        make.height.mas_equalTo(100);
        make.width.mas_equalTo(SCREENWIDTH/2);
    }];
    [self.addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-15);
        make.centerY.equalTo(self.buyLabel);
        make.height.mas_equalTo(26);
        make.width.mas_equalTo(36);
    }];
    [self.subBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-86);
        make.centerY.equalTo(self.buyLabel);
        make.height.mas_equalTo(26);
        make.width.mas_equalTo(36);
    }];
    [self.countField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-50);
        make.centerY.equalTo(self.buyLabel);
        make.height.mas_equalTo(26);
        make.width.mas_equalTo(36);
    }];
   
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pressTap)];
    [self.yinBGview addGestureRecognizer:tap];
    self.headImage.frame = CGRectMake(15, 10, 90, 90);
    self.nameLabel.frame = CGRectMake(109, 20, SCREENWIDTH-114, 15);
    self.priceLabel.frame = CGRectMake(109, 50, SCREENWIDTH-114, 15);
    self.contentLabel.frame = CGRectMake(109, 70, SCREENWIDTH-114, 15);
}
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
        _buyLabel.text = @"购买数量";
        _buyLabel.textColor = DSColorFromHex(0x464646);
        _buyLabel.font = [UIFont systemFontOfSize:18];
    }
    return _buyLabel;
}
-(UIButton *)subBtn{
    if (!_subBtn) {
        _subBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_subBtn setTitle:@"-" forState:UIControlStateNormal];
        [_subBtn setTitleColor:DSColorFromHex(0x707070) forState:UIControlStateNormal];
        [_subBtn.layer setCornerRadius:2];
        [_subBtn.layer setMasksToBounds:YES];
        [_subBtn.layer setBorderWidth:0.5];
        [_subBtn.layer setBorderColor:DSColorFromHex(0x707070).CGColor];
        [_subBtn addTarget:self action:@selector(pressSubBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    return _subBtn;
}
-(UIButton *)addBtn{
    if (!_addBtn) {
        _addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_addBtn setTitle:@"+" forState:UIControlStateNormal];
        [_addBtn setTitleColor:DSColorFromHex(0x707070) forState:UIControlStateNormal];
        [_addBtn.layer setCornerRadius:2];
        [_addBtn.layer setMasksToBounds:YES];
        [_addBtn.layer setBorderWidth:0.5];
        [_addBtn.layer setBorderColor:DSColorFromHex(0x707070).CGColor];
        [_addBtn addTarget:self action:@selector(pressAddBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addBtn;
}

-(UITextField *)countField{
    if (!_countField) {
        _countField = [[UITextField alloc]init];
        [_countField.layer setBorderColor:DSColorFromHex(0x707070).CGColor];
        [_countField.layer setBorderWidth:0.5];
        _countField.font = [UIFont systemFontOfSize:12];
        _countField.textAlignment = NSTextAlignmentCenter;
        _countField.text = @"1";
    }
    return _countField;
}
-(UIButton *)submitBtn{
    if (!_submitBtn) {
        _submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_submitBtn setBackgroundImage:[UIImage imageNamed:@"shopping_submit"] forState:UIControlStateNormal];
        [_submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_submitBtn setTitle:@"马上购买" forState:UIControlStateNormal];
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
        _nameLabel.textColor = [UIColor colorWithRed:70.0001/255.0 green:70.0001/255.0 blue:70.0001/255.0 alpha:1];
        _nameLabel.text = @"";
    }
    return _nameLabel;
}
-(UILabel *)contentLabel{
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc]init];
        _contentLabel.textAlignment = NSTextAlignmentLeft;
        _contentLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:15];
        _contentLabel.textColor = DSColorFromHex(0x464646);
        _contentLabel.text = @"已选择";
    }
    return _contentLabel;
}
-(UILabel *)priceLabel{
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc]init];
        _priceLabel.textAlignment = NSTextAlignmentLeft;
        _priceLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:15];
        _priceLabel.textColor = [UIColor colorWithRed:255/255.0 green:75.9977/255.0 blue:77.0024/255.0 alpha:1];
        _priceLabel.text = @"￥0";
    }
    return _priceLabel;
}
-(void)setCount:(NSInteger)count{
    _count = count;
}
-(void)pressAddBtn{
    NSInteger count = [_countField.text integerValue];
    count = count+1;
    _countField.text = [NSString stringWithFormat:@"%ld",(long)count];
    if (count>1) {
        [_subBtn setTitleColor:DSColorFromHex(0x707070) forState:UIControlStateNormal];
        [_subBtn.layer setBorderColor:DSColorFromHex(0x707070).CGColor];
    }
    _count = [_countField.text integerValue];
    
}
-(void)pressSubBtn{
    NSInteger count = [_countField.text integerValue];
    
    if (count ==1) {
        [_subBtn setTitleColor:DSColorFromHex(0xB4B4B4) forState:UIControlStateNormal];
        [_subBtn.layer setBorderColor:DSColorFromHex(0xB4B4B4).CGColor];
        
    }else{
        count = count-1;
        _countField.text = [NSString stringWithFormat:@"%ld",(long)count];
        if (count ==1) {
            [_subBtn setTitleColor:DSColorFromHex(0xB4B4B4) forState:UIControlStateNormal];
            [_subBtn.layer setBorderColor:DSColorFromHex(0xB4B4B4).CGColor];
        }
    }
    _count = [_countField.text integerValue];
    
}
-(void)pressSubmit{
    self.submitBlock([_countField.text integerValue],_index,_type);
}
-(void)pressTap{
    self.tapBlock();
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    _count = [textField.text integerValue];
    
    return [textField resignFirstResponder];
}
-(void)setType:(NSInteger)type{
    _type = type;
}
-(void)setModel:(GoodDetailRes *)model{
    _model = model;
    NSString *url = [NSString stringWithFormat:@"%@%@",IMAGEHOST,model.productImagePath];
    [self.headImage sd_setImageWithURL:[NSURL URLWithString:url]];
    
    //间距
    CGFloat padding = 10;
    
    CGFloat titBtnX = 15;
    CGFloat titBtnY = self.headImage.ctBottom+25;
    CGFloat titBtnH = 30;
    for (int i = 0; i<_model.productSkuList.count; i++) {
        ProductSkuModel *skumodel = _model.productSkuList[i];
        UIButton *titBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        //设置按钮的样式
        [titBtn.layer setBorderColor:DSColorFromHex(0xB4B4B4).CGColor];
        [titBtn.layer setBorderWidth:0.5];
        [titBtn setTitleColor:DSColorFromHex(0xB4B4B4) forState:UIControlStateNormal];
        [titBtn setTitleColor:DSColorFromHex(0xFF4C4D) forState:UIControlStateSelected];
        [titBtn.layer setCornerRadius:4];
        [titBtn.layer setMasksToBounds:YES];
        titBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [titBtn setTitle:skumodel.productSkuUnit forState:UIControlStateNormal];
        titBtn.tag = 1000+i;
        [titBtn addTarget:self action:@selector(titBtnClike:) forControlEvents:UIControlEventTouchUpInside];
        if (i==0) {
            titBtn.selected = YES;
            _tmpBtn = titBtn;
            [titBtn.layer setBorderColor:DSColorFromHex(0xFF4C4D).CGColor];
            self.nameLabel.text = skumodel.productSkuName;
            self.priceLabel.text = [NSString stringWithFormat:@"￥%@",skumodel.productSkuPrice];
        }
        //计算文字大小
        CGSize titleSize = [skumodel.productSkuUnit boundingRectWithSize:CGSizeMake(MAXFLOAT, titBtnH) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:titBtn.titleLabel.font} context:nil].size;
        CGFloat titBtnW = titleSize.width + 2 * padding;
        //判断按钮是否超过屏幕的宽
        if ((titBtnX + titBtnW) > SCREENWIDTH-15) {
            titBtnX = 15;
            titBtnY += titBtnH + padding;
        }
        //设置按钮的位置
        titBtn.frame = CGRectMake(titBtnX, titBtnY, titBtnW, titBtnH);
        
        titBtnX += titBtnW + padding;
        
        [self.BGview addSubview:titBtn];
    }
    self.yinBGview.frame = CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT-300+49-_height+125-titBtnY);
    self.BGview.frame = CGRectMake(0, SCREENHEIGHT-300+49-_height+125-titBtnY, SCREENWIDTH, 300-49+_height-125+titBtnY);
}
-(void)titBtnClike:(UIButton*)sender{
    sender.selected = !sender.selected;
    _index = sender.tag-1000;
    ProductSkuModel *skumodel = _model.productSkuList[_index];
    self.nameLabel.text = skumodel.productSkuName;
    self.priceLabel.text = [NSString stringWithFormat:@"￥%@",skumodel.productSkuPrice];
    if (_tmpBtn == nil){
        sender.selected = YES;
        [sender.layer setBorderColor:DSColorFromHex(0xFF4C4D).CGColor];
        _tmpBtn = sender;
    }else if (_tmpBtn !=nil && _tmpBtn == sender){
        sender.selected = YES;
        [sender.layer setBorderColor:DSColorFromHex(0xFF4C4D).CGColor];
        
    }else if (_tmpBtn!= sender && _tmpBtn!=nil){
        _tmpBtn.selected = NO;
        [_tmpBtn.layer setBorderColor:DSColorFromHex(0xB4B4B4).CGColor];
        sender.selected = YES;
        
        [sender.layer setBorderColor:DSColorFromHex(0xFF4C4D).CGColor];
        _tmpBtn = sender;
    }
}
@end
