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


@property (nonatomic, strong) NSString *token;
@property (nonatomic, strong) NSString *memberNickName;
@property(nonatomic,strong)NSString *memberAvatarPath;
@property(nonatomic,strong)NSString *memberMobile;


- (NSDictionary *)getUserInfoDictionary;
- (void)configUserInfoModelWithDic:(NSDictionary *) dic;
- (void)updateUserInfoModelWithDic:(NSDictionary *) dic;

@end
