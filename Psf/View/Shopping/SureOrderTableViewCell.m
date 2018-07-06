//
//  SureOrderTableViewCell.m
//  Psf
//
//  Created by 燕来秋mac9 on 2018/7/4.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "SureOrderTableViewCell.h"

@implementation SureOrderTableViewCell

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
    [self addSubview:self.headImage];
    [self addSubview:self.nameLabel];
    [self addSubview:self.countLabel];
    [self addSubview:self.weightLabel];
    [self addSubview:self.priceLabel];
    [self addSubview:self.addBtn];
    [self addSubview:self.subBtn];
    [self addSubview:self.countField];
    [self addSubview:self.lineLabel];
    
   
    [self.headImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(90);
        make.centerY.equalTo(self);
        make.left.equalTo(self).offset(15);
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headImage.mas_top);
        make.left.equalTo(self.headImage.mas_right).offset(11);
        make.right.equalTo(self).offset(-15);
    }];
    [self.countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameLabel.mas_bottom).offset(10);
        make.left.equalTo(self.headImage.mas_right).offset(11);
    }];
    [self.weightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameLabel.mas_bottom).offset(10);
        make.left.equalTo(self.countLabel.mas_right).offset(5);
    }];
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self).offset(-22);
        make.left.equalTo(self.headImage.mas_right).offset(11);
    }];
    [self.addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-15);
        make.bottom.equalTo(self).offset(-22);
        make.height.mas_equalTo(26);
        make.width.mas_equalTo(36);
    }];
    [self.subBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-84);
        make.bottom.equalTo(self).offset(-22);
        make.height.mas_equalTo(26);
        make.width.mas_equalTo(36);
    }];
    [self.countField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-50);
        make.bottom.equalTo(self).offset(-22);
        make.height.mas_equalTo(26);
        make.width.mas_equalTo(35);
    }];
    [self.lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headImage.mas_left);
        make.bottom.equalTo(self);
        make.right.equalTo(self);
        make.height.mas_equalTo(0.5);
    }];
    
}

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
        _nameLabel.textColor = [UIColor colorWithRed:70/255.0 green:70/255.0 blue:70/255.0 alpha:1];
        _nameLabel.text = @"澳洲牛腱子";
    }
    return _nameLabel;
}
-(UILabel *)priceLabel{
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc]init];
        _priceLabel.textAlignment = NSTextAlignmentLeft;
        _priceLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:15];
        _priceLabel.textColor = [UIColor colorWithRed:70/255.0 green:70/255.0 blue:70/255.0 alpha:1];
        _priceLabel.text = @"￥99.8";
    }
    return _priceLabel;
}
-(UILabel *)weightLabel{
    if (!_weightLabel) {
        _weightLabel = [[UILabel alloc]init];
        _weightLabel.textAlignment = NSTextAlignmentLeft;
        _weightLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:12];
        _weightLabel.textColor = [UIColor colorWithRed:120/255.0 green:120/255.0 blue:120/255.0 alpha:1];
        _weightLabel.text = @"1.2kg";
    }
    return _weightLabel;
}
-(UILabel *)countLabel{
    if (!_countLabel) {
        _countLabel = [[UILabel alloc]init];
        _countLabel.textAlignment = NSTextAlignmentLeft;
        _countLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:12];
        _countLabel.textColor = [UIColor colorWithRed:120/255.0 green:120/255.0 blue:120/255.0 alpha:1];
        _countLabel.text = @"6个";
    }
    return _countLabel;
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
        [_subBtn addTarget:self action:@selector(pressSubBtn:) forControlEvents:UIControlEventTouchUpInside];
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
        [_addBtn addTarget:self action:@selector(pressAddBtn:) forControlEvents:UIControlEventTouchUpInside];
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
        _countField.text = @"2";
    }
    return _countField;
}
-(UILabel *)lineLabel{
    if (!_lineLabel) {
        _lineLabel = [[UILabel alloc]init];
        _lineLabel.backgroundColor = DSColorFromHex(0xF0F0F0);
    }
    return _lineLabel;
}

-(void)pressAddBtn:(UIButton*)sender{
    NSInteger count = [_countField.text integerValue];
    count = count+1;
    _countField.text = [NSString stringWithFormat:@"%ld",(long)count];
    if (count>1) {
        [_subBtn setTitleColor:DSColorFromHex(0x707070) forState:UIControlStateNormal];
        [_subBtn.layer setBorderColor:DSColorFromHex(0x707070).CGColor];
    }
}
-(void)pressSubBtn:(UIButton*)sender{
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
}

@end
