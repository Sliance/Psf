//
//  IntegralRecord.h
//  Psf
//
//  Created by 燕来秋mac9 on 2018/7/25.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IntegralRecord : NSObject
///会员积分记录类型
@property(nonatomic,assign)NSInteger memberPointRecordType;
///变动的积分
@property(nonatomic,copy)NSString *memberPointChangePoint;
///创建时间
@property(nonatomic,copy)NSString *systemCreateTime;

///交易类型(0、充值，1、消费 2、退款)
@property(nonatomic,assign)NSInteger memberTradeType;
///支付金额
@property(nonatomic,copy)NSString *payAmount;
@property(nonatomic,copy)NSString *balancePayAmount;
@end
