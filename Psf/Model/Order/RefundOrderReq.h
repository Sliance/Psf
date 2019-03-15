//
//  RefundOrderReq.h
//  Psf
//
//  Created by 燕来秋mac9 on 2018/8/8.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RefundOrderReq : NSObject
///(181)
@property(nonatomic,copy)NSString *erpStoreId;
///订单编号
@property(nonatomic,assign)NSInteger saleOrderId;
///订单商品编号
@property(nonatomic,copy)NSString* saleOrderProductId;
///退货类型
@property(nonatomic,assign)NSInteger saleOrderRefundType;
///退货原因
@property(nonatomic,copy)NSString *saleOrderRefundReason;
///退款金额
@property(nonatomic,copy)NSString *saleOrderRefundAmount;
///余额抵扣
@property(nonatomic,copy)NSString *saleOrderRefundApproverbReturnBalance;
///实付金额
@property(nonatomic,copy)NSString *saleOrderRefundApproveReturnWxpay;;
///
@property(nonatomic,strong)NSArray *saleOrderRefundImageList;
///
@property(nonatomic,copy)NSString *appId;
///
@property(nonatomic,copy)NSString *token;
///
@property(nonatomic,copy)NSString *platform;
///
@property(nonatomic,copy)NSString *timestamp;
@property(nonatomic,copy)NSString *time;

//测试
@property(nonatomic,assign)NSInteger refundId;
///
@property(nonatomic,copy)NSString *totalFee;
///
@property(nonatomic,copy)NSString *refundFee;
///
@property(nonatomic,copy)NSString *refundDesc;
///是否预售
@property(nonatomic,assign)BOOL productIsPreSale;
///是否次日达
@property(nonatomic,assign)BOOL productIsSaleNextDay;
///是否促销
@property(nonatomic,assign)BOOL productIsSalePromotion;
///是否团购
@property(nonatomic,assign)BOOL productIsGroupon;
///是否满减
@property(nonatomic,assign)BOOL productIsWard;
@end
