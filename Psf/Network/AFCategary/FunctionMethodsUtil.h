//
//  FunctionMethodsUtil.h
//  DistributionProject
//
//  Created by liujianzhong on 15/7/15.
//  Copyright © 2015年 T.E.N_. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZSAPIProxy.h"

@interface FunctionMethodsUtil : NSObject

/**获取当前显示的viewcontroller*/
+ (UIViewController *)getCurrentRootViewController;

/**获取设备UUID*/
+ (NSString *)genUUID;

/**
 根据服务返回的数据判断是否需要登录，如果需要登录，do it here.
 */
+ (void)doLoginCheckWithData:(id) responseObject isShow:(BOOL) isShow;

@end
