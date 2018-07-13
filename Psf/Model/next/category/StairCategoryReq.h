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
@property(nonatomic,strong)NSString *platform;
///时间戳
@property(nonatomic,copy)NSString *timestamp;
@property(nonatomic,copy)NSString *userId;
@property(nonatomic,copy)NSString *version;
///
@property(nonatomic,copy)NSString *cityName;

///
@property(nonatomic,copy)NSString *saleOrderStatus;
///
@property(nonatomic,copy)NSString *userLongitude;
///
@property(nonatomic,copy)NSString *userLatitude;
///商品编号
@property(nonatomic,copy)NSString *productId;
///商品规格编号
@property(nonatomic,copy)NSString *productSkuId;
///商品数量
@property(nonatomic,copy)NSNumber *productQuantity;
///
@property(nonatomic,copy)NSString *pageIndex;
///
@property(nonatomic,copy)NSString *pageSize;
///
@property(nonatomic,copy)NSString *saleOrderId;
///
@property(nonatomic,copy)NSString *cityId;

///购物车编号(全选或者反选购物车信息)
@property(nonatomic,copy)NSString *cartId;
///购物车商品编号(选中单条购物车信息)
@property(nonatomic,copy)NSString *cartProductId;
///购物车商品是否选中
@property(nonatomic,assign)NSInteger cartProductIsActive;

@property(nonatomic,copy)NSString *goodsCategoryId;
///商品编号列表
@property(nonatomic,copy)NSString *saleOrderProductList;
///优惠券类型（singleProduct单品，allProduct全场）
@property(nonatomic,copy)NSString *couponType;

@end
