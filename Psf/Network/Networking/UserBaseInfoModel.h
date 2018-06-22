//
//  UserBaseInfoModel.h
//  PropertyProject
//
//  Created by zhangshu on 15/12/2.
//  Copyright © 2015年 zhangshu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DSBaseModel.h"

@interface UserBaseInfoModel : DSBaseModel

@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *mobile;
@property (nonatomic, strong) NSString *token;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *logo;

- (NSDictionary *)getUserInfoDictionary;
- (void)configUserInfoModelWithDic:(NSDictionary *) dic;
- (void)updateUserInfoModelWithDic:(NSDictionary *) dic;

@end
