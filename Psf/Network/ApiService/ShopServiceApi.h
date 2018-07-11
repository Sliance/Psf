//
//  ShopServiceApi.h
//  Psf
//
//  Created by 燕来秋mac9 on 2018/7/10.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "BaseApi.h"
#import "StairCategoryReq.h"
#import "ZSConfig.h"
#import "ShoppingListRes.h"

@interface ShopServiceApi : BaseApi
+ (instancetype)share;
///获取评价列表
- (void)requestShopListModelListLoadWithParam:(StairCategoryReq *) req response:(responseModel) responseModel;
@end
