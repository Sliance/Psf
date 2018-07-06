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
        [self addSubview:self.billView];
        [self addSubview:self.headView];
        [self addSubview:self.footView];
        [self.billView addSubview:self.billLabel];
        [self.headView addSubview:self.orderNumLabel];
        [self.headView addSubview:self.detailOrderNumLabel];
        [self.headView addSubview:self.lineLabel];
        [self.headView addSubview:self.dateLabel];
        [self.headView addSubview:self.detailDateLabel];
        [self.headView addSubview:self.paytypeLabel];
        [self.headView addSubview:self.detailPaytypeLabel];
        [self.headView addSubview:self.totoalPayLabel];
        [self.headView addSubview:self.detailTPayLabel];
        [self.headView addSubview:self.freightLabel];
        [self.headView addSubview:self.detailFreightLabel];
        [self.headView addSubview:self.payableLabel];
        [self.footView addSubview:self.serviceDateLabel];
        [self.headView addSubview:self.xcopyBtn];
        [self.footView addSubview:self.onlineBtn];
        [self.footView addSubview:self.phoneBtn];
        [self.billView addSubview:self.chooseSwitch];
        self.billView.frame = CGRectMake(0, 5, SCREENWIDTH, 45);
        self.headView.frame = CGRectMake(0, 55, SCREENWIDTH, 192);
        self.billLabel.frame = CGRectMake(15, 0, SCREENWIDTH-80, 45);
        self.chooseSwitch.frame = CGRectMake(SCREENWIDTH-46-15, 8, 46, 26);
        self.orderNumLabel.frame = CGRectMake(15, 16, 70, 13);
        self.detailOrderNumLabel.frame = CGRectMake(5+self.orderNumLabel.ctRight, 15, 170, 13);
        self.dateLabel.frame = CGRectMake(15, 16+self.orderNumLabel.ctBottom, 70, 13);
        self.detailDateLabel.frame = CGRectMake(5+self.dateLabel.ctRight, 16+self.orderNumLabel.ctBottom, 170, 13);
        self.lineLabel.frame = CGRectMake(15, 74, SCREENWIDTH-15, 0.5);
        self.paytypeLabel.frame = CGRectMake(15, 6+self.lineLabel.ctBottom, 70, 25);
        self.detailPaytypeLabel.frame = CGRectMake(5+self.paytypeLabel.ctRight, 6+self.lineLabel.ctBottom, 170, 25);
        [self setCornerLayout];
    }
    return self;
}
-(void)setCornerLayout{
    self.footView.frame = CGRectMake(0, self.headView.ctBottom+5, SCREENWIDTH, 91);
    self.totoalPayLabel.frame = CGRectMake(15, 10+self.paytypeLabel.ctBottom, 70, 13);
    self.detailTPayLabel.frame = CGRectMake(5+self.totoalPayLabel.ctRight, 10+self.paytypeLabel.ctBottom, 170, 13);
    self.freightLabel.frame = CGRectMake(15, 16+self.totoalPayLabel.ctBottom, 70, 13);
    self.detailFreightLabel.frame = CGRectMake(5+self.freightLabel.ctRight, 16+self.totoalPayLabel.ctBottom, 170, 13);
    self.centerLine.frame = CGRectMake(15, self.freightLabel.ctBottom+16, SCREENWIDTH-15, 0.5);
    self.payableLabel.frame = CGRectMake(15, 16+self.centerLine.ctBottom, SCREENWIDTH-30, 13);
    self.serviceDateLabel.frame = CGRectMake(15, 15, SCREENWIDTH-30, 12);
    self.xcopyBtn.frame = CGRectMake(SCREENWIDTH-55, 15, 40, 20);
    self.onlineBtn.frame = CGRectMake(15, 37, (SCREENWIDTH-45)/2, 34);
    self.phoneBtn.frame = CGRectMake(30+(SCREENWIDTH-45)/2, 37, (SCREENWIDTH-45)/2, 34);
}
-(void)setOrdertype:(ORDERSTYPE)ordertype{
    if (ordertype==ORDERSTYPEWaitPayment) {
        self.headView.frame = CGRectMake(0, 55, SCREENWIDTH, 192);
        self.paytypeLabel.frame = CGRectMake(15, 6+self.lineLabel.ctBottom, 70, 0);
        self.detailPaytypeLabel.frame = CGRectMake(5+self.totoalPayLabel.ctRight, 6+self.lineLabel.ctBottom, 170, 0);
        [self setCornerLayout];
    } else {
        self.headView.frame = CGRectMake(0, 5, SCREENWIDTH, 221);
        self.paytypeLabel.frame = CGRectMake(15, 6+self.lineLabel.ctBottom, 70, 25);
        self.detailPaytypeLabel.frame = CGRectMake(5+self.totoalPayLabel.ctRight, 6+self.lineLabel.ctBottom, 170, 25);
        [self setCornerLayout];
    }
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
        _payableLabel.text = @"应付:￥39.8";
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
        _detailTPayLabel.text = @"¥ 99.80";
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
    }
    return _phoneBtn;
}
-(UISwitch *)chooseSwitch{
    if (!_chooseSwitch) {
        _chooseSwitch = [[UISwitch alloc]init];
    }
    return _chooseSwitch;
}
@end
