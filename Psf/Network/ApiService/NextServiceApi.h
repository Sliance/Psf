//
//  NextServiceApi.h
//  Psf
//
//  Created by 燕来秋mac9 on 2018/6/21.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "BaseApi.h"

@interface NextServiceApi : BaseApi
+ (instancetype)share;
- (void)requestApplyLoadWithParam:(NSDictionary *) dic response:(responseModel) responseModel;
@end
