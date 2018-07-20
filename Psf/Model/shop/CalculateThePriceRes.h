//
//  CalculateThePriceRes.h
//  Psf
//
//  Created by 燕来秋mac9 on 2018/7/20.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalculateThePriceRes : NSObject
///账户余额
@property(nonatomic,copy)NSString *memberBalance;
///用户可用积分
@property(nonatomic,copy)NSString *memberPointUse;
///优惠券优惠金额
@property(nonatomic,copy)NSString *saleOrderCouponAmount;
///运费金额
@property(nonatomic,copy)NSString *saleOrderExpressAmount;
///实际需支付金额
@property(nonatomic,copy)NSString *saleOrderPayAmount;


///积分优惠金额
@property(nonatomic,copy)NSString *saleOrderPointAmount;
///总优惠金额
@property(nonatomic,copy)NSString *saleOrderPreferentialTotalAmount;
///满减优惠金额
@property(nonatomic,copy)NSString *saleOrderRewardAmount;
///订单商品总金额
@property(nonatomic,copy)NSString *saleOrderTotalAmount;
///是否使用
@property(nonatomic,copy)NSString *useIsMemberBalance;
///使用的余额金额
@property(nonatomic,copy)NSString *useMemberBalance;
///订单号
@property(nonatomic,copy)NSString *saleOrderId;


@end
