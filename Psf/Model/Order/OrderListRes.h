//
//  OrderListRes.h
//  Psf
//
//  Created by 燕来秋mac9 on 2018/7/23.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderListRes : NSObject
///商品编号
@property(nonatomic,copy)NSString* productId;
///商品名称
@property(nonatomic,copy)NSString* productName;
///商品价格
@property(nonatomic,copy)NSString* productPrice;
///商品标题
@property(nonatomic,copy)NSString* productTitle;
///商品单位
@property(nonatomic,copy)NSString* productUnit;
///商品重量
@property(nonatomic,copy)NSString* productWeight;
///订单商品编号
@property(nonatomic,copy)NSString* saleOrderProductId;
///购买数量
@property(nonatomic,copy)NSString* saleOrderProductQty;
///创建时间
@property(nonatomic,copy)NSString* systemCreateTime;
///积分优惠金额
@property(nonatomic,copy)NSString* saleOrderCouponAmount;
///快递费金额
@property(nonatomic,copy)NSString* saleOrderExpressAmount;
///销售订单编号
@property(nonatomic,copy)NSString* saleOrderId;
///实付金额
@property(nonatomic,copy)NSString* saleOrderPayAmount;
///支付过期时间
@property(nonatomic,copy)NSString* saleOrderPayExpireTime;
///积分优惠金额
@property(nonatomic,copy)NSString* saleOrderPointAmount;
///商品图片列表
@property(nonatomic,strong)NSArray* saleOrderProductList;
///收货方式(0门店自提，1送货上门)
@property(nonatomic,assign)NSInteger saleOrderReceiveType;
///销售订单状态
@property(nonatomic,assign)NSInteger saleOrderStatus;
///订单商品总数
@property(nonatomic,copy)NSString* saleOrderTotalQuantity;
///销售订单类型
@property(nonatomic,copy)NSString* saleOrderType;

@property(nonatomic,copy)NSString *memberId;
///余额退款
@property(nonatomic,copy)NSString *saleOrderRefundApproverbReturnBalance;
///退货类型(0，仅退款 1、退款退货)
@property(nonatomic,assign)NSInteger saleOrderRefundType;
///退货原因
@property(nonatomic,copy)NSString *saleOrderRefundReason;
///
@property(nonatomic,copy)NSString *productImagePath;
///退款金额
@property(nonatomic,copy)NSString *saleOrderRefundAmount;
///微信退款
@property(nonatomic,copy)NSString *saleOrderRefundApproveReturnWxpay;
///退货编号
@property(nonatomic,copy)NSString *saleOrderRefundId;
///审核意见
@property(nonatomic,copy)NSString *saleOrderRefundApproveReason;
///审核结果
@property(nonatomic,copy)NSString *saleOrderRefundApproverResult;
///积分退还
@property(nonatomic,copy)NSString *saleOrderRefundApproveReturnPoint;
///优惠券退还
@property(nonatomic,copy)NSString *saleOrderRefundApproveReturnCoupon;
///退货状态
@property(nonatomic,copy)NSString *saleOrderRefundStatus;
///审核/退款时间
@property(nonatomic,assign)NSInteger systemUpdateTime;






@end
