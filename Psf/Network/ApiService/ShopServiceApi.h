//
//  ShopServiceApi.h
//  Psf
//
//  Created by 燕来秋mac9 on 2018/7/10.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "BaseApi.h"
#import "StairCategoryReq.h"
#import "ShoppingListRes.h"
#import "StairCategoryListRes.h"
#import "CalculateReq.h"
#import "CalculateThePriceRes.h"
#import "PlaceOrderReq.h"
#import "PlaceOrderRes.h"

@interface ShopServiceApi : BaseApi
+ (instancetype)share;
///获取购物车列表
- (void)requestShopListModelListLoadWithParam:(StairCategoryReq *) req response:(responseModel) responseModel;
///选中单条购物车信息
- (void)requestShopCartSelectedSingleWithParam:(StairCategoryReq *) req response:(responseModel) responseModel;
///全选或者反选购物车信息
- (void)requestShopCartSelectedAllWithParam:(StairCategoryReq *) req response:(responseModel) responseModel;
///清空购物车失效商品
- (void)clearLoseProductWithParam:(StairCategoryReq *) req response:(responseModel) responseModel;
///获取购物车数量
- (void)getShopCartCountWithParam:(StairCategoryReq *) req response:(responseModel) responseModel;
///新增购物车信息
- (void)addShopCartCountWithParam:(StairCategoryReq *) req response:(responseModel) responseModel;
///修改购物车信息
- (void)changeShopCartCountWithParam:(StairCategoryReq *) req response:(responseModel) responseModel;
///猜你喜欢
- (void)guessYouLikeWithParam:(StairCategoryReq *) req response:(responseModel) responseModel;
///填写订单计算价格
-(void)CalculateThePriceWithParam:(CalculateReq*)req response:(responseModel) responseModel;
///下单
-(void)placeThePriceWithParam:(PlaceOrderReq*)req response:(responseModel) responseModel;
///结算列表
-(void)settlementListWithParam:(PlaceOrderReq*)req response:(responseModel) responseModel;


@end
