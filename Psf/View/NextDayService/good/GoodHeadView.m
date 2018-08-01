//
//  GoodHeadView.m
//  Psf
//
//  Created by 燕来秋mac9 on 2018/6/29.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "GoodHeadView.h"

@implementation GoodHeadView
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}
-(void)setCornerLayoutNormal{
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.nameLabel];
    [self addSubview:self.contentLabel];
    [self addSubview:self.priceLabel];
    [self addSubview:self.weightLabel];
    [self addSubview:self.soldLabel];
    [self addSubview:self.shareBtn];
    self.nameLabel.frame = CGRectMake(15, 15, SCREENWIDTH-50, 17);
    self.contentLabel.frame = CGRectMake(15, self.nameLabel.ctBottom+11, SCREENWIDTH-30, 15);
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15);
        make.top.equalTo(self.contentLabel.mas_bottom).offset(15);
    }];
    
    [self.weightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.priceLabel.mas_right);
        make.bottom.equalTo(self.priceLabel.mas_bottom);
    }];
    
    self.shareBtn.frame = CGRectMake(SCREENWIDTH-32, 15, 17, 17);
    self.soldLabel.frame = CGRectMake(SCREENWIDTH-15-100, self.shareBtn.ctBottom+49, 100, 21);
    
    self.priceLabel.textColor = DSColorFromHex(0xFF4C4D);
    self.weightLabel.textColor =  DSColorFromHex(0xFF4C4D);
}
-(void)setCornerLayoutGroup{
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.groupView];
    [self.groupView addSubview:self.groupLabel];
    [self.groupView addSubview:self.dateLabel];
    [self addSubview:self.nameLabel];
    [self addSubview:self.contentLabel];
    [self.groupView addSubview:self.priceLabel];
    [self.groupView addSubview:self.weightLabel];
    [self.groupView addSubview:self.groupLabel];
    [self.groupView addSubview:self.priceLabel];
    [self.groupView addSubview:self.originLabel];
    [self.originLabel addSubview:self.lineLabel];
    [self addSubview:self.soldLabel];
    [self addSubview:self.shareBtn];
    self.groupView.frame = CGRectMake(0, 0, SCREENWIDTH, 50);
    self.nameLabel.frame = CGRectMake(15, 15+self.groupView.ctBottom, SCREENWIDTH-50, 17);
    self.contentLabel.frame = CGRectMake(15, self.nameLabel.ctBottom+11, SCREENWIDTH-30, 15);
    self.shareBtn.frame = CGRectMake(SCREENWIDTH-32, 15+self.groupView.ctBottom, 17, 17);
    self.soldLabel.hidden = YES;
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.groupView).offset(15);
    }];
    [self.weightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.priceLabel.mas_right);
        make.bottom.equalTo(self.priceLabel.mas_bottom);
    }];
    [self.originLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.weightLabel.mas_right);
        make.bottom.equalTo(self.priceLabel.mas_bottom);
    }];
    [self.lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.originLabel.mas_left);
        make.width.mas_equalTo(self.originLabel.mas_width);
        make.height.mas_equalTo(1);
        make.centerY.equalTo(self.originLabel);
    }];
     [self.groupLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.groupView).offset(7);
        make.right.equalTo(self.groupView).offset(-15);
        
    }];
    [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.groupLabel.mas_bottom).offset(5);
        make.right.equalTo(self.groupView).offset(-15);
        
    }];
    _priceLabel.textColor = [UIColor whiteColor];
    _weightLabel.textColor =  [UIColor whiteColor];
}
-(void)setLauoutPreSale{
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.nameLabel];
    [self addSubview:self.shareBtn];
    [self addSubview:self.buyerLabel];
    [self addSubview:self.progress];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15);
        make.top.equalTo(self).offset(13);
        make.width.mas_equalTo(SCREENWIDTH-50);
    }];
    [self.shareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-15);
        make.top.equalTo(self).offset(11);
        make.width.height.mas_equalTo(21);
    }];
    [self.buyerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15);
        make.top.equalTo(self.nameLabel.mas_bottom).offset(13);
        make.width.mas_equalTo(SCREENWIDTH-30);
    }];
    [self.progress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15);
        make.top.equalTo(self.buyerLabel.mas_bottom).offset(20);
        make.width.mas_equalTo(SCREENWIDTH-30);
    }];
}
-(UIButton *)shareBtn{
    if (!_shareBtn) {
        _shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_shareBtn setImage:[UIImage imageNamed:@"shop_share"] forState:UIControlStateNormal];
        [_shareBtn addTarget:self action:@selector(pressShareBtn:) forControlEvents:UIControlEventTouchUpInside];
        _shareBtn.frame = CGRectMake(0, 20, 40, 40);
    }
    return _shareBtn;
}
-(UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        _nameLabel.font = [UIFont fontWithName:@"PingFang-SC-Bold" size:18];
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
        _contentLabel.textColor = DSColorFromHex(0x777777);
        _contentLabel.text = @"";
    }
    return _contentLabel;
}
-(UILabel *)buyerLabel{
    if (!_buyerLabel) {
        _buyerLabel = [[UILabel alloc]init];
        _buyerLabel.textAlignment = NSTextAlignmentLeft;
        _buyerLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:15];
        _buyerLabel.textColor = DSColorFromHex(0x787878);
        _buyerLabel.text = @"";
    }
    return _buyerLabel;
}
-(UILabel *)priceLabel{
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc]init];
        _priceLabel.textAlignment = NSTextAlignmentLeft;
        _priceLabel.font = [UIFont systemFontOfSize:24];
        
        _priceLabel.text = @"";
    }
    return _priceLabel;
}
-(UILabel *)weightLabel{
    if (!_weightLabel) {
        _weightLabel = [[UILabel alloc]init];
        _weightLabel.textAlignment = NSTextAlignmentLeft;
        _weightLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:15];
        
        _weightLabel.text = @"";
    }
    return _weightLabel;
}
-(UILabel *)soldLabel{
    if (!_soldLabel) {
        _soldLabel = [[UILabel alloc]init];
        _soldLabel.textAlignment = NSTextAlignmentRight;
        _soldLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:12];
        _soldLabel.textColor = DSColorFromHex(0xB5B5B5);
        _soldLabel.text = @"";
    }
    return _soldLabel;
}
-(UILabel *)groupLabel{
    if (!_groupLabel) {
        _groupLabel = [[UILabel alloc]init];
        _groupLabel.textAlignment = NSTextAlignmentRight;
        _groupLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:10];
        _groupLabel.textColor = [UIColor whiteColor];
    }
    return _groupLabel;
}
-(UILabel *)dateLabel{
    if (!_dateLabel) {
        _dateLabel = [[UILabel alloc]init];
        _dateLabel.textAlignment = NSTextAlignmentRight;
        _dateLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:15];
        _dateLabel.textColor = [UIColor whiteColor];
        _dateLabel.text = @"10天05:17:22";
    }
    return _dateLabel;
}
-(UIView *)groupView{
    if (!_groupView) {
        _groupView = [[UIView alloc]init];
        _groupView.backgroundColor = DSColorFromHex(0xFFC05C);
    }
    return _groupView;
}
-(UILabel *)originLabel{
    if (!_originLabel) {
        _originLabel = [[UILabel alloc]init];
        _originLabel.textAlignment = NSTextAlignmentLeft;
        _originLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:15];
        _originLabel.textColor = [UIColor whiteColor];
        _originLabel.hidden = YES;
    }
    return _originLabel;
}
-(UILabel *)lineLabel{
    if (!_lineLabel) {
        _lineLabel = [[UILabel alloc]init];
        _lineLabel.backgroundColor = [UIColor whiteColor];
    }
    return _lineLabel;
}
-(ZYProGressView *)progress{
    if (!_progress) {
        _progress =   [[ZYProGressView alloc]initWithFrame:CGRectMake(151 ,67.5, SCREENWIDTH-30, 14)];
        _progress.bottomColor = DSColorFromHex(0xE6E6E6);
        _progress.progressColor = DSColorFromHex(0xFF4C4D);
    }
    return _progress;
}
-(void)setModel:(GoodDetailRes *)model{
    _model = model;
    
    
    if([model.productType isEqualToString:@"normal"]){//正常
        [self setCornerLayoutNormal];
        _priceLabel.text = [NSString stringWithFormat:@"￥%@/",model.productPrice];
    }else if ([model.productType isEqualToString:@"groupon"]){//团购
         self.groupLabel.text = @"距离拼团结束还剩:";
        self.originLabel.hidden = NO;
        self.lineLabel.hidden = NO;
        [self setCornerLayoutGroup];
        self.originLabel.text = [NSString stringWithFormat:@"￥%@",model.productPrice];
        _priceLabel.text = [NSString stringWithFormat:@"￥%@/",model.grouponPrice];
    }else if ([model.productType isEqualToString:@"preSale"]){//预售
        
        [self setLauoutPreSale];
      _priceLabel.text = [NSString stringWithFormat:@"￥%@/",model.productPrice];
    }else if ([model.productType isEqualToString:@"reward"]){//满减
       [self setCornerLayoutNormal];
    }
    _nameLabel.text = model.productName;
    _contentLabel.text = model.productTitle;
    _weightLabel.text = model.productUnit;
    _soldLabel.text = [NSString stringWithFormat:@"已售%ld",model.productSaleCount];
    _buyerLabel.text = @"已有23人购买";
    CGFloat progress = (CGFloat)model.preSaleQuantity/model.preSaleLimitQuantity;
    _progress.progressValue = [NSString stringWithFormat:@"%.2f",progress];
}
@end
