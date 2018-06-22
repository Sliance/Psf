//
//  UserCacheBean.m
//  Psf
//
//  Created by 燕来秋mac9 on 2018/6/21.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "UserCacheBean.h"
#import "UserBaseInfoModel.h"
#import "UserDefaultCashe.h"

@implementation UserCacheBean
@synthesize userInfo = _userInfo;
+ (instancetype)share {
    static UserCacheBean *userCachebean = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (userCachebean == nil) {
            userCachebean = [[UserCacheBean alloc] init];
        }
    });
    return userCachebean;
}
- (UserBaseInfoModel *)userInfo {
    if (_userInfo == nil) {
        _userInfo = [[UserBaseInfoModel alloc] init];
    }
    return _userInfo;
}

- (void)setUserInfo:(UserBaseInfoModel *)userInfo {
    _userInfo = userInfo;
    NSDictionary *dic = [userInfo getUserInfoDictionary];
    [UserDefaultCashe casheDicWith:dic forKey:@"userinfo"];
}
@end
