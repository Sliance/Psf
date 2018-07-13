//
//  AddressBaeReq.h
//  Psf
//
//  Created by 燕来秋mac9 on 2018/7/12.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AddressBaeReq : NSObject
///应用编号
@property(nonatomic,copy)NSString *appId;
///
@property(nonatomic,copy)NSString *token;
///客户端
@property(nonatomic,strong)NSString *platform;
///时间戳
@property(nonatomic,copy)NSString *timestamp;
///会员地址编号
@property(nonatomic,copy)NSString *memberAddressId;
@property(nonatomic,copy)NSString *systemVersion;
@end
