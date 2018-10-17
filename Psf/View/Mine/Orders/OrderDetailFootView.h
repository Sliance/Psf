//
//  OrderDetailFootView.h
//  Psf
//
//  Created by 燕来秋mac9 on 2018/6/28.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "BaseView.h"
#import "WaitPaymentCell.h"
#import "OrderDetailRes.h"

@interface OrderDetailFootView : BaseView
///开具发票
@property(nonatomic,strong)UILabel *billLabel;
@property(nonatomic,strong)UIView *billView;
@property(nonatomic,strong)UIView *headView;
@property(nonatomic,strong)UIView *footView;
///订单编号
@property(nonatomic,strong)UILabel *orderNumLabel;

@property(nonatomic,strong)UILabel *detailOrderNumLabel;


///应付合计
@property(nonatomic,strong)UILabel *payableLabel;
///支付方式
@property(nonatomic,strong)UILabel *paytypeLabel;
@property(nonatomic,strong)UILabel *detailPaytypeLabel;
///运费
@property(nonatomic,strong)UILabel *freightLabel;
@property(nonatomic,strong)UILabel *detailFreightLabel;
///商品合计
@property(nonatomic,strong)UILabel *totoalPayLabel;
@property(nonatomic,strong)UILabel *detailTPayLabel;
///下单时间
@property(nonatomic,strong)UILabel *dateLabel;
@property(nonatomic,strong)UILabel *detailDateLabel;
@property(nonatomic,strong)UILabel *lineLabel;
@property(nonatomic,strong)UILabel *centerLine;
@property(nonatomic,strong)UIButton *xcopyBtn;
@property(nonatomic,strong)UILabel *serviceDateLabel;
@property(nonatomic,strong)UIButton *onlineBtn;
@property(nonatomic,strong)UIButton *phoneBtn;
@property(nonatomic,strong)UISwitch *chooseSwitch;
//订单类型
@property(nonatomic,strong)UILabel *orderTypeLabel;
@property(nonatomic,strong)UILabel *detailorderTypeLabel;
//到货时间
@property(nonatomic,strong)UILabel *arriveDateLabel;
@property(nonatomic,strong)UILabel *detailarriveDateLabel;
//积分
@property(nonatomic,strong)UILabel *integralLabel;
@property(nonatomic,strong)UILabel *detailIntegralLabel;
//满减
@property(nonatomic,strong)UILabel *fulllLabel;
@property(nonatomic,strong)UILabel *detailFullLabel;
//优惠券
@property(nonatomic,strong)UILabel *couponLabel;
@property(nonatomic,strong)UILabel *detailCouponLabel;
//余额
@property(nonatomic,strong)UILabel *balanaceLabel;
@property(nonatomic,strong)UILabel *detailBalanceLabel;

@property(nonatomic,strong)UILabel *deliveryStartLabel;
@property(nonatomic,strong)UILabel *deliveryEndLabel;

///订单状态
@property(nonatomic,assign)ORDERSTYPE ordertype;

@property(nonatomic,strong)OrderDetailRes *model;
@property(nonatomic,copy)void (^phoneBlock)(void);

@end
