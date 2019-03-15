//
//  NextServiceApi.h
//  Psf
//
//  Created by 燕来秋mac9 on 2018/6/21.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "BaseApi.h"
#import "StairCategoryReq.h"
#import "StairCategoryRes.h"
#import "GoodDetailRes.h"
#import "EvaluateListRes.h"
#import "SubjectCategoryModel.h"
#import "SubjectModel.h"
#import "FillEvaluateReq.h"
#import "TopicsListRes.h"
#import "CircleListRes.h"
#import "DetailRecipeRes.h"
#import "RecipeCollectModel.h"
#import "TimeBuyModel.h"
#import "DNCommentList.h"


@interface NextServiceApi : BaseApi
+ (instancetype)share;
///商品分类列表,包含一二级分类
- (void)requestApplyLoadWithParam:(StairCategoryReq *) req response:(responseModel) responseModel;
///获取分类下商品信息
- (void)requestSortListLoadWithParam:(StairCategoryReq *) req response:(responseModel) responseModel;
///商品详情页
- (void)requestGoodDetailLoadWithParam:(StairCategoryReq *) req response:(responseModel) responseModel;
///获取推荐商品列表
- (void)requestRecommendListLoadWithParam:(StairCategoryReq *) req response:(responseModel) responseModel;
///获取爆款商品列表
- (void)requestHotListLoadWithParam:(StairCategoryReq *) req response:(responseModel) responseModel;

///获取评价列表
- (void)requestEvaluateListModelListLoadWithParam:(StairCategoryReq *) req response:(responseModel) responseModel;
///自定义专题
- (void)requestHomeLoadWithParam:(StairCategoryReq *) req response:(responseModel) responseModel;
///banner
- (void)requestBannerWithParam:(StairCategoryReq *) req response:(responseModel) responseModel;
///搜索商品提示列表
- (void)SearchHintListWithParam:(StairCategoryReq *) req response:(responseModel) responseModel;
///搜索商品列表
- (void)SearchDataListWithParam:(StairCategoryReq *) req response:(responseModel) responseModel;
///新增销售订单商品评论信息
- (void)fillEvaluatetWithParam:(FillEvaluateReq *) req response:(responseModel) responseModel;

///根据分类编号查询商品列表
- (void)getCategoryListWithParam:(StairCategoryReq *) req response:(responseModel) responseModel;
///企业合作
- (void)businessCooperationWithParam:(StairCategoryReq *) req response:(responseModel) responseModel;

///次日达列表
- (void)nextDayWithParam:(StairCategoryReq *) req response:(responseModel) responseModel;


///获取默认erp
- (void)getErpWithParam:(StairCategoryReq *) req response:(responseModel) responseModel;

///获取默认称重
- (void)getDefaultWeightWithParam:(StairCategoryReq *) req response:(responseModel) responseModel;
///专题
- (void)getTopicListWithParam:(StairCategoryReq *) req response:(responseModel) responseModel;
///菜谱(商品详情)
- (void)getRecipeListWithParam:(StairCategoryReq *) req response:(responseModel) responseModel;
///菜谱(主模块)
- (void)getHomeRecipeListWithParam:(StairCategoryReq *) req response:(responseModel) responseModel;
///菜谱详情
- (void)getDetailRecipeWithParam:(StairCategoryReq *) req response:(responseModel) responseModel;
///菜谱详情（收藏）
- (void)collectDetailRecipeWithParam:(StairCategoryReq *) req response:(responseModel) responseModel;
///菜谱详情（收藏、分享、点赞、评论）
- (void)shareDetailRecipeWithParam:(StairCategoryReq *) req response:(responseModel) responseModel;
///我的收藏
- (void)mineCollectListWithParam:(StairCategoryReq *) req response:(responseModel) responseModel;
///限时购
- (void)timeToBuyWithParam:(StairCategoryReq *) req response:(responseModel) responseModel;
///限时购列表
- (void)timeBuyListWithParam:(StairCategoryReq *) req response:(responseModel) responseModel;
///菜谱详情（点赞）
- (void)likeDetailRecipeWithParam:(StairCategoryReq *) req response:(responseModel) responseModel;
///评论列表
- (void)getCommentListWithParam:(StairCategoryReq *) req response:(responseModel) responseModel;
///评论添加
- (void)addCommenttWithParam:(StairCategoryReq *) req response:(responseModel) responseModel;


@end
