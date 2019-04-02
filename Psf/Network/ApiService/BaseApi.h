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
static NSString *const topics_url = @"/lxn/subject/mobile/v1/list/subject/info";
///菜谱列表（商品详情）
static NSString *const recipe_list  = @"/lxn/epicure/mobile/v1/linked/product/list";
///菜谱详情
static NSString *const recipe_detail  = @"/lxn/epicure/mobile/v2/detail";
///菜谱主模块
static NSString *const home_recippe_list = @"/lxn/epicure/mobile/v1//list";
///收藏 点赞 转发 评论
static NSString *const recipe_detail_share =@"/lxn/epicure/mobile/v1/media/interaction";
///收藏、取消收藏
static NSString *const recipe_detail_collect= @"/lxn/member/collection/mobile/v1/toggle";
///点赞、取消点赞
static NSString *const recipe_detail_like =@"/lxn/member/like/mobile/v1/toggle";
///我的收藏
static NSString *const  mine_collect_list = @"/lxn/member/collection/mobile/v1/my/list";
///限时购
static NSString *const  Time_To_Buy = @"/lxn/rule/activity/mobile/v1/list";
///限时购列表
static NSString *const  Time_Buy_list = @"/lxn/rule/product/mobile/v1/list";
///查询充值情况
static NSString *const Recharge_result =  @"/lxn/pay/mobile/v1/query/rechargehassuccess";
///菜谱评论列表
static NSString *const recipe_comment_list =  @"/lxn/member/comment/mobile/v2/list";
///添加评论
static NSString *const recipe_comment_add = @"/lxn/member/comment/mobile/v1/save";

/// 获取推荐商品列表
static NSString *const Psf_GetRecommendList = @"/lxn/product/mobile/v2/recommend/list";
/// 获取猜你喜欢商品列表
static NSString *const Psf_GetYouLikeList = @"/lxn/product/mobile/v2/guest/list";
/// 获取爆款商品列表
static NSString *const Psf_GetHotProductList = @"/lxn/product/mobile/v2/hot/list";
/// 搜索提示爆款商品列表
static NSString *const Psf_GetHotSearchList = @"/lxn/member/search/mobile/v1/hot/list";
/// 根据分类编号查询商品列表
static NSString *const Psf_GetCategoryProductList = @"/lxn/product/mobile/v2/list/by/category/id";
/// 获取专题自定义商品分类列表,首页下部专题栏用到了
static NSString *const Psf_GetHomeTopicList = @"/lxn/subjectCustomCategory/mobile/v2/list";
/// 搜索商品列表
static NSString *const Psf_GetSearchProductList = @"/lxn/product/mobile/v2/search/list";
/// 商品详情页
static NSString *const Psf_GetProductDetail = @"/lxn/product/mobile/v2/find";
/// 次日达
static NSString *const Psf_GetNextProductList = @"/lxn/product/mobile/v2/next/day/list";
/// 门店商品列表
static NSString *const Psf_GetStoreProductList = @"/lxn/product/category/mobile/v3/list/store/product";
/// 预售商品列表
static NSString *const Psf_GetPresaleProductList = @"/lxn/pre/sale/mobile/v2/list/all/week";
/// 购物车列表
static NSString *const Psf_GetShopList = @"/lxn/cart/mobile/v2/list";
/// 新增购物车
static NSString *const Psf_AddShopUrl = @"/lxn/cart/mobile/v2/save";
/// 选中单条购物车信息
static NSString *const Psf_SelectedSingleShop = @"/lxn/cart/mobile/v2/active";
/// 全选或者反选购物车信息
static NSString *const Psf_SelectedAllShop = @"/lxn/cart/mobile/v2/active/all";
/// 修改购物车信息
static NSString *const Psf_UpdateShopInfo = @"/lxn/cart/mobile/v2/update";
/// 价格计算
static NSString *const Psf_CalculatePrice = @"/lxn/sale/order/mobile/v2/cal/amount";
/// 获取销售订单列表和条数
static NSString *const Psf_GetOrderList = @"/lxn/sale/order/mobile/v2/list";
/// 获取订单详情
static NSString *const Psf_GetDetailOrder = @"/lxn/sale/order/mobile/v2/find";
/// 下单
static NSString *const Psf_PlaceOrder = @"/lxn/sale/order/mobile/v3/save";
/// 购物车商品分类计算显示/结算列表
static NSString *const Psf_TlementList = @"/lxn/cart/mobile/v2/cart/product/type";
/// 售后列表
static NSString *const Psf_RefundList =@"/lxn/sale/order/refund/mobile/v1/list";


typedef void(^responseModel)(id response);
@interface BaseApi : NSObject
+ (void)requestAccountInfoModel:(responseModel ) response;

@end
