//
//  OrderDetailFootView.m
//  Psf
//
//  Created by 燕来秋mac9 on 2018/6/28.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "OrderDetailFootView.h"

@implementation OrderDetailFootView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
       
        self.backgroundColor = DSColorFromHex(0xF0F0F0);
        [self addSubview:self.headView];
        [self addSubview:self.footView];
        [self.headView addSubview:self.orderNumLabel];
        [self.headView addSubview:self.detailOrderNumLabel];
        [self.headView addSubview:self.lineLabel];
        [self.headView addSubview:self.centerLine];
        [self.headView addSubview:self.dateLabel];
        [self.headView addSubview:self.detailDateLabel];
        [self.headView addSubview:self.totoalPayLabel];
        [self.headView addSubview:self.detailTPayLabel];
        [self.headView addSubview:self.freightLabel];
        [self.headView addSubview:self.detailFreightLabel];
        [self.headView addSubview:self.payableLabel];
        [self.footView addSubview:self.serviceDateLabel];
        [self.footView addSubview:self.onlineBtn];
        [self.footView addSubview:self.phoneBtn];
        [self.headView addSubview:self.orderTypeLabel];
        [self.headView addSubview:self.detailorderTypeLabel];
        [self.headView addSubview:self.arriveDateLabel];
        [self.headView addSubview:self.detailarriveDateLabel];
        [self.headView addSubview:self.integralLabel];
        [self.headView addSubview:self.detailIntegralLabel];
        [self.headView addSubview:self.fulllLabel];
        [self.headView addSubview:self.detailFullLabel];
        [self.headView addSubview:self.couponLabel];
        [self.headView addSubview:self.detailCouponLabel];
        [self.headView addSubview:self.detailBalanceLabel];
        [self.headView addSubview:self.balanaceLabel];
        self.headView.frame = CGRectMake(0, 5, SCREENWIDTH, 300);
        self.orderNumLabel.frame = CGRectMake(15, 16, 70, 13);
        self.detailOrderNumLabel.frame = CGRectMake(5+self.orderNumLabel.ctRight, 15, SCREENWIDTH-115, 13);
        self.orderTypeLabel.frame =CGRectMake(15, 16+self.orderNumLabel.ctBottom, 70, 13);
        self.detailorderTypeLabel.frame = CGRectMake(5+self.orderTypeLabel.ctRight, 16+self.orderNumLabel.ctBottom, 170, 13);
        self.dateLabel.frame = CGRectMake(15, 16+self.orderTypeLabel.ctBottom, 70, 13);
        self.detailDateLabel.frame = CGRectMake(5+self.dateLabel.ctRight, 16+self.orderTypeLabel.ctBottom, 170, 13);
       
        [self setCornerLayout];
    }
    return self;
}
-(void)setCornerLayout{
    self.lineLabel.frame = CGRectMake(15, self.arriveDateLabel.ctBottom, SCREENWIDTH-15, 0.5);
    self.footView.frame = CGRectMake(0, self.headView.ctBottom+5, SCREENWIDTH, 91);
    self.totoalPayLabel.frame = CGRectMake(15, 10+self.lineLabel.ctBottom, 70, 13);
    self.detailTPayLabel.frame = CGRectMake(5+self.totoalPayLabel.ctRight, 10+self.lineLabel.ctBottom, 170, 13);
    self.freightLabel.frame = CGRectMake(15, 15+self.totoalPayLabel.ctBottom, 70, 13);
    self.detailFreightLabel.frame = CGRectMake(5+self.freightLabel.ctRight, 15+self.totoalPayLabel.ctBottom, 170, 13);
    self.integralLabel.frame =CGRectMake(15, 15+self.freightLabel.ctBottom, 70, 13);
    self.detailIntegralLabel.frame =CGRectMake(5+self.integralLabel.ctRight, 15+self.freightLabel.ctBottom, 170, 13);
    self.fulllLabel.frame =CGRectMake(15, 15+self.integralLabel.ctBottom, 70, 13);
    self.detailFullLabel.frame =CGRectMake(5+self.fulllLabel.ctRight, 15+self.integralLabel.ctBottom, 170, 13);
    self.couponLabel.frame =CGRectMake(15, 15+self.fulllLabel.ctBottom, 80, 13);
    self.detailCouponLabel.frame =CGRectMake(5+self.couponLabel.ctRight, 15+self.fulllLabel.ctBottom, 170, 13);
    self.balanaceLabel.frame =CGRectMake(15, 15+self.couponLabel.ctBottom, 70, 13);
    self.detailBalanceLabel.frame =CGRectMake(5+self.balanaceLabel.ctRight, 15+self.couponLabel.ctBottom, 170, 13);
    self.centerLine.frame = CGRectMake(15, self.balanaceLabel.ctBottom+15, SCREENWIDTH-15, 0.5);
    self.payableLabel.frame = CGRectMake(15, 15+self.centerLine.ctBottom, SCREENWIDTH-30, 13);
    self.serviceDateLabel.frame = CGRectMake(15, 15, SCREENWIDTH-30, 12);

    self.onlineBtn.frame = CGRectMake(15, 37, (SCREENWIDTH-45)/2, 34);
    self.phoneBtn.frame = CGRectMake(30+(SCREENWIDTH-45)/2, 37, (SCREENWIDTH-45)/2, 34);
}
-(void)setOrdertype:(ORDERSTYPE)ordertype{
    
}
-(UIView *)billView{
    if (!_billView) {
        _billView = [[UIView alloc]init];
        _billView.backgroundColor = [UIColor whiteColor];
    }
    return _billView;
}
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
-(UILabel *)payableLabel{
    if (!_payableLabel) {
        _payableLabel = [[UILabel alloc]init];
        _payableLabel.textAlignment = NSTextAlignmentLeft;
        _payableLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:14];
        _payableLabel.textColor = DSColorFromHex(0xFF4C4D);
        _payableLabel.text = @"";
    }
    return _payableLabel;
}
-(UILabel *)billLabel{
    if (!_billLabel) {
        _billLabel = [[UILabel alloc]init];
        _billLabel.textAlignment = NSTextAlignmentLeft;
        _billLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:15];
        _billLabel.textColor = DSColorFromHex(0x464646);
        _billLabel.text = @"开具发票";
    }
    return _billLabel;
}
-(UILabel *)orderNumLabel{
    if (!_orderNumLabel) {
        _orderNumLabel = [[UILabel alloc]init];
        _orderNumLabel.textAlignment = NSTextAlignmentLeft;
        _orderNumLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:14];
        _orderNumLabel.textColor = DSColorFromHex(0x787878);
        _orderNumLabel.text = @"订单编号:";
    }
    return _orderNumLabel;
}
-(UILabel *)dateLabel{
    if (!_dateLabel) {
        _dateLabel = [[UILabel alloc]init];
        _dateLabel.textAlignment = NSTextAlignmentLeft;
        _dateLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:14];
        _dateLabel.textColor = DSColorFromHex(0x787878);
        _dateLabel.text = @"下单时间:";
    }
    return _dateLabel;
}
-(UILabel *)orderTypeLabel{
    if (!_orderTypeLabel) {
        _orderTypeLabel = [[UILabel alloc]init];
        _orderTypeLabel.textAlignment = NSTextAlignmentLeft;
        _orderTypeLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:14];
        _orderTypeLabel.textColor = DSColorFromHex(0x787878);
        _orderTypeLabel.text = @"订单类型:";
    }
    return _orderTypeLabel;
}
-(UILabel *)arriveDateLabel{
    if (!_arriveDateLabel) {
        _arriveDateLabel = [[UILabel alloc]init];
        _arriveDateLabel.textAlignment = NSTextAlignmentLeft;
        _arriveDateLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:14];
        _arriveDateLabel.textColor = DSColorFromHex(0x787878);
        _arriveDateLabel.text = @"到货时间:";
    }
    return _arriveDateLabel;
}
-(UILabel *)integralLabel{
    if (!_integralLabel) {
        _integralLabel = [[UILabel alloc]init];
        _integralLabel.textAlignment = NSTextAlignmentLeft;
        _integralLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:14];
        _integralLabel.textColor = DSColorFromHex(0x787878);
        _integralLabel.text = @"积分抵扣:";
    }
    return _integralLabel;
}
-(UILabel *)fulllLabel{
    if (!_fulllLabel) {
        _fulllLabel = [[UILabel alloc]init];
        _fulllLabel.textAlignment = NSTextAlignmentLeft;
        _fulllLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:14];
        _fulllLabel.textColor = DSColorFromHex(0x787878);
        _fulllLabel.text = @"满减金额:";
    }
    return _fulllLabel;
}
-(UILabel *)couponLabel{
    if (!_couponLabel) {
        _couponLabel = [[UILabel alloc]init];
        _couponLabel.textAlignment = NSTextAlignmentLeft;
        _couponLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:14];
        _couponLabel.textColor = DSColorFromHex(0x787878);
        _couponLabel.text = @"优惠券抵扣:";
    }
    return _couponLabel;
}
-(UILabel *)balanaceLabel{
    if (!_balanaceLabel) {
        _balanaceLabel = [[UILabel alloc]init];
        _balanaceLabel.textAlignment = NSTextAlignmentLeft;
        _balanaceLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:14];
        _balanaceLabel.textColor = DSColorFromHex(0x787878);
        _balanaceLabel.text = @"余额消费:";
    }
    return _balanaceLabel;
}
-(UILabel *)paytypeLabel{
    if (!_paytypeLabel) {
        _paytypeLabel = [[UILabel alloc]init];
        _paytypeLabel.textAlignment = NSTextAlignmentLeft;
        _paytypeLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:14];
        _paytypeLabel.textColor = DSColorFromHex(0x787878);
        _paytypeLabel.text = @"支付方式:";
    }
    return _paytypeLabel;
}
-(UILabel *)totoalPayLabel{
    if (!_totoalPayLabel) {
        _totoalPayLabel = [[UILabel alloc]init];
        _totoalPayLabel.textAlignment = NSTextAlignmentLeft;
        _totoalPayLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:14];
        _totoalPayLabel.textColor = DSColorFromHex(0x787878);
        _totoalPayLabel.text = @"商品合计:";
    }
    return _totoalPayLabel;
}
-(UILabel *)freightLabel{
    if (!_freightLabel) {
        _freightLabel = [[UILabel alloc]init];
        _freightLabel.textAlignment = NSTextAlignmentLeft;
        _freightLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:14];
        _freightLabel.textColor = DSColorFromHex(0x787878);
        _freightLabel.text = @"运费:";
    }
    return _freightLabel;
}
-(UILabel *)serviceDateLabel{
    if (!_serviceDateLabel) {
        _serviceDateLabel = [[UILabel alloc]init];
        _serviceDateLabel.textAlignment = NSTextAlignmentLeft;
        _serviceDateLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:12];
        _serviceDateLabel.textColor = DSColorFromHex(0x474747);
        _serviceDateLabel.text = @"服务时间： 9:00 - 22:00";
    }
    return _serviceDateLabel;
}
-(UILabel *)detailOrderNumLabel{
    if (!_detailOrderNumLabel) {
        _detailOrderNumLabel = [[UILabel alloc]init];
        _detailOrderNumLabel.textAlignment = NSTextAlignmentLeft;
        _detailOrderNumLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:14];
        _detailOrderNumLabel.textColor = DSColorFromHex(0x464646);
        _detailOrderNumLabel.text = @"349572030";
    }
    return _detailOrderNumLabel;
}
-(UILabel *)detailDateLabel{
    if (!_detailDateLabel) {
        _detailDateLabel = [[UILabel alloc]init];
        _detailDateLabel.textAlignment = NSTextAlignmentLeft;
        _detailDateLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:14];
        _detailDateLabel.textColor = DSColorFromHex(0x464646);
        _detailDateLabel.text = @"2017.12.28 16:30";
    }
    return _detailDateLabel;
}
-(UILabel *)detailPaytypeLabel{
    if (!_detailPaytypeLabel) {
        _detailPaytypeLabel = [[UILabel alloc]init];
        _detailPaytypeLabel.textAlignment = NSTextAlignmentLeft;
        _detailPaytypeLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:14];
        _detailPaytypeLabel.textColor = DSColorFromHex(0x464646);
        _detailPaytypeLabel.text = @"微信";
    }
    return _detailPaytypeLabel;
}
-(UILabel *)detailTPayLabel{
    if (!_detailTPayLabel) {
        _detailTPayLabel = [[UILabel alloc]init];
        _detailTPayLabel.textAlignment = NSTextAlignmentLeft;
        _detailTPayLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:14];
        _detailTPayLabel.textColor = DSColorFromHex(0x464646);
        _detailTPayLabel.text = @"¥ 0";
    }
    return _detailTPayLabel;
}
-(UILabel *)detailFreightLabel{
    if (!_detailFreightLabel) {
        _detailFreightLabel = [[UILabel alloc]init];
        _detailFreightLabel.textAlignment = NSTextAlignmentLeft;
        _detailFreightLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:14];
        _detailFreightLabel.textColor = DSColorFromHex(0x464646);
        _detailFreightLabel.text = @"¥ 0.00";
    }
    return _detailFreightLabel;
}
-(UILabel *)detailorderTypeLabel{
    if (!_detailorderTypeLabel) {
        _detailorderTypeLabel = [[UILabel alloc]init];
        _detailorderTypeLabel.textAlignment = NSTextAlignmentLeft;
        _detailorderTypeLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:14];
        _detailorderTypeLabel.textColor = DSColorFromHex(0x464646);
        _detailorderTypeLabel.text = @"";
    }
    return _detailorderTypeLabel;
}
-(UILabel *)detailarriveDateLabel{
    if (!_detailarriveDateLabel) {
        _detailarriveDateLabel = [[UILabel alloc]init];
        _detailarriveDateLabel.textAlignment = NSTextAlignmentLeft;
        _detailarriveDateLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:14];
        _detailarriveDateLabel.textColor = DSColorFromHex(0x464646);
        _detailarriveDateLabel.text = @"";
    }
    return _detailarriveDateLabel;
}
-(UILabel *)detailIntegralLabel{
    if (!_detailIntegralLabel) {
        _detailIntegralLabel = [[UILabel alloc]init];
        _detailIntegralLabel.textAlignment = NSTextAlignmentLeft;
        _detailIntegralLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:14];
        _detailIntegralLabel.textColor = DSColorFromHex(0x464646);
        _detailIntegralLabel.text = @"¥ 0";
    }
    return _detailIntegralLabel;
}
-(UILabel *)detailFullLabel{
    if (!_detailFullLabel) {
        _detailFullLabel = [[UILabel alloc]init];
        _detailFullLabel.textAlignment = NSTextAlignmentLeft;
        _detailFullLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:14];
        _detailFullLabel.textColor = DSColorFromHex(0x464646);
        _detailFullLabel.text = @"¥ 0";
    }
    return _detailFullLabel;
}
-(UILabel *)detailCouponLabel{
    if (!_detailCouponLabel) {
        _detailCouponLabel = [[UILabel alloc]init];
        _detailCouponLabel.textAlignment = NSTextAlignmentLeft;
        _detailCouponLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:14];
        _detailCouponLabel.textColor = DSColorFromHex(0x464646);
        _detailCouponLabel.text = @"¥ 0";
    }
    return _detailCouponLabel;
}
-(UILabel *)detailBalanceLabel{
    if (!_detailBalanceLabel) {
        _detailBalanceLabel = [[UILabel alloc]init];
        _detailBalanceLabel.textAlignment = NSTextAlignmentLeft;
        _detailBalanceLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:14];
        _detailBalanceLabel.textColor = DSColorFromHex(0x464646);
        _detailBalanceLabel.text = @"¥ 0";
    }
    return _detailBalanceLabel;
}
-(UILabel *)lineLabel{
    if (!_lineLabel) {
        _lineLabel = [[UILabel alloc]init];
        _lineLabel.backgroundColor = DSColorFromHex(0xF0F0F0);
    }
    return _lineLabel;
}
-(UILabel *)centerLine{
    if (!_centerLine) {
        _centerLine = [[UILabel alloc]init];
        _centerLine.backgroundColor = DSColorFromHex(0xF0F0F0);
    }
    return _centerLine;
}
-(UIButton *)xcopyBtn{
    if (!_xcopyBtn) {
        _xcopyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _xcopyBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [_xcopyBtn setTitleColor:DSColorFromHex(0x464646) forState:UIControlStateNormal];
        [_xcopyBtn setTitle:@"复制" forState:UIControlStateNormal];
        [_xcopyBtn.layer setCornerRadius:2];
        [_xcopyBtn.layer setMasksToBounds:YES];
        [_xcopyBtn.layer setBorderWidth:0.5];
        [_xcopyBtn.layer setBorderColor:DSColorFromHex(0x464646).CGColor];
    }
    return _xcopyBtn;
}
-(UIButton *)onlineBtn{
    if (!_onlineBtn) {
        _onlineBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _onlineBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [_onlineBtn setTitleColor:DSColorFromHex(0x464646) forState:UIControlStateNormal];
        [_onlineBtn setImage:[UIImage imageNamed:@"online_service"] forState:UIControlStateNormal];
        [_onlineBtn setTitle:@"在线客服" forState:UIControlStateNormal];
        [_onlineBtn.layer setCornerRadius:2];
        [_onlineBtn.layer setMasksToBounds:YES];
        [_onlineBtn.layer setBorderWidth:0.5];
        [_onlineBtn.layer setBorderColor:DSColorFromHex(0x464646).CGColor];
        _onlineBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
    }
    return _onlineBtn;
}
-(UIButton *)phoneBtn{
    if (!_phoneBtn) {
        _phoneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _phoneBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [_phoneBtn setTitleColor:DSColorFromHex(0x464646) forState:UIControlStateNormal];
        [_phoneBtn setImage:[UIImage imageNamed:@"phone_service"] forState:UIControlStateNormal];
        [_phoneBtn setTitle:@"电话客服" forState:UIControlStateNormal];
        [_phoneBtn.layer setCornerRadius:2];
        [_phoneBtn.layer setMasksToBounds:YES];
        [_phoneBtn.layer setBorderWidth:0.5];
        [_phoneBtn.layer setBorderColor:DSColorFromHex(0x464646).CGColor];
        _phoneBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
        [_phoneBtn addTarget:self action:@selector(pressPhone) forControlEvents:UIControlEventTouchUpInside];
    }
    return _phoneBtn;
}
-(UISwitch *)chooseSwitch{
    if (!_chooseSwitch) {
        _chooseSwitch = [[UISwitch alloc]init];
    }
    return _chooseSwitch;
}

-(void)setModel:(OrderDetailRes *)model{
    _model = model;
    
    if (model.saleOrderReceiveType ==0) {
        _detailOrderNumLabel.text = [NSString stringWithFormat:@"%@(自提)", model.saleOrderId];
    }else if (model.saleOrderReceiveType ==1){
        _detailOrderNumLabel.text = model.saleOrderId;
    }
    if (model.saleOrderExpressAmount.length>0) {
        _detailFreightLabel.text = [NSString stringWithFormat:@"￥%@",model.saleOrderExpressAmount];
    }
    if (model.saleOrderTotalAmount.length>0) {
        _detailTPayLabel.text =  [NSString stringWithFormat:@"￥%@",model.saleOrderTotalAmount];
    }
    if (model.saleOrderPayAmount.length>0) {
        _payableLabel.text = [NSString stringWithFormat:@"应付:￥%@",model.saleOrderPayAmount];
    }
    
    _detailDateLabel.text = [NSDate cStringFromTimestamp:model.systemCreateTime Formatter:@"yyyy.MM.dd HH:mm"];
    if (model.saleOrderCouponAmount.length>0) {
        self.detailCouponLabel.text = [NSString stringWithFormat:@"￥%@",model.saleOrderCouponAmount];
    }
    if (model.saleOrderPointAmount.length>0) {
        self.detailIntegralLabel.text = [NSString stringWithFormat:@"￥%@",model.saleOrderPointAmount];
    }
    if (model.saleOrderBalanceAmount.length>0) {
        self.detailBalanceLabel.text = [NSString stringWithFormat:@"￥%@",model.saleOrderBalanceAmount];
    }
    
    
    if ([model.saleOrderType isEqualToString:@"preSale"]) {
        self.detailorderTypeLabel.text = @"预售订单";
    }else if ([model.saleOrderType isEqualToString:@"reward"]) {
        self.detailorderTypeLabel.text = @"满减订单";
    }else if ([model.saleOrderType isEqualToString:@"groupon"]) {
        self.detailorderTypeLabel.text = @"团购订单";
    }else if ([model.saleOrderType isEqualToString:@"normal"]) {
        self.detailorderTypeLabel.text = @"普通订单";
    }
    if ([model.saleOrderType isEqualToString:@"preSale"]) {
        self.headView.frame = CGRectMake(0, 5, SCREENWIDTH, 350);
        self.arriveDateLabel.frame = CGRectMake(15, self.dateLabel.ctBottom, 70, 43);
        self.detailarriveDateLabel.frame = CGRectMake(5+self.arriveDateLabel.ctRight, self.dateLabel.ctBottom, 170, 43);
        [self setCornerLayout];
        self.detailarriveDateLabel.text = [NSDate cStringFromTimestamp:model.preSaleDeliveryTime Formatter:@"yyyy.MM.dd HH:mm"];
        self.arriveDateLabel.text = @"到货时间:";
    } else {
        self.headView.frame = CGRectMake(0, 5, SCREENWIDTH, 320);
        self.arriveDateLabel.frame = CGRectMake(15, self.dateLabel.ctBottom, 70, 15);
        self.detailarriveDateLabel.frame = CGRectMake(5+self.arriveDateLabel.ctRight, self.dateLabel.ctBottom, 170, 15);
        [self setCornerLayout];
        self.arriveDateLabel.text = @"";
        self.detailarriveDateLabel.text = @"";
    }
}
-(void)pressPhone{
    self.phoneBlock();
}
@end
