//
//  RefundOrderReq.h
//  Psf
//
//  Created by 燕来秋mac9 on 2018/8/8.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RefundOrderReq : NSObject
///订单编号
@property(nonatomic,assign)NSInteger saleOrderId;
///订单商品编号
@property(nonatomic,assign)NSInteger saleOrderProductId;
///退货类型
@property(nonatomic,assign)NSInteger saleOrderRefundType;
///退货原因
@property(nonatomic,copy)NSString *saleOrderRefundReason;
///退款金额
@property(nonatomic,copy)NSString *saleOrderRefundAmount;

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
@end
