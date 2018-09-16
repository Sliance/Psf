//
//  AppDelegate.m
//  Psf
//
//  Created by 燕来秋mac9 on 2018/6/14.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "AppDelegate.h"
#import <UMShare/UMShare.h>
#import "UMSocialWechatHandler.h"
#import "WXApi.h"
#import "LoginServiceApi.h"
#import <AlipaySDK/AlipaySDK.h>

#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "ZSNotification.h"
#import "NextServiceApi.h"

@interface AppDelegate ()<WXApiDelegate,CLLocationManagerDelegate>
@property (nonatomic, strong) CLLocationManager *locationManagers;//定位管理
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _mainTabController = [[PsfTabBarController alloc] init];
    self.window.rootViewController = _mainTabController;
    [self.window makeKeyAndVisible];
    // UMConfigure 通用设置，请参考SDKs集成做统一初始化。
    /* 设置友盟appkey */
    
    // U-Share 平台设置
    [self configUSharePlatforms];
    [self confitUShareSettings];
    [WXApi registerApp:@"wx16b93fcfc9faba3c"];
    
    ///定位
    self.locationManagers = [[CLLocationManager alloc] init];
    self.locationManagers.delegate = self;
    self.locationManagers.desiredAccuracy = kCLLocationAccuracyBest;//选择定位经精确度
    self.locationManagers.distanceFilter = kCLDistanceFilterNone;
    //授权，定位功能必须得到用户的授权
    [self.locationManagers requestAlwaysAuthorization];
    [self.locationManagers requestWhenInUseAuthorization];
      [self.locationManagers startUpdatingLocation];
    [ZSNotification addRefreshLocationResultNotification:self action:@selector(refreshloc)];
    [UserCacheBean share].userInfo.latitude = @"0";
    [UserCacheBean share].userInfo.longitude = @"0";
    return YES;
}
-(void)refreshloc{
     [self.locationManagers startUpdatingLocation];
}

#pragma mark---定位
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    CLLocation *loc = [locations firstObject];
    
    //获得地理位置，把经纬度赋给我们定义的属性
    if ([NSString stringWithFormat:@"%f", loc.coordinate.latitude].length>0) {
         [UserCacheBean share].userInfo.latitude = [NSString stringWithFormat:@"%f", loc.coordinate.latitude];
    }else{
         [UserCacheBean share].userInfo.latitude = @"0";
    }
    if ([NSString stringWithFormat:@"%f", loc.coordinate.longitude].length>0) {
         [UserCacheBean share].userInfo.longitude = [NSString stringWithFormat:@"%f", loc.coordinate.longitude];
    }else{
         [UserCacheBean share].userInfo.longitude = @"0";
    }
   

    
    //根据获取的地理位置，获取位置信息
    CLGeocoder *geocoder = [[CLGeocoder alloc]init];
    __weak typeof(self)weakself = self;
    [geocoder reverseGeocodeLocation:loc completionHandler:^(NSArray<CLPlacemark *> *_Nullable placemarks, NSError * _Nullable error) {
        
        for (CLPlacemark *place in placemarks) {
            
            NSLog(@"name,%@",place.name);                      // 位置名
            
            NSLog(@"thoroughfare,%@",place.thoroughfare);      // 街道
            
            NSLog(@"subThoroughfare,%@",place.subThoroughfare);// 子街道
            
            NSLog(@"locality,%@",place.locality);              // 市
            
            NSLog(@"subLocality,%@",place.subLocality);        // 区
            
            NSLog(@"country,%@",place.country);                // 国家
        
            [UserCacheBean share].userInfo.thoroughfare = place.thoroughfare;
            [UserCacheBean share].userInfo.city = place.locality;
            [UserCacheBean share].userInfo.area = place.subLocality;
            [UserCacheBean share].userInfo.address = place.name;
            [ZSNotification postLocationResultNotification:@{@"address":@""}
             ];
        }
        
    }];
//    NSLog(@"纬度=%f，经度=%f",self.latitude,self.longitude);
   
    [self.locationManagers stopUpdatingLocation];
    
    
}

- (void)confitUShareSettings
{
    /*
     * 打开图片水印
     */
    //[UMSocialGlobal shareInstance].isUsingWaterMark = YES;
    /*
     * 关闭强制验证https，可允许http图片分享，但需要在info.plist设置安全域名
     <key>NSAppTransportSecurity</key>
     <dict>
     <key>NSAllowsArbitraryLoads</key>
     <true/>
     </dict>
     */
    //[UMSocialGlobal shareInstance].isUsingHttpsWhenShareContent = NO;
}
- (void)configUSharePlatforms
{
    /* 设置微信的appKey和appSecret */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:@"wx16b93fcfc9faba3c" appSecret:@"3e55d10c0ef98d2c32515293ee3cd2f5" redirectURL:@"http://mobile.umeng.com/social"];
    /*
     * 移除相应平台的分享，如微信收藏
     */
    //[[UMSocialManager defaultManager] removePlatformProviderWithPlatformTypes:@[@(UMSocialPlatformType_WechatFavorite)]];
    /* 设置分享到QQ互联的appID
     * U-Share SDK为了兼容大部分平台命名，统一用appKey和appSecret进行参数设置，而QQ平台仅需将appID作为U-Share的appKey参数传进即可。
     */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:@"1105821097"/*设置QQ平台的appID*/  appSecret:nil redirectURL:@"http://mobile.umeng.com/social"];
    /* 设置新浪的appKey和appSecret */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:@"3921700954"  appSecret:@"04b48b094faeb16683c32669824ebdad" redirectURL:@"https://sns.whalecloud.com/sina2/callback"];
    /* 支付宝的appKey */
    [[UMSocialManager defaultManager] setPlaform: UMSocialPlatformType_AlipaySession appKey:@"2015111700822536" appSecret:nil redirectURL:@"http://mobile.umeng.com/social"];


}
#pragma MARK - aliPay

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url sourceApplication:sourceApplication annotation:annotation];
    if (result) {
        return YES;
    }
    if ([url.host isEqualToString:@"safepay"]) {
        // 支付跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);

        }];

        // 授权跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processAuth_V2Result:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
            // 解析 auth code
            NSString *result = resultDic[@"result"];
            NSString *authCode = nil;
            if (result.length>0) {
                NSArray *resultArr = [result componentsSeparatedByString:@"&"];
                for (NSString *subResult in resultArr) {
                    if (subResult.length > 10 && [subResult hasPrefix:@"auth_code="]) {
                        authCode = [subResult substringFromIndex:10];
                        break;
                    }
                }
            }
            NSLog(@"授权结果 authCode = %@", authCode?:@"");
        }];

    }
    return YES;
}
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options
{
    
    if ([url.host isEqualToString:@"pay"]) {//微信支付
        [WXApi handleOpenURL:url delegate:self];
    }
    if ([url.host isEqualToString:@"oauth"]) {//微信登录
        [WXApi handleOpenURL:url delegate:self];
    }
    if ([url.host isEqualToString:@"safepay"]) {
        // 支付跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
            if ([resultDic[@"resultStatus"] integerValue] ==9000) {
                 [ZSNotification postAlipayPayResultNotification:@{@"strMsg":@"支付成功"}];
            }else{
                [ZSNotification postAlipayPayResultNotification:@{@"strMsg":resultDic[@"memo"]}];
            }
            
        }];
        
        // 授权跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processAuth_V2Result:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
            // 解析 auth code
            NSString *result = resultDic[@"result"];
            NSString *authCode = nil;
            if (result.length>0) {
                NSArray *resultArr = [result componentsSeparatedByString:@"&"];
                for (NSString *subResult in resultArr) {
                    if (subResult.length > 10 && [subResult hasPrefix:@"auth_code="]) {
                        authCode = [subResult substringFromIndex:10];
                        break;
                    }
                }
            }
            NSLog(@"授权结果 authCode = %@", authCode?:@"");
        }];
    }
    
    
    return YES;
}
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
//    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
//    if (!result) {
//        // 其他如支付等SDK的回调
//    }
//    return result;
    return [WXApi handleOpenURL:url delegate:self];
}
//微信代理方法
- (void)onResp:(BaseResp *)resp
{
    
    SendAuthResp *aresp = (SendAuthResp *)resp;
    if(aresp.errCode== 0 && [aresp.state isEqualToString:@"LxnScheme"])
    {
        NSString *code = aresp.code;
        [self getWeiXinOpenId:code];
    }
    NSString * strMsg = [NSString stringWithFormat:@"errorCode: %d",resp.errCode];
    NSLog(@"strMsg: %@",strMsg);
    
    NSString * errStr       = [NSString stringWithFormat:@"errStr: %@",resp.errStr];
    NSLog(@"errStr: %@",errStr);
    
    
    NSString * strTitle;
    //判断是微信消息的回调 --> 是支付回调回来的还是消息回调回来的.
    if ([resp isKindOfClass:[SendMessageToWXResp class]])
    {
        strTitle = [NSString stringWithFormat:@"发送媒体消息的结果"];
    }
    
    NSString * wxPayResult;
    //判断是否是微信支付回调 (注意是PayResp 而不是PayReq)
    
    if ([resp isKindOfClass:[PayResp class]])
    {
        //支付返回的结果, 实际支付结果需要去微信服务器端查询
        strTitle = [NSString stringWithFormat:@"支付结果"];
        switch (resp.errCode)
        {
            case WXSuccess:
            {
                strMsg = @"支付成功";
                NSLog(@"支付成功: %d",resp.errCode);
                wxPayResult = @"success";
               
                break;
            }
            case WXErrCodeUserCancel:
            {
                strMsg = @"用户取消了支付";
                NSLog(@"用户取消支付: %d",resp.errCode);
                wxPayResult = @"cancel";
                break;
            }
            default:
            {
                strMsg =  @"支付失败";//[NSString stringWithFormat:@"支付失败! code: %d  errorStr: %@",resp.errCode,resp.errStr];
                NSLog(@":支付失败: code: %d str: %@",resp.errCode,resp.errStr);
                wxPayResult = @"faile";
                break;
            }
        }
       [ZSNotification postWeixinPayResultNotification:@{@"weixinpay": wxPayResult,@"strMsg":strMsg}];
    }
}


//通过code获取access_token，openid，unionid
- (void)getWeiXinOpenId:(NSString *)code{
    NSString *AppId = @"wx16b93fcfc9faba3c";
    NSString *AppSerect = @"1a149ee1179985fd7bebb9a46b593158";
    NSString *url =[NSString stringWithFormat:@"https://api.weixin.qq.com/sns/oauth2/access_token?appid=%@&secret=%@&code=%@&grant_type=authorization_code",AppId,AppSerect,code];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURL *zoneUrl = [NSURL URLWithString:url];
        NSString *zoneStr = [NSString stringWithContentsOfURL:zoneUrl encoding:NSUTF8StringEncoding error:nil];
        NSData *data = [zoneStr dataUsingEncoding:NSUTF8StringEncoding];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (data){ 
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                NSString *openID = dic[@"openid"];
                NSString *token = dic[@"access_token"];

                [self getWeiXintoken:token OpenId:openID];
            }
        });
    });
    
}

- (void)getWeiXintoken:(NSString *)token OpenId:(NSString*)openid{
    
    NSString *url =[NSString stringWithFormat:@"https://api.weixin.qq.com/sns/userinfo?access_token=%@&openid=%@",token,openid];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURL *zoneUrl = [NSURL URLWithString:url];
        NSString *zoneStr = [NSString stringWithContentsOfURL:zoneUrl encoding:NSUTF8StringEncoding error:nil];
        NSData *data = [zoneStr dataUsingEncoding:NSUTF8StringEncoding];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (data){
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                NSLog(@"%@",dic);
                LoginReq *req = [[LoginReq alloc]init];
                req.memberArea = dic[@"city"];
                req.nickname = dic[@"nickname"];
                req.avatar = dic[@"headimgurl"];
                req.memberGender = dic[@"sex"];
                req.appOpenId = dic[@"openid"];
                req.wechatUnionId = dic[@"unionid"];
                req.appId = @"993335466657415169";
                req.timestamp = @"529675086";
                
                req.platform = @"ios";
                
                if ([UserCacheBean share].userInfo.token.length>1) {
                    req.token = [UserCacheBean share].userInfo.token;
                    
                    [self bindWX:req];
                }else{
                    req.openId = @"";
                    req.memberEmail = @"";
                    req.memberMobile = @"";
                    req.memberBirthday = @"";
                    req.memberPassword = @"";
                    req.memberAvatarId = @"";
                    req.memberAccount = @"";
                    req.token = @"";
                    [self weChartLogin:req];
                }
                
            }
        });
    });
}
-(void)bindWX:(LoginReq*)req{
    [[LoginServiceApi share]bindWXWithParam:req response:^(id response) {
        if ([response[@"code"]integerValue] ==200) {
            [ZSNotification postWeixinLoginResultNotification:@{@"type":@"bind"}];
        }else{
            
        }
    
    }];
}
-(void)weChartLogin:(LoginReq*)req{
    [[LoginServiceApi share]weChartLoginWithParam:req response:^(id response) {
        if (response) {
            NSError *error = nil;
            UserBaseInfoModel *userInfoModel = [MTLJSONAdapter modelOfClass:UserBaseInfoModel.class fromJSONDictionary:response[@"data"] error:&error];
            [UserCacheBean share].userInfo = userInfoModel;
            [ZSNotification postWeixinLoginResultNotification:@{@"type":@"login"}];
            [ZSNotification postRefreshLocationResultNotification:nil];
        }
    }];
}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
