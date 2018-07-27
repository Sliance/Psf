//
//  OrderDetailRes.h
//  Psf
//
//  Created by 燕来秋mac9 on 2018/7/24.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderDetailRes : NSObject
///团购活动价格
@property(nonatomic,copy)NSString *grouponActivityPrice;
///门店编号
@property(nonatomic,copy)NSString *merchantStoreId;
///门店名字
@property(nonatomic,copy)NSString *merchantStoreName;
///预售到货时间
@property(nonatomic,copy)NSString *preSaleDeliveryTime;
///商品编号
@property(nonatomic,copy)NSString *productId;

///商品图片编号
@property(nonatomic,copy)NSString *productImageId;
///商品图片路径
@property(nonatomic,copy)NSString *productImagePath;
///商品名称
@property(nonatomic,copy)NSString *productName;
///商品价格
@property(nonatomic,copy)NSString *productPrice;
///商品SKU编号
@property(nonatomic,copy)NSString *productSkuId;



///商品标题
@property(nonatomic,copy)NSString *productTitle;
///商品单位
@property(nonatomic,copy)NSString *productUnit;
///商品重量
@property(nonatomic,copy)NSString *productWeight;
///余额抵扣金额
@property(nonatomic,copy)NSString *saleOrderBalanceAmount;
///优惠券金额
@property(nonatomic,copy)NSString *saleOrderCouponAmount;


///配送结束时间
@property(nonatomic,copy)NSString *saleOrderDistributionEndTime;
///配送开始日期
@property(nonatomic,copy)NSString *saleOrderDistributionStartTime;
///快递费金额
@property(nonatomic,copy)NSString *saleOrderExpressAmount;
///销售订单编号
@property(nonatomic,copy)NSString *saleOrderId;
///发票个人名称
@property(nonatomic,copy)NSString *saleOrderInvoiceCompanyName;

///发票公司名称
@property(nonatomic,copy)NSString *saleOrderInvoiceCompanyTax;
///发票公司税号
@property(nonatomic,copy)NSString *saleOrderInvoiceContent;
///发票类型
@property(nonatomic,copy)NSString *saleOrderInvoiceType;
///发票类型
@property(nonatomic,copy)NSString *saleOrderInvoiceUserName;
///是否开具发票
@property(nonatomic,assign)BOOL saleOrderIsInvoice;
///实付金额
@property(nonatomic,copy)NSString *saleOrderPayAmount;
///积分优惠金额
@property(nonatomic,copy)NSString *saleOrderPointAmount;
///销售订单商品编号
@property(nonatomic,copy)NSString *saleOrderProductId;


///商品列表
@property(nonatomic,strong)NSArray *saleOrderProductList;
///购买数量
@property(nonatomic,copy)NSString *saleOrderProductQty;
///收货人详细地址
@property(nonatomic,copy)NSString *saleOrderReceiveAddress;
///收货人区
@property(nonatomic,copy)NSString *saleOrderReceiveArea;
///收货人市
@property(nonatomic,copy)NSString *saleOrderReceiveCity;
///收货人电话
@property(nonatomic,copy)NSString *saleOrderReceiveMobile;


///收货人姓名
@property(nonatomic,copy)NSString *saleOrderReceiveName;
///收货人省
@property(nonatomic,copy)NSString *saleOrderReceiveProvince;
///收货类型（0 自提 1 次日达）
@property(nonatomic,assign)NSInteger saleOrderReceiveType;
///满减金额
@property(nonatomic,copy)NSString *saleOrderRewardAmount;
///销售订单状态
@property(nonatomic,assign)NSInteger saleOrderStatus;
///商品总金额
@property(nonatomic,copy)NSString *saleOrderTotalAmount;

///订单类型
@property(nonatomic,copy)NSString *saleOrderType;
///详细地址
@property(nonatomic,copy)NSString *storeAddress;
///区
@property(nonatomic,copy)NSString *storeArea;
///市
@property(nonatomic,copy)NSString *storeCity;
///门店所在省
@property(nonatomic,copy)NSString *storeProvinces;
///联系电话
@property(nonatomic,copy)NSString *storeTel;

///下单时间
@property(nonatomic,copy)NSString *systemCreateTime;

@end
