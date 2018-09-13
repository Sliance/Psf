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
/*
 微信登录
 */
///openid
@property(nonatomic,copy)NSString *appOpenId;
///
@property(nonatomic,copy)NSString *memberAccount;
///地区
@property(nonatomic,copy)NSString *memberArea;
///小程序传的openid
@property(nonatomic,copy)NSString *openId;
///头像
@property(nonatomic,copy)NSString *avatar;
///昵称
@property(nonatomic,copy)NSString *nickname;
//UnionId
@property(nonatomic,copy)NSString *wechatUnionId;
///邮箱
@property(nonatomic,copy)NSString *memberEmail;
///
@property(nonatomic,copy)NSString *memberAvatarId;
///性别
@property(nonatomic,copy)NSString *memberGender;
///生日
@property(nonatomic,copy)NSString *memberBirthday;
///会员id
@property(nonatomic,copy)NSString *memberId;
@end
