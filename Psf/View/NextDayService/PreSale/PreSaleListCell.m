//
//  PreSaleListCell.m
//  Psf
//
//  Created by 燕来秋mac9 on 2018/7/31.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "PreSaleListCell.h"

@implementation PreSaleListCell

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
    [self addSubview:self.progress];
    [self addSubview:self.groupLabel];
    [self addSubview:self.priceLabel];
    [self addSubview:self.progressLabel];
    [self addSubview:self.addBtn];
    [self addSubview:self.weightLabel];
    [self.headImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(120);
        make.top.equalTo(self).offset(15);
        make.left.equalTo(self).offset(14);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(15);
        make.left.equalTo(self.headImage.mas_right).offset(14);
        make.right.equalTo(self).offset(-17);
    }];
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(5);
        make.left.equalTo(self.headImage.mas_right).offset(14);
        
    }];
    [self.progress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headImage.mas_right).offset(14);
        make.height.mas_equalTo(18);
        make.width.mas_equalTo(150);
        make.top.equalTo(self.priceLabel.mas_bottom).offset(10);
    }];
    [self.progressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.progress.mas_right).offset(10);
        make.height.mas_equalTo(18);
        make.top.equalTo(self.priceLabel.mas_bottom).offset(10);
    }];
        [self.groupLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.progress.mas_bottom).offset(9);
            make.left.equalTo(self.headImage.mas_right).offset(14);
        }];
    [self.weightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.groupLabel.mas_bottom).offset(9);
        make.left.equalTo(self.headImage.mas_right).offset(14);
    }];
    [self.addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.headImage.mas_bottom).offset(-6);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(26);
        make.right.equalTo(self).offset(-15);
    }];
//    [self.lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.headImage.mas_right).offset(17);
//        make.centerY.equalTo(self.groupLabel);
//        make.width.mas_equalTo(self.groupLabel.mas_width);
//        make.height.mas_equalTo(1);
//    }];
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
        _titleLabel.font = [UIFont systemFontOfSize:16];
        _titleLabel.textColor = DSColorFromHex(0x454545);
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
        _groupLabel.textColor = DSColorFromHex(0x464646);
        _groupLabel.textAlignment = NSTextAlignmentLeft;
        
    }
    return _groupLabel;
}
-(UILabel *)priceLabel{
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc]init];
        _priceLabel.font = [UIFont fontWithName:@"PingFang-SC-Bold" size:18];
        _priceLabel.textColor = DSColorFromHex(0xFF4C4D);
        _priceLabel.textAlignment = NSTextAlignmentLeft;
        _priceLabel.text = @"";
    }
    return _priceLabel;
}
-(UILabel *)weightLabel{
    if (!_weightLabel) {
        _weightLabel = [[UILabel alloc]init];
        _weightLabel.font = [UIFont systemFontOfSize:12];
        _weightLabel.textColor = DSColorFromHex(0xFF4C4D);
        _weightLabel.textAlignment = NSTextAlignmentLeft;
        _weightLabel.backgroundColor = DSColorFromHex(0xFFEEEE);
        _weightLabel.text = @"";
    }
    return _weightLabel;
}

-(UILabel *)progressLabel{
    if (!_progressLabel) {
        _progressLabel = [[UILabel alloc]init];
        _progressLabel.font = [UIFont systemFontOfSize:12];
        _progressLabel.textColor = DSColorFromHex(0xFF4C4D);
        _progressLabel.textAlignment = NSTextAlignmentLeft;
        
        _progressLabel.text = @"";
    }
    return _progressLabel;
}
-(UIButton *)addBtn{
    if (!_addBtn) {
        _addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_addBtn setTitle:@"预购商品" forState:UIControlStateNormal];
        [_addBtn setTitleColor:DSColorFromHex(0xFF4C4D) forState:UIControlStateNormal];
        _addBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [_addBtn.layer setCornerRadius:2];
        [_addBtn.layer setMasksToBounds:YES];
        [_addBtn.layer setBorderColor:DSColorFromHex(0xFF4C4D).CGColor];
        [_addBtn.layer setBorderWidth:0.5];
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
-(ZYProGressView *)progress{
    if (!_progress) {
      _progress =   [[ZYProGressView alloc]initWithFrame:CGRectMake(151 ,67.5, 150, 18)];
       _progress.percentView.hidden = YES;
      _progress.bottomColor = DSColorFromHex(0xE6E6E6);
      _progress.progressColor = DSColorFromHex(0xFF4C4D);
    }
    return _progress;
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
    NSString *url = [NSString stringWithFormat:@"%@%@",IMAGEHOST,model.productImagePath];
    [self.headImage sd_setImageWithURL:[NSURL URLWithString:url]];
    self.titleLabel.text = model.productName;
    self.detailLabel.text = model.productTitle;
    self.weightLabel.text = model.productUnit;
    self.priceLabel.text = [NSString stringWithFormat:@"￥%@",model.productPrice];
        _lineLabel.hidden = YES;

    NSString *ExpireTime = [NSDate cStringFromTimestamp:model.preSaleExpireTime Formatter:@"MM.dd"];
    NSString *DeliveryTime = [NSDate cStringFromTimestamp:model.preSaleDeliveryTime Formatter:@"MM.dd"];
    if (model.preSaleIsComplete==NO) {
        self.weightLabel.text =[NSString stringWithFormat:@"%@截单/%@送达",ExpireTime,DeliveryTime];
    }else{
        self.weightLabel.text =[NSString stringWithFormat:@"已经截单/%@送达",DeliveryTime];
        self.weightLabel.backgroundColor = [UIColor whiteColor];
        self.weightLabel.textColor = DSColorFromHex(0x72BF34);
        [_addBtn.layer setBorderColor:DSColorFromHex(0xB5B5B5).CGColor];
        [_addBtn.layer setBorderWidth:0.5];
        [_addBtn setTitle:@"查看商品" forState:UIControlStateNormal];
        [_addBtn setTitleColor:DSColorFromHex(0x464646) forState:UIControlStateNormal];
    }
    
    self.groupLabel.text = [NSString stringWithFormat:@"已有%ld人购买",model.preSaleQuantity];
    CGFloat progress = (CGFloat)model.preSaleQuantity/model.preSaleLimitQuantity;
    if (model.preSaleLimitQuantity ==0) {
        progress = 0.99;
    }
    _progress.progressValue = [NSString stringWithFormat:@"%.2f",progress];
    _progressLabel.text = [NSString stringWithFormat:@"%.0f%%",progress*100];
}
@end
