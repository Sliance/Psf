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
   
    [self.countField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-20);
        make.centerY.equalTo(self);
        make.height.mas_equalTo(26);
        
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
        _nameLabel.textColor = [UIColor colorWithRed:70/255.0 green:70/255.0 blue:70/255.0 alpha:1];
        _nameLabel.text = @"";
    }
    return _nameLabel;
}
-(UILabel *)priceLabel{
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc]init];
        _priceLabel.textAlignment = NSTextAlignmentLeft;
        _priceLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:15];
        _priceLabel.textColor = [UIColor colorWithRed:70/255.0 green:70/255.0 blue:70/255.0 alpha:1];
        _priceLabel.text = @"";
    }
    return _priceLabel;
}
-(UILabel *)weightLabel{
    if (!_weightLabel) {
        _weightLabel = [[UILabel alloc]init];
        _weightLabel.textAlignment = NSTextAlignmentLeft;
        _weightLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:12];
        _weightLabel.textColor = [UIColor colorWithRed:120/255.0 green:120/255.0 blue:120/255.0 alpha:1];
        _weightLabel.text = @"";
    }
    return _weightLabel;
}
-(UILabel *)countLabel{
    if (!_countLabel) {
        _countLabel = [[UILabel alloc]init];
        _countLabel.textAlignment = NSTextAlignmentLeft;
        _countLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:12];
        _countLabel.textColor = [UIColor colorWithRed:120/255.0 green:120/255.0 blue:120/255.0 alpha:1];
        _countLabel.text = @"";
    }
    return _countLabel;
}

-(UILabel *)countField{
    if (!_countField) {
        _countField = [[UILabel alloc]init];
        _countField.textColor = DSColorFromHex(0x464646);
        _countField.font = [UIFont systemFontOfSize:15];
        _countField.textAlignment = NSTextAlignmentRight;
        
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


-(void)setModel:(GoodDetailRes *)model{
    _model = model;
    
}
-(void)setResmodel:(OrderListRes *)resmodel{
    _resmodel = resmodel;
    
}
-(void)setCarmodel:(CartProductModel *)carmodel{
    _carmodel = carmodel;
    NSString *url = [NSString stringWithFormat:@"%@%@",IMAGEHOST,carmodel.productImagePath];
    [self.headImage sd_setImageWithURL:[NSURL URLWithString:url]];
    self.nameLabel.text = carmodel.productName;
    self.weightLabel.text = carmodel.productUnit;
}
@end
