//
//  OrderPayRes.h
//  Psf
//
//  Created by 燕来秋mac9 on 2018/8/17.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderPayRes : NSObject
///微信
@property(nonatomic,copy)NSString *appid;
@property(nonatomic,copy)NSString *noncestr;
@property(nonatomic,copy)NSString *packagestr;
@property(nonatomic,copy)NSString *partnerid;
@property(nonatomic,copy)NSString *prepayid;
@property(nonatomic,copy)NSString *sign;
@property(nonatomic,copy)NSString *timestamp;

///支付宝
@property(nonatomic,copy)NSString *body;
@end
