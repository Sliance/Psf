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
#import "IntegralRecord.h"
#import "RechargeRuleModel.h"
#import "FeetbackReq.h"
#import "OrderPayRes.h"


@interface MineServiceApi : BaseApi
+ (instancetype)share;
///获取单条会员余额和积分信息
- (void)getMemberBalanceWithParam:(StairCategoryReq *) req response:(responseModel) responseModel;
///获取会员积分明细信息
- (void)getMemberBalanceHistoryWithParam:(StairCategoryReq *) req response:(responseModel) responseModel;
///获取单条会员信息
- (void)getMemberInformationWithParam:(StairCategoryReq *) req response:(responseModel) responseModel;
///修改会员信息
- (void)updateMemberInformationWithParam:(MineInformationReq *) req response:(responseModel) responseModel;
///获取会员充值规则表列表
- (void)rechargeMemberBalanceWithParam:(StairCategoryReq *) req response:(responseModel) responseModel;
///交易记录
- (void)rechargeRecordWithParam:(StairCategoryReq *) req response:(responseModel) responseModel;
///意见反馈
- (void)feedBackWithParam:(FeetbackReq *) req response:(responseModel) responseModel;
///支付宝充值
- (void)topUpWithParam:(StairCategoryReq *) req response:(responseModel) responseModel;
///微信充值
- (void)wxTopUpWithParam:(StairCategoryReq *) req response:(responseModel) responseModel;
///充值是否开启 
- (void)openTopUpWithParam:(StairCategoryReq *) req response:(responseModel) responseModel;

@end
