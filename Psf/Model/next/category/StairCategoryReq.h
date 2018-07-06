//
//  StairCategoryReq.h
//  Psf
//
//  Created by 燕来秋mac9 on 2018/7/6.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StairCategoryReq : NSObject
///品父类编号
@property(nonatomic,copy)NSString *productCategoryParentId;
///应用编号
@property(nonatomic,copy)NSString *appId;
///
@property(nonatomic,copy)NSString *token;
///客户端
@property(nonatomic,copy)NSString *platform;
///时间戳
@property(nonatomic,copy)NSString *timestamp;
@property(nonatomic,copy)NSString *userId;
@property(nonatomic,copy)NSString *version;
///
@property(nonatomic,copy)NSString *cityName;
///
@property(nonatomic,copy)NSString *couponType;
///
@property(nonatomic,copy)NSString *saleOrderStatus;
///
@property(nonatomic,copy)NSString *userLongitude;
///
@property(nonatomic,copy)NSString *userLatitude;
///
@property(nonatomic,copy)NSString *productId;
///
@property(nonatomic,copy)NSString *pageIndex;
///
@property(nonatomic,copy)NSString *pageSize;
///
@property(nonatomic,copy)NSString *saleOrderId;
///
@property(nonatomic,copy)NSString *cityId;
@end
