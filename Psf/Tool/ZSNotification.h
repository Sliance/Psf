//
//  ZSNotification.h
//  Psf
//
//  Created by 燕来秋mac9 on 2018/8/22.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZSNotification : NSObject
+ (void)removeAllNotification:(id)target;
//微信支付结果
#define WeixinPayResultNotification @"WeixinPayResultNotification"
+(void)addWeixinPayResultNotification:(id)target action:(SEL)action;
+(void)postWeixinPayResultNotification:(NSDictionary *)userInfo;
//支付宝支付结果
#define AlipayPayResultNotification @"AlipayPayResultNotification"
+(void)addAlipayPayResultNotification:(id)target action:(SEL)action;
+(void)postAlipayPayResultNotification:(NSDictionary *)userInfo;


//定位结果
#define locationResultNotification @"locationResultNotification"
+(void)addLocationResultNotification:(id)target action:(SEL)action;
+(void)postLocationResultNotification:(NSDictionary *)userInfo;
//微信登录结果
#define WeixinLoginResultNotification @"WeixinLoginResultNotification"
+(void)addWeixinLoginResultNotification:(id)target action:(SEL)action;
+(void)postWeixinLoginResultNotification:(NSDictionary *)userInfo;
//刷新定位
#define locationRefreshNotification @"locationRefreshNotification"

+(void)addRefreshLocationResultNotification:(id)target action:(SEL)action;
+(void)postRefreshLocationResultNotification:(NSDictionary *)userInfo;
//推送
#define pushRefreshNotification @"pushRefreshNotification"
+(void)addRefreshPushResultNotification:(id)target action:(SEL)action;
+(void)postRefreshPushResultNotification:(NSDictionary *)userInfo;

@end
