//
//  ZSNotification.m
//  Psf
//
//  Created by 燕来秋mac9 on 2018/8/22.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "ZSNotification.h"

@implementation ZSNotification
+ (void)removeAllNotification:(id)target
{
    [[NSNotificationCenter defaultCenter] removeObserver:target];
}
//微信支付结果
+(void)addWeixinPayResultNotification:(id)target action:(SEL)action{
    [[NSNotificationCenter defaultCenter] addObserver:target
                                             selector:action
                                                 name:WeixinPayResultNotification
                                               object:nil];
}

+(void)postWeixinPayResultNotification:(NSDictionary *)userInfo{
    [[NSNotificationCenter defaultCenter] postNotificationName:WeixinPayResultNotification object:nil userInfo:userInfo];
}
//定位
+(void)addLocationResultNotification:(id)target action:(SEL)action{
    [[NSNotificationCenter defaultCenter] addObserver:target
                                             selector:action
                                                 name:locationResultNotification
                                               object:nil];
}
+(void)postLocationResultNotification:(NSDictionary *)userInfo{
     [[NSNotificationCenter defaultCenter] postNotificationName:locationResultNotification object:nil userInfo:userInfo];
}
//微信登录
+(void)addWeixinLoginResultNotification:(id)target action:(SEL)action{
    [[NSNotificationCenter defaultCenter] addObserver:target
                                             selector:action
                                                 name:WeixinLoginResultNotification
                                               object:nil];
}
+(void)postWeixinLoginResultNotification:(NSDictionary *)userInfo{
    [[NSNotificationCenter defaultCenter] postNotificationName:WeixinLoginResultNotification object:nil userInfo:userInfo];
}
//刷新定位
+(void)addRefreshLocationResultNotification:(id)target action:(SEL)action{
    [[NSNotificationCenter defaultCenter] addObserver:target
                                             selector:action
                                                 name:locationRefreshNotification
                                               object:nil];
}
+(void)postRefreshLocationResultNotification:(NSDictionary *)userInfo{
    [[NSNotificationCenter defaultCenter] postNotificationName:locationRefreshNotification object:nil userInfo:userInfo];
}
@end
