//
//  BaseApi.h
//  Psf
//
//  Created by 燕来秋mac9 on 2018/6/21.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZSAPIProxy.h"
#import "UserCacheBean.h"
#import "ZSConfig.h"
///专题详情
#define topics_url  @"/lxn/subject/mobile/v1/list/subject/info"
///菜谱列表（商品详情）
#define recipe_list   @"/lxn/epicure/mobile/v1/linked/product/list"
///菜谱详情
#define recipe_detail   @"/lxn/epicure/mobile/v1/detail"
///菜谱主模块
#define home_recippe_list  @"/lxn/epicure/mobile/v1//list"
///收藏 点赞 转发 评论
#define recipe_detail_share @"/lxn/epicure/mobile/v1/media/interaction"
///收藏、取消收藏
#define recipe_detail_collect @"/lxn/member/collection/mobile/v1/toggle"
///点赞、取消点赞
#define recipe_detail_like @"/lxn/member/like/mobile/v1/toggle"
///我的收藏
#define  mine_collect_list  @"/lxn/member/collection/mobile/v1/my/list"
///限时购
#define  Time_To_Buy  @"/lxn/rule/activity/mobile/v1/list"
///限时购列表
#define  Time_Buy_list  @"/lxn/rule/product/mobile/v1/list"
///查询充值情况
#define Recharge_result   @"/lxn/pay/mobile/v1/query/rechargehassuccess"
///菜谱评论列表
#define recipe_comment_list  @"/lxn/member/comment/mobile/v2/list"
///添加评论
#define recipe_comment_add @"/lxn/member/comment/mobile/v1/save"

typedef void(^responseModel)(id response);
@interface BaseApi : NSObject
+ (void)requestAccountInfoModel:(responseModel ) response;

@end
