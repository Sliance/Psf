//
//  FunctionMethodsUtil.m
//  DistributionProject
//
//  Created by liujianzhong on 15/7/15.
//  Copyright © 2015年 T.E.N_. All rights reserved.
//

#import "FunctionMethodsUtil.h"
#import "LoginViewController.h"
#import "UserBaseInfoModel.h"
#import "UserCacheBean.h"

//#import "MyNavigationViewController.h"
//#import "AuxiliaryTool.h"
@implementation FunctionMethodsUtil

/**获取当前显示的viewcontroller*/
+ (UIViewController *)getCurrentRootViewController {
    UIViewController *result;
    UIWindow *topWindow = [[UIApplication sharedApplication] keyWindow];
    if (topWindow.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(topWindow in windows)
        {
            if (topWindow.windowLevel == UIWindowLevelNormal)
                break;
        }
    }
    if ([[topWindow subviews] count] <=0) {
        return result;
    }
    UIView *rootView = [[topWindow subviews] objectAtIndex:0];
    id nextResponder = [rootView nextResponder];
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else if ([topWindow respondsToSelector:@selector(rootViewController)] && topWindow.rootViewController != nil)
        result = topWindow.rootViewController;
    return result;
}

/**获取设备UUID*/
+ (NSString *)genUUID
{
    CFUUIDRef uuidRef = CFUUIDCreate(NULL);
    CFStringRef str = CFUUIDCreateString(NULL, uuidRef);
    NSString *tmp = (NSString *)CFBridgingRelease(str);
    CFRelease(uuidRef);
    return tmp;
}

/**
 服务自动判断是否重新登录
 */
+ (void)loginAgain {
    //先清除本地缓存登录信息
    UserBaseInfoModel *user = [[UserBaseInfoModel alloc] init];
    [[UserCacheBean share] setUserInfo:user];
    UIViewController *controller = [FunctionMethodsUtil getCurrentRootViewController];
    if (! [[self getCurrentRootViewController] isKindOfClass:[LoginViewController class]]) {
        LoginViewController *loginVC = [[LoginViewController alloc]init];
        UINavigationController *loginNav = [[UINavigationController alloc]initWithRootViewController:loginVC];
        [controller presentViewController:loginNav animated:YES completion:nil];
    }
}
/**
 根据服务返回的数据判断是否需要登录，如果需要登录，do it here.
 每个服务成功请求的前提是用户已经登录成功，所以当用户token过期了，服务端返回一个状态码，我们通过状态码调出登录界面
 */
+ (void)doLoginCheckWithData:(id) responseObject isShow:(BOOL) isShow {
    if ([responseObject isKindOfClass:[NSData class]]) {
        NSError *error = nil;
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&error];
        NSLog(@"请求接口返回的Code>>>>> %@", [NSString stringWithFormat:@"%@", dict[@"code"]]);
        if ([dict[@"code"] integerValue] != 0  && [dict[@"code"] integerValue] != 404 ){
                if([dict[@"code"] integerValue] == 33333){//33333表示表示被踢掉 需要重新登录
                    if ([UserCacheBean share].userInfo.token.length > 1) {//有Token 表示是登录之后发生的特殊情况 没有Token 的时候发生特殊情况不用做出提示
                        [[ZSAPIProxy shareProxy] cancelAllRequest];//取消其他所有请求
                        [FunctionMethodsUtil loginAgain];
                        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:[NSString stringWithFormat:@"%@", dict[@"message"]] delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
                        [alertView show];
                    }else{
                    }
                }else{
                    [[ZSAPIProxy shareProxy] cancelAllRequest];//取消其他所有请求
                    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:[NSString stringWithFormat:@"%@", dict[@"message"]] delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
                    [alertView show];
                }
        }
        if ([dict[@"code"] integerValue] == 404) {
        }
    }
}

@end
