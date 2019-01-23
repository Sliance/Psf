//
//  CartProductModel.h
//  Psf
//
//  Created by 燕来秋mac9 on 2018/7/10.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface CartProductModel : NSObject
///
@property(nonatomic,copy)NSString *appId;
///购物车编号
@property(nonatomic,copy)NSNumber *cartId;
///
@property(nonatomic,assign)NSInteger cartProductIsActive;
///
@property(nonatomic,assign)NSInteger productId;
@property(nonatomic,copy)NSString* erpProductId;
///
@property(nonatomic,copy)NSNumber *productImageId;
///
@property(nonatomic,copy)NSString *productImagePath;
///
@property(nonatomic,copy)NSString *productPayPrice;
///
@property(nonatomic,copy)NSString *productName;

///0，计数，1.称重，2.69码(计数
@property(nonatomic,assign)NSInteger productStyle;
///
@property(nonatomic,copy)NSString *productPrice;
@property(nonatomic,copy)NSString * productStorePrice;
///
@property(nonatomic,copy)NSString* productQuantity;
///
@property(nonatomic,assign)NSInteger productSkuId;
///
@property(nonatomic,copy)NSString *productSkuPrice;
///
@property(nonatomic,copy)NSString *productTitle;
///
@property(nonatomic,copy)NSString *productUnit;
///
@property(nonatomic,copy)NSNumber *cartProductId;
///
@property(nonatomic,copy)NSString *systemCreateTime;
///
@property(nonatomic,copy)NSString *systemCreateUserId;
///
@property(nonatomic,assign)NSInteger systemStatus;
///
@property(nonatomic,assign)NSInteger systemVersion;
///
@property(nonatomic,copy)NSString *systemUpdateTime;
///
@property(nonatomic,copy)NSString *systemUpdateUserId;
///
@property(nonatomic,assign)BOOL productIsOnSale;
///
@property(nonatomic,copy)NSString* saleOrderProductQty;
///
@property(nonatomic,copy)NSString* saleOrderProductId;
///
@property(nonatomic,copy)NSString *saleOrderId;

@property(nonatomic,assign)CGFloat cellH;

@property(nonatomic,assign)NSInteger index;
///是否预售
@property(nonatomic,assign)BOOL productIsPreSale;
///是否次日达
@property(nonatomic,assign)BOOL productIsSaleNextDay;
///是否促销
@property(nonatomic,assign)BOOL productIsSalePromotion;
///是否团购
@property(nonatomic,assign)BOOL productIsGroupon;
///是否满减
@property(nonatomic,assign)BOOL productIsWard;

///售后（refund）；正常（normal）
@property(nonatomic,copy)NSString *saleOrderProductStatus;
@property(nonatomic,copy)NSString *ingredientsCategoryId;

@end
