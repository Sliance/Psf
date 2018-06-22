//
//  ZSAFNetworkingConfig.h
//  Psf
//
//  Created by 燕来秋mac9 on 2018/6/21.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "NSDictionary+TYAFNetworking.h"
#import "NSArray+TYAFNetworking.h"
static NSTimeInterval kAIFNetworkingTimeoutSeconds = 20.0f;
typedef NS_ENUM(NSInteger, ResponseStatus){
    ResponseStatusSuccess,//在最底层，当服务器有返回消息就会返回成功
    ResponseStatusErrorTimeout,//当没有收到成功或失败的反馈，当做超时处理
    ResponseStatusErrorFail//默认所有除了超时的网络错误都当做请求失败吃力
};
