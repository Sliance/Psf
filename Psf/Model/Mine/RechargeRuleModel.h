//
//  RechargeRuleModel.h
//  Psf
//
//  Created by 燕来秋mac9 on 2018/7/26.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RechargeRuleModel : NSObject
///
@property(nonatomic,copy)NSString *backMoney;
///充值规则编号
@property(nonatomic,copy)NSString *memberRechargeRuleId;
///
@property(nonatomic,copy)NSString *memberRechargeRuleIsOpen;
///
@property(nonatomic,copy)NSString *rechargeMoney;
@end
