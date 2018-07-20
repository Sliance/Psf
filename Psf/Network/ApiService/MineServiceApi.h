//
//  MineServiceApi.h
//  Psf
//
//  Created by 燕来秋mac9 on 2018/7/19.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "BaseApi.h"
#import "StairCategoryReq.h"
#import "MineInformationReq.h"
@interface MineServiceApi : BaseApi
+ (instancetype)share;
///获取单条会员余额和积分信息
- (void)getMemberBalanceWithParam:(StairCategoryReq *) req response:(responseModel) responseModel;
///获取单条会员信息
- (void)getMemberInformationWithParam:(StairCategoryReq *) req response:(responseModel) responseModel;
///修改会员信息
- (void)updateMemberInformationWithParam:(MineInformationReq *) req response:(responseModel) responseModel;
@end
