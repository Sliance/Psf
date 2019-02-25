//
//  PlaceOrderReq.h
//  Psf
//
//  Created by 燕来秋mac9 on 2018/7/27.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PlaceOrderReq : NSObject
///(181)
@property(nonatomic,copy)NSString *erpStoreId;
///订单商品信息
@property(nonatomic,strong)NSArray *productList;
///城市名字
@property(nonatomic,copy)NSString *cityName;
///团购编号
@property(nonatomic,assign)NSInteger grouponId;
///订单类型
@property(nonatomic,copy)NSString *saleOrderType;
///商品总数
@property(nonatomic,assign)NSInteger saleOrderTotalQuantity;
///拼团类型(0 代表开团， 1代表参团)
@property(nonatomic,assign)NSInteger grouponActiveType;

///拼团活动的编号
@property(nonatomic,copy)NSString *grouponActivityId;
///订单来源
@property(nonatomic,copy)NSString *saleOrderPlatform;
///积分优惠金额
@property(nonatomic,copy)NSString *saleOrderPointAmount;
///支付方式
@property(nonatomic,copy)NSString *saleOrderPayType;
///是否使用余额
@property(nonatomic,assign)BOOL useIsBalance;


///收货方式
@property(nonatomic,copy)NSString *saleOrderReceiveType;
///收货人姓名
@property(nonatomic,copy)NSString *saleOrderReceiveName;
///收货人手机号码
@property(nonatomic,copy)NSString *saleOrderReceiveMobile;
///收货人省
@property(nonatomic,copy)NSString *saleOrderReceiveProvince;
///收货人市
@property(nonatomic,copy)NSString *saleOrderReceiveCity;

///收货人区
@property(nonatomic,copy)NSString *saleOrderReceiveArea;
///收货人详细地址
@property(nonatomic,copy)NSString *saleOrderReceiveAddress;
///发票类型（0个人 1公司
@property(nonatomic,assign)NSInteger saleOrderInvoiceType;
///是否开具发票
@property(nonatomic,assign)BOOL saleOrderIsInvoice;
///发票个人名称
@property(nonatomic,copy)NSString *saleOrderInvoiceUserName;

///发票公司名称
@property(nonatomic,copy)NSString *saleOrderInvoiceCompanyName;
///发票公司税号
@property(nonatomic,copy)NSString *saleOrderInvoiceCompanyTax;
///发票内容
@property(nonatomic,copy)NSString *saleOrderInvoiceContent;
///发票收票邮件
@property(nonatomic,copy)NSString *saleOrderInvoiceEmail;
///是否使用积分
@property(nonatomic,assign)BOOL usePointIs;



///自提门店编号
@property(nonatomic,copy)NSString *merchantStoreId;
///自提门店名称
@property(nonatomic,copy)NSString *merchantStoreName;
///配送开始日期
@property(nonatomic,copy)NSString *saleOrderDistributionStartTime;
///配送结束时间
@property(nonatomic,copy)NSString *saleOrderDistributionEndTime;
///应用编号
@property(nonatomic,copy)NSString *appId;
///
@property(nonatomic,copy)NSString *token;

///客户端
@property(nonatomic,copy)NSString *platform;
///时间戳
@property(nonatomic,copy)NSString *timestamp;



///会员优惠券
@property(nonatomic,copy)NSString *couponId;
///
@property(nonatomic, assign)NSInteger productSkuId;

@property(nonatomic, assign)NSInteger preSaleId;
///1、购物车下单  2、商品详情下单
@property(nonatomic, assign)NSInteger orderType ;
///备注
@property(nonatomic,copy)NSString *saleOrderRemark;
///
@property(nonatomic,copy)NSString *memberAddressLatitude;
///
@property(nonatomic,copy)NSString *memberAddressLongitude;

@end
