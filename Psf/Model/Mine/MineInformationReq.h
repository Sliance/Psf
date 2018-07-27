//
//  MineInformationReq.h
//  Psf
//
//  Created by 燕来秋mac9 on 2018/7/19.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MineInformationReq : NSObject
///会员头像ID
@property(nonatomic,copy)NSString* memberAvatarId;
///会员头像路径
@property(nonatomic,copy)NSString*memberAvatarPath;
///会员生日
@property(nonatomic,copy)NSString*memberBirthday;
///会员性别
@property(nonatomic,copy)NSString*memberGender;
///会员昵称
@property(nonatomic,copy)NSString*memberNickName;
@property(nonatomic,copy)NSString*memberMobile;
///应用编号
@property(nonatomic,copy)NSString*appId;
///
@property(nonatomic,copy)NSString*token;
///客户端
@property(nonatomic,copy)NSString*platform;
///
@property(nonatomic,copy)NSString*timestamp;

@end
