//
//  CouponServiceApi.h
//  Psf
//
//  Created by 燕来秋mac9 on 2018/7/13.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "BaseApi.h"
#import "StairCategoryReq.h"
@interface CouponServiceApi : BaseApi
+ (instancetype)share;
///获取商品对应的优惠券
- (void)requestCouponListLoadWithParam:(StairCategoryReq *) req response:(responseModel) responseModel;
///获取优惠券列表（我的）
- (void)requestMineCouponListWithParam:(StairCategoryReq *) req response:(responseModel) responseModel;
///获取优惠券列表（填写订单时）
- (void)fillOrderCouponWithParam:(StairCategoryReq *) req response:(responseModel) responseModel;
///领取优惠券
- (void)saveCouponWithParam:(StairCategoryReq *) req response:(responseModel) responseModel;

@end
