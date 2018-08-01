//
//  UserCacheBean.h
//  Psf
//
//  Created by 燕来秋mac9 on 2018/6/21.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserBaseInfoModel.h"

@interface UserCacheBean : NSObject

@property (nonatomic, strong) UserBaseInfoModel *userInfo;

+ (instancetype)share;
- (BOOL)isLogin;
- (void)loginOut;

@end
