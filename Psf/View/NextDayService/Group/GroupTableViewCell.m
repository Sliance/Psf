//
//  GroupTableViewCell.m
//  Psf
//
//  Created by 燕来秋mac9 on 2018/7/2.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "GroupTableViewCell.h"

@implementation GroupTableViewCell

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
    [self addSubview:self.titleLabel];
    [self addSubview:self.detailLabel];
    [self addSubview:self.groupLabel];
    [self addSubview:self.priceLabel];
    [self addSubview:self.addBtn];
    [self addSubview:self.lineLabel];
    [self.headImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(120);
        make.top.equalTo(self).offset(17);
        make.left.equalTo(self).offset(16);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(30);
        make.left.equalTo(self.headImage.mas_right).offset(17);
        make.right.equalTo(self).offset(-17);
    }];
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(10);
        make.left.equalTo(self.headImage.mas_right).offset(17);
        make.right.equalTo(self).offset(-17);
    }];
    [self.groupLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.detailLabel.mas_bottom).offset(10);
        make.left.equalTo(self.headImage.mas_right).offset(17);
    }];
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.groupLabel.mas_bottom).offset(10);
        make.left.equalTo(self.headImage.mas_right).offset(17);
        make.right.equalTo(self).offset(-50);
    }];
    [self.addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.headImage.mas_bottom).offset(-6);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(30);
        make.right.equalTo(self).offset(-16);
    }];
    [self.lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headImage.mas_right).offset(17);
        make.centerY.equalTo(self.groupLabel);
        make.width.mas_equalTo(self.groupLabel.mas_width);
        make.height.mas_equalTo(1);
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
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = [UIFont systemFontOfSize:15];
        _titleLabel.textColor = DSColorFromHex(0x464646);
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.text = @"山东烟台红富士苹果";
    }
    return _titleLabel;
}
-(UILabel *)detailLabel{
    if (!_detailLabel) {
        _detailLabel = [[UILabel alloc]init];
        _detailLabel.font = [UIFont systemFontOfSize:12];
        _detailLabel.textColor = DSColorFromHex(0x777777);
        _detailLabel.textAlignment = NSTextAlignmentLeft;
        _detailLabel.text = @"酥脆多汁，香甜可口";
    }
    return _detailLabel;
}
-(UILabel *)groupLabel{
    if (!_groupLabel) {
        _groupLabel = [[UILabel alloc]init];
        _groupLabel.font = [UIFont systemFontOfSize:12];
        _groupLabel.textColor = DSColorFromHex(0xB4B4B4);
        _groupLabel.textAlignment = NSTextAlignmentCenter;
    
    }
    return _groupLabel;
}
-(UILabel *)priceLabel{
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc]init];
        _priceLabel.font = [UIFont systemFontOfSize:15];
        _priceLabel.textColor = DSColorFromHex(0xFF4C4D);
        _priceLabel.textAlignment = NSTextAlignmentLeft;
        _priceLabel.text = @"¥ 29.8/4个";
    }
    return _priceLabel;
}
-(UIButton *)addBtn{
    if (!_addBtn) {
        _addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _addBtn.backgroundColor = DSColorFromHex(0xFF4C4D);
        [_addBtn setTitle:@"去开团" forState:UIControlStateNormal];
        [_addBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _addBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_addBtn.layer setCornerRadius:2];
        [_addBtn.layer setMasksToBounds:YES];
        [_addBtn addTarget:self action:@selector(pressAddBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addBtn;
}
-(UILabel *)lineLabel{
    if (!_lineLabel) {
        _lineLabel = [[UILabel alloc]init];
        _lineLabel.backgroundColor = DSColorFromHex(0xB4B4B4);
    }
    return _lineLabel;
}
-(void)setIndex:(NSInteger)index{
    _index = index;
    _addBtn.tag = index;
}
-(void)pressAddBtn:(UIButton*)sender{
    self.pressAddBlock(sender.tag);
}
-(void)setModel:(GroupListRes *)model{
    _model = model;
    NSString *url = [NSString stringWithFormat:@"%@%@",DPHOST,model.productImagePath];
    [self.headImage sd_setImageWithURL:[NSURL URLWithString:url]];
    self.titleLabel.text = model.productName;
    self.detailLabel.text = model.productTitle;
    self.priceLabel.text = [NSString stringWithFormat:@"￥%@/%@",model.grouponPrice,model.productUnit];
    self.groupLabel.text = [NSString stringWithFormat:@"单买价¥%@",model.productPrice];
}
@end
