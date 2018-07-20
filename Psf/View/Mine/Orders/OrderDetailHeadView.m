//
//  OrderDetailHeadView.m
//  Psf
//
//  Created by 燕来秋mac9 on 2018/6/28.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "OrderDetailHeadView.h"

@implementation OrderDetailHeadView
-(UIView *)headView{
    if (!_headView) {
        _headView = [[UIView alloc]init];
        _headView.backgroundColor = [UIColor whiteColor];
    }
    return _headView;
}
-(UIView *)footView{
    if (!_footView) {
        _footView = [[UIView alloc]init];
        _footView.backgroundColor = [UIColor whiteColor];
    }
    return _footView;
}
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = [UIFont systemFontOfSize:14];
        _titleLabel.textColor = DSColorFromHex(0x454545);
        _titleLabel.textAlignment = NSTextAlignmentLeft;
//        _titleLabel.text = @"张某某";
    }
    return _titleLabel;
}
-(UILabel *)typeLabel{
    if (!_typeLabel) {
        _typeLabel = [[UILabel alloc]init];
        _typeLabel.font = [UIFont systemFontOfSize:14];
        _typeLabel.textColor = DSColorFromHex(0x464646);
        _typeLabel.textAlignment = NSTextAlignmentLeft;
        _typeLabel.text = @"次日达";
    }
    return _typeLabel;
}
-(UILabel *)dateLabel{
    if (!_dateLabel) {
        _dateLabel = [[UILabel alloc]init];
        _dateLabel.font = [UIFont systemFontOfSize:12];
        _dateLabel.textColor = DSColorFromHex(0xFF4C4D);
        _dateLabel.textAlignment = NSTextAlignmentRight;
        _dateLabel.text = @"";
    }
    return _dateLabel;
}
-(UILabel *)detailLabel{
    if (!_detailLabel) {
        _detailLabel = [[UILabel alloc]init];
        _detailLabel.font = [UIFont systemFontOfSize:12];
        _detailLabel.textColor = DSColorFromHex(0x797979);
        _detailLabel.textAlignment = NSTextAlignmentLeft;
//        _detailLabel.text = @"闵行区旭辉·浦江国际 37号";
    }
    return _detailLabel;
}
-(UILabel *)phoneLabel{
    if (!_phoneLabel) {
        _phoneLabel = [[UILabel alloc]init];
        _phoneLabel.font = [UIFont systemFontOfSize:14];
        _phoneLabel.textColor = DSColorFromHex(0x474747);
        _phoneLabel.textAlignment = NSTextAlignmentLeft;
//        _phoneLabel.text = @"135****4347";
    }
    return _phoneLabel;
}
-(UILabel *)morenLabel{
    if (!_morenLabel) {
        _morenLabel = [[UILabel alloc]init];
        _morenLabel.font = [UIFont systemFontOfSize:11];
        _morenLabel.textColor = [UIColor whiteColor];
        _morenLabel.backgroundColor = DSColorFromHex(0xFF4C4D);
        _morenLabel.textAlignment = NSTextAlignmentCenter;
        _morenLabel.text = @"默认";
        _morenLabel.hidden = YES;
    }
    return _morenLabel;
}
-(UIImageView *)lineImage{
    if (!_lineImage) {
        _lineImage = [[UIImageView alloc]init];
        _lineImage.image = [UIImage imageNamed:@"address_bg"];
    }
    return _lineImage;
}
-(UILabel *)lineLabel{
    if (!_lineLabel) {
        _lineLabel = [[UILabel alloc]init];
        _lineLabel.backgroundColor = DSColorFromHex(0xFF4C4D);
    }
    return _lineLabel;
}
-(UIButton *)rightTBtn{
    if (!_rightTBtn) {
        _rightTBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_rightTBtn setImage:[UIImage imageNamed:@"icon_right"] forState:UIControlStateNormal];
        [_rightTBtn addTarget:self action:@selector(pressEditBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightTBtn;
}
-(UIButton *)rightBBtn{
    if (!_rightBBtn) {
        _rightBBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_rightBBtn setImage:[UIImage imageNamed:@"icon_right"] forState:UIControlStateNormal];
        [_rightBBtn addTarget:self action:@selector(pressEditBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightBBtn;
}
-(UILabel *)ciriLabel{
    if (!_ciriLabel) {
        _ciriLabel = [[UILabel alloc]init];
        _ciriLabel.backgroundColor = DSColorFromHex(0xFFF4DA);
        _ciriLabel.textAlignment = NSTextAlignmentCenter;
        _ciriLabel.text = @"次日达需要在每日22:00前下单";
        _ciriLabel.textColor = DSColorFromHex(0xF29629);
        _ciriLabel.font = [UIFont systemFontOfSize:14];
    }
    return _ciriLabel;
}
-(UILabel *)centerLabel{
    if (!_centerLabel) {
        _centerLabel = [[UILabel alloc]init];
        _centerLabel.font = [UIFont systemFontOfSize:14];
        _centerLabel.textColor = DSColorFromHex(0x454545);
        _centerLabel.textAlignment = NSTextAlignmentLeft;
        _centerLabel.text = @"请填写收货地址";
        _centerLabel.hidden = YES;
    }
    return _centerLabel;
}
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = DSColorFromHex(0xF0F0F0);
        [self addSubview:self.headView];
        [self addSubview:self.ciriLabel];
        [self addSubview:self.footView];
        
        [self.headView addSubview:self.titleLabel];
        [self.headView addSubview:self.detailLabel];
        [self.headView addSubview:self.morenLabel];
        [self.headView addSubview:self.phoneLabel];
        [self.footView addSubview:self.rightBBtn];
        [self.headView addSubview:self.rightTBtn];
        [self.footView addSubview:self.lineLabel];
        [self.headView addSubview:self.lineImage];
        [self.footView addSubview:self.typeLabel];
        [self.footView addSubview:self.dateLabel];
        [self.headView addSubview:self.centerLabel];
        self.headView.frame = CGRectMake(0, 0, SCREENWIDTH, 75);
        self.centerLabel.frame =CGRectMake(15, 0, SCREENWIDTH, 75);
        self.titleLabel.frame = CGRectMake(15, 15, 60, 14);
        self.phoneLabel.frame = CGRectMake(15+self.titleLabel.ctRight, 15, SCREENWIDTH-90, 14);
        self.morenLabel.frame = CGRectMake(15, 7+self.titleLabel.ctBottom, 34, 16);
        self.detailLabel.frame = CGRectMake(15+self.titleLabel.ctRight, 10+self.titleLabel.ctBottom, SCREENWIDTH-90, 12);
        self.lineImage.frame = CGRectMake(0, 70, SCREENWIDTH, 5);
        self.rightTBtn.frame = CGRectMake(SCREENWIDTH-22, 30, 7, 12);
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pressTap:)];
        [self.headView addGestureRecognizer:tap];
        UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pressfootTap:)];
        [self.footView addGestureRecognizer:tap1];
    }
    return self;
}
-(void)pressTap:(UITapGestureRecognizer*)tap{
    self.addressBlock(_goodtype);
}
-(void)pressfootTap:(UITapGestureRecognizer*)tap{
    self.dateBlock(0);
}
-(void)setGoodtype:(CLAIMGOODSTYPE)goodtype{
    if (goodtype == CLAIMGOODSTYPEVISIT) {
            self.ciriLabel.frame = CGRectMake(0, self.headView.ctBottom, SCREENWIDTH, 40);
       [self setCornerLayout];
        [self setdate];
        self.typeLabel.text = @"次日达";
    }else if(goodtype == CLAIMGOODSTYPEONESELF){
        self.ciriLabel.frame = CGRectMake(0, self.headView.ctBottom, SCREENWIDTH, 0);
        [self setCornerLayout];
        self.typeLabel.text = @"门店自提";
        self.dateLabel.text = @"";
        
    }else{
        
    }
}
-(void)setdate{
    NSDate *now = [[[NSDate alloc]init] dateByAddingDays:1];
    NSInteger nowmonth = [now month];
    NSInteger nowday = [now  day];
    NSInteger nowweek = [now weekday];
    NSString* nowweekstr = [self changeWeek:nowweek];
    NSString *nowstr = [NSString stringWithFormat:@"%ld月%ld日|%@ 09:00-12:00",nowmonth,nowday,nowweekstr];
    self.dateLabel.text = nowstr;
}
-(NSString *)changeWeek:(NSInteger)date{
    if (date==1) {
        return  @"周日";
    }else if (date ==2){
        return @"周一";
    }else if (date ==3){
        return @"周二";
    }else if (date ==4){
        return @"周三";
    }else if (date ==5){
        return @"周四";
    }else if (date ==6){
        return @"周五";
    }else if (date ==7){
        return @"周六";
    }
    return @"";
    
}
-(void)setCornerLayout{
    self.footView.frame = CGRectMake(0, self.ciriLabel.ctBottom+5, SCREENWIDTH, 45);
    self.lineLabel.frame = CGRectMake(15, 12, 3, 21);
    self.typeLabel.frame = CGRectMake(self.lineLabel.ctRight+10, 0, 60, 45);
    self.dateLabel.frame = CGRectMake(80, 0, SCREENWIDTH-110, 45);
    
    self.rightBBtn.frame = CGRectMake(SCREENWIDTH-22, 17, 7, 12);
}

-(void)setModel:(ChangeAddressReq *)model{
    self.titleLabel.text = model.memberAddressName;
    self.phoneLabel.text = model.memberAddressMobile;
    self.morenLabel.hidden = !model.memberAddressIsDefault;
    
    if (model.memberAddressProvince) {
        self.centerLabel.hidden = YES;
        self.detailLabel.text = [NSString stringWithFormat:@"%@%@%@%@",model.memberAddressProvince,model.memberAddressCity,model.memberAddressArea,model.memberAddressDetail];
    }else{
        self.centerLabel.hidden = NO;
    }
}
@end
