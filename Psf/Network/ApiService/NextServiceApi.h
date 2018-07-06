//
//  NextServiceApi.h
//  Psf
//
//  Created by 燕来秋mac9 on 2018/6/21.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "BaseApi.h"
#import "StairCategoryReq.h"
#import "ZSConfig.h"
#import "StairCategoryRes.h"

@interface NextServiceApi : BaseApi
+ (instancetype)share;
- (void)requestApplyLoadWithParam:(StairCategoryReq *) req response:(responseModel) responseModel;
@end
