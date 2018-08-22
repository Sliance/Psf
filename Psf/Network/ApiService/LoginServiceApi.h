//
//  LoginServiceApi.h
//  Psf
//
//  Created by 燕来秋mac9 on 2018/8/1.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "BaseApi.h"
#import "LoginReq.h"
@interface LoginServiceApi : BaseApi
+ (instancetype)share;
///注册登录校验
-(void)requestLoginWithParam:(LoginReq *) req response:(responseModel) responseModel;
///发送验证码
-(void)sendVerCodeWithParam:(LoginReq *) req response:(responseModel) responseModel;
///密码登录
-(void)passWordLoginWithParam:(LoginReq *) req response:(responseModel) responseModel;
///保存手机号和密码（未注册情况）
-(void)savePassWordWithParam:(LoginReq *) req response:(responseModel) responseModel;
///验证码验证
-(void)validVerCodeWithParam:(LoginReq *) req response:(responseModel) responseModel;
///找回密码
-(void)retrievePasswordWithParam:(LoginReq *) req response:(responseModel) responseModel;
///微信登录
-(void)weChartLoginWithParam:(LoginReq *) req response:(responseModel) responseModel;
///绑定手机号获取验证码
-(void)bindPhoneWithParam:(LoginReq *) req response:(responseModel) responseModel;
@end
