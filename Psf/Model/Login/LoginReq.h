//
//  LoginReq.h
//  Psf
//
//  Created by 燕来秋mac9 on 2018/7/26.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoginReq : NSObject
///应用编号
@property(nonatomic,copy)NSString *appId;
///
@property(nonatomic,copy)NSString *token;
///客户端
@property(nonatomic,strong)NSString *platform;
///时间戳
@property(nonatomic,copy)NSString *timestamp;

@property(nonatomic,copy)NSString *version;
///验证码
@property(nonatomic,copy)NSString *smsCaptchaCode;
///手机号
@property(nonatomic,copy)NSString *memberMobile;
///密码
@property(nonatomic,copy)NSString *memberPassword;
@end
