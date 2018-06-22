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

- (NSString *)userId {
    if (_userId == nil) {
        _userId = @"";
    }
    return _userId;
}

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"userId"  : @"id",
             @"mobile"  : @"mobile",
             @"token"   : @"token",
             @"name"    : @"name",
             @"email"   : @"email",
             @"logo"    : @"logo"
             };
}

- (NSDictionary *)getUserInfoDictionary {
    if (self.token == nil) {
        return @{};
    }
    NSDictionary *dic = @{
                          @"userId" : self.userId == nil ?@"":self.userId,
                          @"mobile" : self.mobile == nil?@"":self.mobile,
                          @"token" : self.token == nil?@"":self.token,
                          @"name" : self.name == nil?@"":self.name,
                          @"email" : self.email == nil?@"":self.email,
                          @"logo" : self.logo == nil ?@"":self.logo
                          };
    return dic;
}

- (void)configUserInfoModelWithDic:(NSDictionary *) dic {
    self.userId = dic[@"userId"];
    self.mobile = dic[@"mobile"];
    self.token = dic[@"token"];
    self.name = dic[@"name"];
    self.email = dic[@"email"];
    self.logo = dic[@"logo"];
}

- (void)updateUserInfoModelWithDic:(NSDictionary *) dic {
    self.userId = dic[@"userId"] == nil?self.userId:dic[@"userId"];
    self.mobile = dic[@"mobile"] == nil?self.userId:dic[@"mobile"];
    self.token = dic[@"token"] == nil?self.userId:dic[@"token"];
    self.name = dic[@"token"] == nil?self.userId:dic[@"token"];
    self.email = dic[@"email"] == nil?self.userId:dic[@"email"];
    self.logo = dic[@"logo"] == nil?self.userId:dic[@"logo"];
}

@end
