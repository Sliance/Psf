//
//  GoodDetailRes.h
//  Psf
//
//  Created by 燕来秋mac9 on 2018/7/9.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProductSkuModel.h"
@interface GoodDetailRes : NSObject
///商品编号
@property(nonatomic,assign)NSInteger productId;
///商品名称
@property(nonatomic,copy)NSString *productName;
///商品类型
@property(nonatomic,copy)NSString *productType;
///商品标题
@property(nonatomic,copy)NSString *productTitle;
///商品价格
@property(nonatomic,copy)NSString *productPrice;
///
@property(nonatomic,copy)NSString *productUnit;
///
//@property(nonatomic,copy)NSNumber *productWeight;
@property(nonatomic,copy)NSString *productImagePath;
///
@property(nonatomic,strong)NSArray *productImageList;
///已售份数
@property(nonatomic,assign)NSInteger productSaleCount;
///商品信息
@property(nonatomic,copy)NSString *productContent;
///团购编号
@property(nonatomic,assign)NSInteger grouponId;
///团购数量
@property(nonatomic,assign)NSInteger saleOrderProductQty;
///商品产地
@property(nonatomic,copy)NSString *productBirthPlace;
///满减编号
@property(nonatomic,copy)NSNumber *rewardId;
///商品分类编号
@property(nonatomic,copy)NSString *productCategoryId;
///满减名称
@property(nonatomic,copy)NSString *rewardName;
///商品规格编号
@property(nonatomic,assign)NSInteger productSkuId;
///满减生效时间
@property(nonatomic,copy)NSString *rewardValidTime;
///团购价格
@property(nonatomic,copy)NSString *grouponPrice;
///预售生效时间
@property(nonatomic,copy)NSString *preSaleValidTime;
///满减过期时间
@property(nonatomic,copy)NSString *rewardExpireTime;
///团购会员限制
@property(nonatomic,copy)NSString *grouponMemberLimit;
///预售过期时间
@property(nonatomic,copy)NSString *preSaleExpireTime;
///满减商品类型
@property(nonatomic,copy)NSString *rewardProductType;
///团购生效时间
@property(nonatomic,copy)NSString *grouponValidTime;
///预售到货时间
@property(nonatomic,copy)NSString *preSaleDeliveryTime;
///预售编号
@property(nonatomic,assign)NSInteger preSaleId;
///团购过期时间
@property(nonatomic,copy)NSString *grouponExpireTime;
///团购活动失效小时
@property(nonatomic,copy)NSString *grouponActiveExpireHour;
///商品SKU
@property(nonatomic,strong)NSArray *productSkuList;
//预售（多少人购买）
@property(nonatomic,assign)NSInteger preSaleQuantity;
//购买上限
@property(nonatomic,assign)NSInteger preSaleLimitQuantity;
//是否截单
@property(nonatomic,assign)BOOL preSaleIsComplete;


@end
