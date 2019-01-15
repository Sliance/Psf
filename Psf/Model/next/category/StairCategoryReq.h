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

@property(nonatomic,copy)NSString* productCategoryId;
///应用编号
@property(nonatomic,copy)NSString *appId;
///
@property(nonatomic,copy)NSString *token;
///(181)
@property(nonatomic,copy)NSString *erpStoreId;
///客户端
@property(nonatomic,strong)NSString *platform;
///时间戳
@property(nonatomic,copy)NSString *timestamp;
@property(nonatomic,copy)NSString *userId;
@property(nonatomic,copy)NSString *version;
///
@property(nonatomic,copy)NSString *cityName;

///(空、全部  0、待付款  1、待发货  2、待收货 3、待评价 4、退款/售后 5、已取消 6、已完成 7、门店自提已收货)
@property(nonatomic,copy)NSString *saleOrderStatus;
///
@property(nonatomic,copy)NSString *userLongitude;
///
@property(nonatomic,copy)NSString *userLatitude;
///商品编号
@property(nonatomic,assign)NSInteger productId;
///
@property(nonatomic,copy)NSString *productName;
///商品规格编号
@property(nonatomic,copy)NSString *productSkuId;
///商品数量
@property(nonatomic,copy)NSString* productQuantity;
///
@property(nonatomic,assign)NSInteger pageIndex;
///
@property(nonatomic,copy)NSString *pageSize;
///
@property(nonatomic,copy)NSString *saleOrderId;
///
@property(nonatomic,copy)NSString *cityId;

///购物车编号(全选或者反选购物车信息)
@property(nonatomic,copy)NSString *cartId;
///购物车商品编号(选中单条购物车信息)
@property(nonatomic,copy)NSNumber *cartProductId;
///购物车商品是否选中
@property(nonatomic,assign)NSInteger cartProductIsActive;

@property(nonatomic,copy)NSString *goodsCategoryId;
///商品编号列表
@property(nonatomic,strong)NSArray *saleOrderProductList;
///优惠券类型（singleProduct单品，allProduct全场）
@property(nonatomic,copy)NSString *couponType;
@property(nonatomic,assign)NSInteger couponId;
///专题位置(@"1+2")
@property(nonatomic,copy)NSString*subjectPosition;
///自定义专题
@property(nonatomic,copy)NSString*subjectId;

@property(nonatomic,copy)NSString*updateType;
///充值规则编号
@property(nonatomic,copy)NSString *memberRechargeRuleId;
@property(nonatomic,copy)NSString* erpProductId;
///erp的会员编号
@property(nonatomic,copy)NSString*erpCustomerNo;
///称重重量（加购物车用）
@property(nonatomic,copy)NSString*saleOrderProductWeight;

@property(nonatomic,copy)NSString *businessParamKey;

@property(nonatomic,copy)NSString *saleOrderProductId;
@property(nonatomic,copy)NSString *sign;
@property(nonatomic,copy)NSString *epicureId;

@end
