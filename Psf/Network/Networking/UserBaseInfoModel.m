//
//  UserBaseInfoModel.m
//  PropertyProject
//
//  Created by zhangshu on 15/12/2.
//  Copyright © 2015年 zhangshu. All rights reserved.
//

#import "UserBaseInfoModel.h"

@implementation UserBaseInfoModel
- (NSString *)token {
    if (_token == nil || _token.length == 0) {
        _token = @"";
    }
    return _token;
}


+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
            
             @"token"   : @"token",
             @"memberNickName"    : @"memberNickName",
             @"memberAvatarPath" : @"memberAvatarPath"
            , @"memberMobile" : @"memberMobile"
             ,@"openid":@"openid"};
}

- (NSDictionary *)getUserInfoDictionary {
    if (self.token == nil) {
        return @{};
    }
    NSDictionary *dic = @{

                          @"token" : self.token == nil?@"":self.token,
                          @"memberNickName" : self.memberNickName == nil?@"":self.memberNickName,@"memberAvatarPath" : self.memberAvatarPath == nil?@"":self.memberAvatarPath,
                         @"memberMobile" : self.memberMobile == nil?@"":self.memberMobile,
                          @"openid" : self.openid == nil?@"":self.openid,};
    return dic;
}

- (void)configUserInfoModelWithDic:(NSDictionary *) dic {

    self.token = dic[@"token"];
    self.memberNickName = dic[@"memberNickName"];
    self.memberAvatarPath = dic[@"memberAvatarPath"];
    self.memberMobile = dic[@"memberMobile"];
    self.openid = dic[@"opeid"];
}

- (void)updateUserInfoModelWithDic:(NSDictionary *) dic {

    self.token = dic[@"token"] ;
    self.memberNickName = dic[@"memberNickName"] ;
    self.memberAvatarPath = dic[@"memberAvatarPath"] ;
    self.memberMobile = dic[@"memberMobile"];
    self.openid = dic[@"openid"];
}

@end
