//
//  GroupServiceApi.h
//  Psf
//
//  Created by 燕来秋mac9 on 2018/7/13.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "BaseApi.h"
#import "StairCategoryReq.h"
#import "GroupListRes.h"
#import "GroupModelReq.h"
#import "GroupBannerModel.h"
#import "CalculateReq.h"
#import "CalculateThePriceRes.h"
#import "PlaceOrderReq.h"
#import "SpellGroupModel.h"
#import "PlaceOrderRes.h"
#import "PresaleListRes.h"

@interface GroupServiceApi : BaseApi
+ (instancetype)share;
///获取团购信息表
- (void)getGroupListWithParam:(StairCategoryReq *) req response:(responseModel) responseModel;
///获取正在拼团信息列表
- (void)spellGroupListWithParam:(StairCategoryReq *) req response:(responseModel) responseModel;
///团购价格计算
- (void)getGroupPriceWithParam:(CalculateReq *) req response:(responseModel) responseModel;
///团购详情
- (void)getDetailGroupWithParam:(StairCategoryReq *) req response:(responseModel) responseModel;
///团购下单
- (void)saveGroupWithParam:(PlaceOrderReq *) req response:(responseModel) responseModel;
///获取预售信息列表
- (void)getPresaleListWithParam:(StairCategoryReq *) req response:(responseModel) responseModel;
///获取预售、团购banner
- (void)getPreAndGroupBannerWithParam:(GroupModelReq *) req response:(responseModel) responseModel;
///预售价格计算
- (void)getPresalePriceWithParam:(CalculateReq *) req response:(responseModel) responseModel;
///预售下单
- (void)savePresaleWithParam:(PlaceOrderReq *) req response:(responseModel) responseModel;
///获取门店分类列表
- (void)getStoreSortWithParam:(StairCategoryReq *) req response:(responseModel) responseModel;
///获取门店商品列表
- (void)StoreGoodListWithParam:(StairCategoryReq *) req response:(responseModel) responseModel;


@end
