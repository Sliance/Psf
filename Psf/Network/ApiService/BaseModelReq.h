//
//  BaseModelReq.h
//  Etram
//
//  Created by 燕来秋mac9 on 2018/9/21.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseModelReq : NSObject
///应用编号
@property(nonatomic,copy)NSString *appId;
///
@property(nonatomic,copy)NSString *token;
///客户端
@property(nonatomic,strong)NSString *platform;
///时间戳
@property(nonatomic,copy)NSString *timestamp;
///页数
@property(nonatomic,assign)NSInteger pageIndex;
///每页个数
@property(nonatomic,copy)NSString *pageSize;
@property(nonatomic,copy)NSString *version;
///门店id
@property(nonatomic,copy)NSString *storeId;
@property(nonatomic,copy)NSString *cityName;
@property(nonatomic,copy)NSString *cityId;
@property(nonatomic,copy)NSString *userLatitude;
@property(nonatomic,copy)NSString *userLongitude;
@end
