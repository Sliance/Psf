//
//  CircleServiseApi.h
//  Ypc
//
//  Created by zhangshu on 2019/1/8.
//  Copyright © 2019 zhangshu. All rights reserved.
//

#import "BaseApi.h"
#import "HomeReq.h"
#import "CircleCategaryRes.h"
#import "CircleListRes.h"

NS_ASSUME_NONNULL_BEGIN

@interface CircleServiseApi : BaseApi
+ (instancetype)share;
///圈子分类
-(void)getCircleSortWithParam:(HomeReq *) req response:(responseModel) responseModel;
///圈子分类列表
-(void)getCircleListWithParam:(HomeReq *) req response:(responseModel) responseModel;

@end

NS_ASSUME_NONNULL_END
