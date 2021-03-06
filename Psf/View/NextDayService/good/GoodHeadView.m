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
   
    self.shareBtn.frame = CGRectMake(SCREENWIDTH-32, 15+self.groupView.ctBottom, 17, 17);
    self.soldLabel.hidden = YES;
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.groupView).offset(10);
        make.top.equalTo(self.groupView);
        make.height.mas_equalTo(50);
    }];
    [self.weightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.priceLabel.mas_right);
        make.centerY.equalTo(self.priceLabel).offset(5);
    }];
    [self.originLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.weightLabel.mas_right);
        make.centerY.equalTo(self.weightLabel);
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
    [self addSubview:self.limitLabel];
    [self addSubview:self.arriveLabel];
    [self addSubview:self.remainLabel];
    [self addSubview:self.limitTitleLabel];
    [self addSubview:self.arriveTitleLabel];
    [self addSubview:self.remainTitleLabel];
    [self addSubview:self.priceLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15);
        make.top.equalTo(self).offset(10);
        make.width.mas_equalTo(SCREENWIDTH-50);
    }];
    [self.shareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-15);
        make.top.equalTo(self).offset(11);
        make.width.height.mas_equalTo(21);
    }];
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15);
        make.top.equalTo(self.nameLabel.mas_bottom).offset(14);
       
    }];
    [self.buyerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-15);
        make.top.equalTo(self.nameLabel.mas_bottom).offset(10);
        
    }];
    [self.progress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15);
        make.top.equalTo(self.buyerLabel.mas_bottom).offset(24);
        make.width.mas_equalTo(SCREENWIDTH-30);
    }];
    [self.limitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.bottom.equalTo(self).offset(-15);
        make.width.mas_equalTo(SCREENWIDTH/3);
    }];
    [self.limitTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.bottom.equalTo(self.limitLabel.mas_top).offset(-5);
        make.width.mas_equalTo(SCREENWIDTH/3);
    }];
    [self.arriveLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self).offset(-15);
        make.centerX.equalTo(self);
        make.width.mas_equalTo(SCREENWIDTH/3);
    }];
    [self.arriveTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.arriveLabel.mas_top).offset(-5);
        make.centerX.equalTo(self);
        make.width.mas_equalTo(SCREENWIDTH/3);
    }];
    [self.remainLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self);
        make.bottom.equalTo(self).offset(-15);
        make.width.mas_equalTo(SCREENWIDTH/3);
    }];
    [self.remainTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self);
        make.bottom.equalTo(self.remainLabel.mas_top).offset(-5);
        make.width.mas_equalTo(SCREENWIDTH/3);
    }];
}
-(UIButton *)shareBtn{
    if (!_shareBtn) {
        _shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_shareBtn setImage:[UIImage imageNamed:@"shop_share"] forState:UIControlStateNormal];
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
        _buyerLabel.textAlignment = NSTextAlignmentRight;
        _buyerLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:12];
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
        _dateLabel.text = @"";
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
-(UILabel *)limitLabel{
    if (!_limitLabel) {
        _limitLabel  = [[UILabel alloc]init];
        _limitLabel.text = @"购买上限";
        _limitLabel.textColor = DSColorFromHex(0x979797);
        _limitLabel.font = [UIFont systemFontOfSize:12];
        _limitLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _limitLabel;
}
-(UILabel *)arriveLabel{
    if (!_arriveLabel) {
        _arriveLabel  = [[UILabel alloc]init];
        _arriveLabel.text = @"到货时间";
        _arriveLabel.textColor = DSColorFromHex(0x979797);
        _arriveLabel.font = [UIFont systemFontOfSize:12];
        _arriveLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _arriveLabel;
}
-(UILabel *)remainLabel{
    if (!_remainLabel) {
        _remainLabel  = [[UILabel alloc]init];
        _remainLabel.text = @"剩余时间";
        _remainLabel.textColor = DSColorFromHex(0x979797);
        _remainLabel.font = [UIFont systemFontOfSize:12];
        _remainLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _remainLabel;
}
-(UILabel *)limitTitleLabel{
    if (!_limitTitleLabel) {
        _limitTitleLabel  = [[UILabel alloc]init];
        _limitTitleLabel.textColor = DSColorFromHex(0x474747);
        _limitTitleLabel.font = [UIFont systemFontOfSize:15];
        _limitTitleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _limitTitleLabel;
}
-(UILabel *)arriveTitleLabel{
    if (!_arriveTitleLabel) {
        _arriveTitleLabel  = [[UILabel alloc]init];
        _arriveTitleLabel.textColor = DSColorFromHex(0x474747);
        _arriveTitleLabel.font = [UIFont systemFontOfSize:15];
        _arriveTitleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _arriveTitleLabel;
}
-(UILabel *)remainTitleLabel{
    if (!_remainTitleLabel) {
        _remainTitleLabel  = [[UILabel alloc]init];
        _remainTitleLabel.textColor = DSColorFromHex(0x474747);
        _remainTitleLabel.font = [UIFont systemFontOfSize:15];
        _remainTitleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _remainTitleLabel;
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
        self.dateLabel.text = [NSDate getCountDownStringWithEndTime:[NSDate cStringFromTimestamp:_model.grouponExpireTime Formatter:@"yyyy-MM-dd HH:mm:ss.0"]];
        NSTimer *timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(groupTime) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
        
        [timer setFireDate:[NSDate distantPast]];
    }else if ([model.productType isEqualToString:@"preSale"]){//预售
        
        [self setLauoutPreSale];
      _priceLabel.text = [NSString stringWithFormat:@"￥%@",model.productPrice];
        self.priceLabel.textColor = DSColorFromHex(0xFF4C4D);
        self.priceLabel.font = [UIFont systemFontOfSize:19];
        _buyerLabel.text = @"已有人购买";
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"已有%ld人购买",model.preSaleQuantity]];
        [str addAttribute:NSForegroundColorAttributeName value:DSColorFromHex(0xFF4C4D) range:NSMakeRange(2,[NSString stringWithFormat:@"%ld",model.preSaleQuantity].length)];
        [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(2,[NSString stringWithFormat:@"%ld",model.preSaleQuantity].length)];
        _buyerLabel.attributedText = str;
        CGFloat progress = (CGFloat)model.preSaleQuantity/model.preSaleLimitQuantity;
        if (model.preSaleLimitQuantity ==0) {
            progress = 0.99;
        }
        _progress.progressValue = [NSString stringWithFormat:@"%.2f",progress];
        self.limitTitleLabel.text = [NSString stringWithFormat:@"%ld",model.preSaleLimitQuantity];
        self.arriveTitleLabel.text = [NSDate cStringFromTimestamp:model.preSaleDeliveryTime Formatter:@"MM.dd"];
        if (model.preSaleIsComplete ==YES) {
            self.remainTitleLabel.text = @"已截单";
        }else{
            self.remainTitleLabel.text = [NSDate getCountDownStringWithEndTime:[NSDate cStringFromTimestamp:_model.preSaleExpireTime Formatter:@"yyyy-MM-dd HH:mm:ss.0"]];
            NSTimer *timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
            [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
            
            [timer setFireDate:[NSDate distantPast]];
        }
    }else if ([model.productType isEqualToString:@"reward"]){//满减
       [self setCornerLayoutNormal];
    }
    _nameLabel.text = model.productName;
    _contentLabel.text = model.productTitle;
    _weightLabel.text = model.productUnit;
    _soldLabel.text = [NSString stringWithFormat:@"已售%ld",model.productSaleCount];
    
    
    
}
-(void)groupTime{
    self.dateLabel.text = [NSDate getCountDownStringWithEndTime:[NSDate cStringFromTimestamp:_model.grouponExpireTime Formatter:@"yyyy-MM-dd HH:mm:ss.0"]];
}
-(void)timerAction{
    self.remainTitleLabel.text = [NSDate getCountDownStringWithEndTime:[NSDate cStringFromTimestamp:_model.preSaleExpireTime Formatter:@"yyyy-MM-dd HH:mm:ss.0"]];
}
@end
