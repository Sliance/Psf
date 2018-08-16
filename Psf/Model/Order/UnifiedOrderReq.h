//
//  UnifiedOrderReq.h
//  Psf
//
//  Created by 燕来秋mac9 on 2018/8/16.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UnifiedOrderReq : NSObject
///
@property(nonatomic,copy)NSString *appId;
///
@property(nonatomic,copy)NSString *token;
///
@property(nonatomic,copy)NSString *platform;
///
@property(nonatomic,copy)NSString *timestamp;
///支付类型
@property(nonatomic,copy)NSString *tradeType;
///
@property(nonatomic,copy)NSString *body   ;
///订单号
@property(nonatomic,copy)NSString *saleOrderId   ;
///
@property(nonatomic,copy)NSString *openId   ;
///金额
@property(nonatomic,copy)NSString *totalFee;

@end
