//
//  GroupModelReq.h
//  Psf
//
//  Created by 燕来秋mac9 on 2018/7/13.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GroupModelReq : NSObject
///preSale、Groupon
@property(nonatomic,copy)NSString* productBannerPosition;
///(181)
@property(nonatomic,copy)NSString *erpStoreId;
///应用编号
@property(nonatomic,copy)NSString *appId;
///
@property(nonatomic,copy)NSString *token;
///客户端
@property(nonatomic,strong)NSString *platform;
///时间戳
@property(nonatomic,copy)NSString *timestamp;

@property(nonatomic,copy)NSString *version;
///
@property(nonatomic,copy)NSString *cityName;
@end
