
//
//  NextServiceApi.m
//  Psf
//
//  Created by 燕来秋mac9 on 2018/6/21.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "NextServiceApi.h"

@implementation NextServiceApi
+ (instancetype)share {
    static NextServiceApi *global;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (global == nil) {
            global = [[NextServiceApi alloc] init];
        }
    });
    return global;
}
//////商品分类列表,包含一二级分类
- (void)requestApplyLoadWithParam:(StairCategoryReq *) req response:(responseModel) responseModel {
    req.erpStoreId = [UserCacheBean share].userInfo.erpStoreId;
    NSString *url = @"/lxn/product/category/mobile/v1/list";
    NSDictionary *dic = [req mj_keyValues];
    [[ZSAPIProxy shareProxy] callPOSTWithUrl:url Params:dic isShowLoading:NO successCallBack:^(ZSURLResponse *response) {
        if ([response.content isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dicResponse = (NSDictionary *) response.content;
            if ([dicResponse[@"code"] integerValue] == 200) {
                NSArray *result = (NSArray*)[StairCategoryRes mj_objectArrayWithKeyValuesArray:dicResponse[@"data"]];
                if (responseModel) {
                    responseModel(result);
                }
            }else {
                if (responseModel) {
                    responseModel(nil);
                }
            }
        } else {
            if (responseModel) {
                responseModel(nil);
            }
        }
    } faildCallBack:^(ZSURLResponse *response) {
        
    }];
}
///获取分类下商品信息
-(void)requestSortListLoadWithParam:(StairCategoryReq *)req response:(responseModel)responseModel{
    req.erpStoreId = [UserCacheBean share].userInfo.erpStoreId;
    NSString *url = @"/lxn/product/category/mobile/v1/list/product/by/category/ids";
    NSDictionary *dic = [req mj_keyValues];
    [[ZSAPIProxy shareProxy] callPOSTWithUrl:url Params:dic isShowLoading:NO successCallBack:^(ZSURLResponse *response) {
        if ([response.content isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dicResponse = (NSDictionary *) response.content;
            if ([dicResponse[@"code"] integerValue] == 200) {
                NSArray *result = (NSArray*)[StairCategoryRes mj_objectArrayWithKeyValuesArray:dicResponse[@"data"]];
                if (responseModel) {
                    responseModel(result);
                }
            }else {
                if (responseModel) {
                    responseModel(nil);
                }
            }
        } else {
            if (responseModel) {
                responseModel(nil);
            }
        }
    } faildCallBack:^(ZSURLResponse *response) {
        
    }];
}
///商品详情页
-(void)requestGoodDetailLoadWithParam:(StairCategoryReq *)req response:(responseModel)responseModel{
    req.erpStoreId = [UserCacheBean share].userInfo.erpStoreId;
    NSString *url = Psf_GetProductDetail;
    NSDictionary *dic = [req mj_keyValues];
    [[ZSAPIProxy shareProxy] callPOSTWithUrl:url Params:dic isShowLoading:YES successCallBack:^(ZSURLResponse *response) {
        if ([response.content isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dicResponse = (NSDictionary *) response.content;
            if ([dicResponse[@"code"] integerValue] == 200) {
                GoodDetailRes *result = [GoodDetailRes mj_objectWithKeyValues:dicResponse[@"data"]];
                if (responseModel) {
                    responseModel(result);
                }
            }else {
                if (responseModel) {
                    responseModel(dicResponse);
                }
            }
        } else {
            if (responseModel) {
                responseModel(nil);
            }
        }
    } faildCallBack:^(ZSURLResponse *response) {
        
    }];

}
///获取推荐商品列表
-(void)requestRecommendListLoadWithParam:(StairCategoryReq *)req response:(responseModel)responseModel{
    req.erpStoreId = [UserCacheBean share].userInfo.erpStoreId;
    NSString *url = Psf_GetRecommendList;
    NSDictionary *dic = [req mj_keyValues];
    [[ZSAPIProxy shareProxy] callPOSTWithUrl:url Params:dic isShowLoading:NO successCallBack:^(ZSURLResponse *response) {
        if ([response.content isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dicResponse = (NSDictionary *) response.content;
            if ([dicResponse[@"code"] integerValue] == 200) {
                NSArray *result = (NSArray*)[GoodDetailRes mj_objectArrayWithKeyValuesArray:dicResponse[@"data"][@"list"]];
                if (responseModel) {
                    responseModel(result);
                }
            }else {
                if (responseModel) {
                    responseModel(nil);
                }
            }
        } else {
            if (responseModel) {
                responseModel(nil);
            }
        }
    } faildCallBack:^(ZSURLResponse *response) {
        
    }];
}
///获取爆款商品列表
-(void)requestHotListLoadWithParam:(StairCategoryReq *)req response:(responseModel)responseModel{
    req.erpStoreId = [UserCacheBean share].userInfo.erpStoreId;
    NSString *url;
    if ([req.hotType isEqualToString:@"search"]) {
        url = Psf_GetHotSearchList;
    }else{
        url  = Psf_GetHotProductList;
    }
    
   
    
    NSDictionary *dic = [req mj_keyValues];
    [[ZSAPIProxy shareProxy] callPOSTWithUrl:url Params:dic isShowLoading:NO successCallBack:^(ZSURLResponse *response) {
        if ([response.content isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dicResponse = (NSDictionary *) response.content;
            if ([dicResponse[@"code"] integerValue] == 200) {
                NSArray *result;
                if ([req.hotType isEqualToString:@"search"]) {
                    result = (NSArray*)[GoodDetailRes mj_objectArrayWithKeyValuesArray:dicResponse[@"data"][@"list"]];
                }else{
                    result = (NSArray*)[GoodDetailRes mj_objectArrayWithKeyValuesArray:dicResponse[@"data"]];
                }
                
                if (responseModel) {
                    responseModel(result);
                }
            }else {
                if (responseModel) {
                    responseModel(nil);
                }
            }
        } else {
            if (responseModel) {
                responseModel(nil);
            }
        }
    } faildCallBack:^(ZSURLResponse *response) {
        
    }];
}

///获取评价列表
- (void)requestEvaluateListModelListLoadWithParam:(StairCategoryReq *) req response:(responseModel) responseModel{
    req.erpStoreId = [UserCacheBean share].userInfo.erpStoreId;
    NSString *url = @"/lxn/saleOrderProductComment/mobile/v1/list";
    NSDictionary *dic = [req mj_keyValues];
    [[ZSAPIProxy shareProxy] callPOSTWithUrl:url Params:dic isShowLoading:YES successCallBack:^(ZSURLResponse *response) {
        if ([response.content isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dicResponse = (NSDictionary *) response.content;
            if ([dicResponse[@"code"] integerValue] == 200) {
                EvaluateListRes *model = [EvaluateListRes mj_objectWithKeyValues:dicResponse[@"data"]];
                if (responseModel) {
                    responseModel(model);
                }
            }else {
                if (responseModel) {
                    responseModel(nil);
                }
            }
        } else {
            if (responseModel) {
                responseModel(nil);
            }
        }
    } faildCallBack:^(ZSURLResponse *response) {
        
    }];
}
///
- (void)requestHomeLoadWithParam:(StairCategoryReq *) req response:(responseModel) responseModel{
    req.erpStoreId = [UserCacheBean share].userInfo.erpStoreId;
    NSString *url = Psf_GetHomeTopicList;
    NSDictionary *dic = [req mj_keyValues];
    [[ZSAPIProxy shareProxy] callPOSTWithUrl:url Params:dic isShowLoading:YES successCallBack:^(ZSURLResponse *response) {
        if ([response.content isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dicResponse = (NSDictionary *) response.content;
            if ([dicResponse[@"code"] integerValue] == 200) {
         NSArray *result = (NSArray*)[SubjectCategoryModel mj_objectArrayWithKeyValuesArray:dicResponse[@"data"]];
                if (responseModel) {
                    responseModel(result);
                }
            }else {
                if (responseModel) {
                    responseModel(nil);
                }
            }
        } else {
            if (responseModel) {
                responseModel(nil);
            }
        }
    } faildCallBack:^(ZSURLResponse *response) {
        
    }];
}
///banner
- (void)requestBannerWithParam:(StairCategoryReq *) req response:(responseModel) responseModel{
    NSString *url = @"/lxn/subject/mobile/v1/list";
    req.erpStoreId = [UserCacheBean share].userInfo.erpStoreId;
    NSDictionary *dic = [req mj_keyValues];
    [[ZSAPIProxy shareProxy] callPOSTWithUrl:url Params:dic isShowLoading:NO successCallBack:^(ZSURLResponse *response) {
        if ([response.content isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dicResponse = (NSDictionary *) response.content;
            if ([dicResponse[@"code"] integerValue] == 200) {
                NSArray *result = (NSArray*)[SubjectModel mj_objectArrayWithKeyValuesArray:dicResponse[@"data"]];
                if (responseModel) {
                    responseModel(result);
                }
            }else {
                if (responseModel) {
                    responseModel(nil);
                }
            }
        } else {
            if (responseModel) {
                responseModel(nil);
            }
        }
    } faildCallBack:^(ZSURLResponse *response) {
        
    }];
}
///搜索商品提示列表
- (void)SearchHintListWithParam:(StairCategoryReq *) req response:(responseModel) responseModel{
    NSString *url = @"/lxn/product/mobile/v1/search/prompt/list";
    NSDictionary *dic = [req mj_keyValues];
    req.erpStoreId = [UserCacheBean share].userInfo.erpStoreId;
    [[ZSAPIProxy shareProxy] callPOSTWithUrl:url Params:dic isShowLoading:YES successCallBack:^(ZSURLResponse *response) {
        if ([response.content isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dicResponse = (NSDictionary *) response.content;
            if ([dicResponse[@"code"] integerValue] == 200) {
                NSArray *result = (NSArray*)[StairCategoryListRes mj_objectArrayWithKeyValuesArray:dicResponse[@"data"][@"list"]];
                if (responseModel) {
                    responseModel(result);
                }
            }else {
                if (responseModel) {
                    responseModel(nil);
                }
            }
        } else {
            if (responseModel) {
                responseModel(nil);
            }
        }
    } faildCallBack:^(ZSURLResponse *response) {
        
    }];
}
///搜索商品列表
- (void)SearchDataListWithParam:(StairCategoryReq *) req response:(responseModel) responseModel{
    NSString *url = Psf_GetSearchProductList;
    req.erpStoreId = [UserCacheBean share].userInfo.erpStoreId;
    NSDictionary *dic = [req mj_keyValues];
    [[ZSAPIProxy shareProxy] callPOSTWithUrl:url Params:dic isShowLoading:YES successCallBack:^(ZSURLResponse *response) {
        if ([response.content isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dicResponse = (NSDictionary *) response.content;
            if ([dicResponse[@"code"] integerValue] == 200) {
                NSArray *result = (NSArray*)[StairCategoryListRes mj_objectArrayWithKeyValuesArray:dicResponse[@"data"][@"list"]];
                if (responseModel) {
                    responseModel(result);
                }
            }else {
                if (responseModel) {
                    responseModel(nil);
                }
            }
        } else {
            if (responseModel) {
                responseModel(nil);
            }
        }
    } faildCallBack:^(ZSURLResponse *response) {
        
    }];
}
///新增销售订单商品评论信息
- (void)fillEvaluatetWithParam:(FillEvaluateReq *) req response:(responseModel) responseModel{
    NSString *url = @"/lxn/saleOrderProductComment/mobile/v1/save";
    req.erpStoreId = [UserCacheBean share].userInfo.erpStoreId;
    NSDictionary *dic = [req mj_keyValues];
    [[ZSAPIProxy shareProxy] callPOSTWithUrl:url Params:dic isShowLoading:YES successCallBack:^(ZSURLResponse *response) {
        if ([response.content isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dicResponse = (NSDictionary *) response.content;
            if ([dicResponse[@"code"] integerValue] == 200) {
                
                if (responseModel) {
                    responseModel(dicResponse);
                }
            }else {
                if (responseModel) {
                    responseModel(dicResponse);
                }
            }
        } else {
            if (responseModel) {
                responseModel(nil);
            }
        }
    } faildCallBack:^(ZSURLResponse *response) {
        
    }];
}
///根据分类编号查询商品列表
- (void)getCategoryListWithParam:(StairCategoryReq *) req response:(responseModel) responseModel{
    NSString *url = Psf_GetCategoryProductList;
    NSDictionary *dic = [req mj_keyValues];
    req.erpStoreId = [UserCacheBean share].userInfo.erpStoreId;
    [[ZSAPIProxy shareProxy] callPOSTWithUrl:url Params:dic isShowLoading:YES successCallBack:^(ZSURLResponse *response) {
        if ([response.content isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dicResponse = (NSDictionary *) response.content;
            if ([dicResponse[@"code"] integerValue] == 200) {
                NSArray *result = (NSArray*)[StairCategoryListRes mj_objectArrayWithKeyValuesArray:dicResponse[@"data"][@"list"]];
                if (responseModel) {
                    responseModel(result);
                }
            }else {
                if (responseModel) {
                    responseModel(nil);
                }
            }
        } else {
            if (responseModel) {
                responseModel(nil);
            }
        }
    } faildCallBack:^(ZSURLResponse *response) {
        
    }];
}
///企业合作
- (void)businessCooperationWithParam:(StairCategoryReq *) req response:(responseModel) responseModel{
    NSString *url = @"/lxn/company/mobile/v1/list";
    req.erpStoreId = [UserCacheBean share].userInfo.erpStoreId;
    NSDictionary *dic = [req mj_keyValues];
    [[ZSAPIProxy shareProxy] callPOSTWithUrl:url Params:dic isShowLoading:YES successCallBack:^(ZSURLResponse *response) {
        if ([response.content isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dicResponse = (NSDictionary *) response.content;
            if ([dicResponse[@"code"] integerValue] == 200) {
                
                if (responseModel) {
                    responseModel(dicResponse);
                }
            }else {
                if (responseModel) {
                    responseModel(dicResponse);
                }
            }
        } else {
            if (responseModel) {
                responseModel(nil);
            }
        }
    } faildCallBack:^(ZSURLResponse *response) {
        
    }];
}

///次日达列表
- (void)nextDayWithParam:(StairCategoryReq *) req response:(responseModel) responseModel{
    NSString *url = Psf_GetNextProductList;
    req.erpStoreId = [UserCacheBean share].userInfo.erpStoreId;
    NSDictionary *dic = [req mj_keyValues];
    [[ZSAPIProxy shareProxy] callPOSTWithUrl:url Params:dic isShowLoading:YES successCallBack:^(ZSURLResponse *response) {
        if ([response.content isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dicResponse = (NSDictionary *) response.content;
            if ([dicResponse[@"code"] integerValue] == 200) {
                NSArray *result = [StairCategoryListRes mj_objectArrayWithKeyValuesArray:dicResponse[@"data"][@"list"]];
                if (responseModel) {
                    responseModel(result);
                }
            }else {
                if (responseModel) {
                    responseModel(nil);
                }
            }
        } else {
            if (responseModel) {
                responseModel(nil);
            }
        }
    } faildCallBack:^(ZSURLResponse *response) {
        
    }];
}
///获取默认erp
- (void)getErpWithParam:(StairCategoryReq *) req response:(responseModel) responseModel{
    NSString *url = @"/lxn/merchant/store/mobile/v1/find/member/default/or/recent";
    req.erpStoreId = [UserCacheBean share].userInfo.erpStoreId;
    NSDictionary *dic = [req mj_keyValues];
    [[ZSAPIProxy shareProxy] callPOSTWithUrl:url Params:dic isShowLoading:NO successCallBack:^(ZSURLResponse *response) {
        if ([response.content isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dicResponse = (NSDictionary *) response.content;
            if ([dicResponse[@"code"] integerValue] == 200) {
                
                if (responseModel) {
                    responseModel(dicResponse);
                }
            }else {
                if (responseModel) {
                    responseModel(dicResponse);
                }
            }
        } else {
            if (responseModel) {
                responseModel(nil);
            }
        }
    } faildCallBack:^(ZSURLResponse *response) {
        
    }];
}
///获取默认称重
- (void)getDefaultWeightWithParam:(StairCategoryReq *) req response:(responseModel) responseModel{
    NSString *url = @"/lxn/business/param/mobile/v1/find";
    req.erpStoreId = [UserCacheBean share].userInfo.erpStoreId;
    NSDictionary *dic = [req mj_keyValues];
    [[ZSAPIProxy shareProxy] callPOSTWithUrl:url Params:dic isShowLoading:NO successCallBack:^(ZSURLResponse *response) {
        if ([response.content isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dicResponse = (NSDictionary *) response.content;
            if ([dicResponse[@"code"] integerValue] == 200) {
                
                if (responseModel) {
                    responseModel(dicResponse);
                }
            }else {
                if (responseModel) {
                    responseModel(nil);
                }
            }
        } else {
            if (responseModel) {
                responseModel(nil);
            }
        }
    } faildCallBack:^(ZSURLResponse *response) {
        
    }];
}
///专题
- (void)getTopicListWithParam:(StairCategoryReq *) req response:(responseModel) responseModel{
    
    req.erpStoreId = [UserCacheBean share].userInfo.erpStoreId;
    NSDictionary *dic = [req mj_keyValues];
    [[ZSAPIProxy shareProxy] callPOSTWithUrl:topics_url Params:dic isShowLoading:YES successCallBack:^(ZSURLResponse *response) {
        if ([response.content isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dicResponse = (NSDictionary *) response.content;
            if ([dicResponse[@"code"] integerValue] == 200) {
                TopicsListRes *result = [TopicsListRes mj_objectWithKeyValues:dicResponse[@"data"]];
                if (responseModel) {
                    responseModel(result);
                }
            }else {
                if (responseModel) {
                    responseModel(nil);
                }
            }
        } else {
            if (responseModel) {
                responseModel(nil);
            }
        }
    } faildCallBack:^(ZSURLResponse *response) {
        
    }];
}

///菜谱(商品详情)
- (void)getRecipeListWithParam:(StairCategoryReq *) req response:(responseModel) responseModel{
    NSDictionary *dic = [req mj_keyValues];
    [[ZSAPIProxy shareProxy] callPOSTWithUrl:recipe_list Params:dic isShowLoading:YES successCallBack:^(ZSURLResponse *response) {
        if ([response.content isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dicResponse = (NSDictionary *) response.content;
            if ([dicResponse[@"code"] integerValue] == 200) {
                NSArray *result = [CircleListRes mj_objectArrayWithKeyValuesArray:dicResponse[@"data"]];
                if (responseModel) {
                    responseModel(result);
                }
            }else {
                if (responseModel) {
                    responseModel(nil);
                }
            }
        } else {
            if (responseModel) {
                responseModel(nil);
            }
        }
    } faildCallBack:^(ZSURLResponse *response) {
        
    }];
}
///菜谱(主模块)
- (void)getHomeRecipeListWithParam:(StairCategoryReq *) req response:(responseModel) responseModel{
    NSDictionary *dic = [req mj_keyValues];
    [[ZSAPIProxy shareProxy] callPOSTWithUrl:home_recippe_list Params:dic isShowLoading:YES successCallBack:^(ZSURLResponse *response) {
        if ([response.content isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dicResponse = (NSDictionary *) response.content;
            if ([dicResponse[@"code"] integerValue] == 200) {
                NSArray *result = [CircleListRes mj_objectArrayWithKeyValuesArray:dicResponse[@"data"][@"list"]];
                if (responseModel) {
                    responseModel(result);
                }
            }else {
                if (responseModel) {
                    responseModel(nil);
                }
            }
        } else {
            if (responseModel) {
                responseModel(nil);
            }
        }
    } faildCallBack:^(ZSURLResponse *response) {
        
    }];
}
///菜谱详情
- (void)getDetailRecipeWithParam:(StairCategoryReq *) req response:(responseModel) responseModel{
    NSDictionary *dic = [req mj_keyValues];
    [[ZSAPIProxy shareProxy] callPOSTWithUrl:recipe_detail Params:dic isShowLoading:YES successCallBack:^(ZSURLResponse *response) {
        if ([response.content isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dicResponse = (NSDictionary *) response.content;
            if ([dicResponse[@"code"] integerValue] == 200) {
                DetailRecipeRes *result = [DetailRecipeRes mj_objectWithKeyValues:dicResponse[@"data"]];
                if (responseModel) {
                    responseModel(result);
                }
            }else {
                if (responseModel) {
                    responseModel(nil);
                }
            }
        } else {
            if (responseModel) {
                responseModel(nil);
            }
        }
    } faildCallBack:^(ZSURLResponse *response) {
        
    }];
}
///菜谱详情（收藏）
- (void)collectDetailRecipeWithParam:(StairCategoryReq *) req response:(responseModel) responseModel{
    NSDictionary *dic = [req mj_keyValues];
    [[ZSAPIProxy shareProxy] callPOSTWithUrl:recipe_detail_collect Params:dic isShowLoading:YES successCallBack:^(ZSURLResponse *response) {
        if ([response.content isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dicResponse = (NSDictionary *) response.content;
            if ([dicResponse[@"code"] integerValue] == 200) {
                
                if (responseModel) {
                    responseModel(dicResponse);
                }
            }else {
                if (responseModel) {
                    responseModel(dicResponse);
                }
            }
        } else {
            if (responseModel) {
                responseModel(nil);
            }
        }
    } faildCallBack:^(ZSURLResponse *response) {
        
    }];
}
///菜谱详情（点赞）
- (void)likeDetailRecipeWithParam:(StairCategoryReq *) req response:(responseModel) responseModel{
    NSDictionary *dic = [req mj_keyValues];
    [[ZSAPIProxy shareProxy] callPOSTWithUrl:recipe_detail_like Params:dic isShowLoading:NO successCallBack:^(ZSURLResponse *response) {
        if ([response.content isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dicResponse = (NSDictionary *) response.content;
            if ([dicResponse[@"code"] integerValue] == 200) {
                
                if (responseModel) {
                    responseModel(dicResponse);
                }
            }else {
                if (responseModel) {
                    responseModel(dicResponse);
                }
            }
        } else {
            if (responseModel) {
                responseModel(nil);
            }
        }
    } faildCallBack:^(ZSURLResponse *response) {
        
    }];
}
///评论添加
- (void)addCommenttWithParam:(StairCategoryReq *) req response:(responseModel) responseModel{
    NSDictionary *dic = [req mj_keyValues];
    [[ZSAPIProxy shareProxy] callPOSTWithUrl:recipe_comment_add Params:dic isShowLoading:NO successCallBack:^(ZSURLResponse *response) {
        if ([response.content isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dicResponse = (NSDictionary *) response.content;
            if ([dicResponse[@"code"] integerValue] == 200) {
                
                if (responseModel) {
                    responseModel(dicResponse);
                }
            }else {
                if (responseModel) {
                    responseModel(dicResponse);
                }
            }
        } else {
            if (responseModel) {
                responseModel(nil);
            }
        }
    } faildCallBack:^(ZSURLResponse *response) {
        
    }];
}
///菜谱详情（收藏、分享、点赞、评论）
- (void)shareDetailRecipeWithParam:(StairCategoryReq *) req response:(responseModel) responseModel{
    NSDictionary *dic = [req mj_keyValues];
    [[ZSAPIProxy shareProxy] callPOSTWithUrl:recipe_detail_share Params:dic isShowLoading:YES successCallBack:^(ZSURLResponse *response) {
        if ([response.content isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dicResponse = (NSDictionary *) response.content;
            if ([dicResponse[@"code"] integerValue] == 200) {
                RecipeCollectModel *result = [RecipeCollectModel mj_objectWithKeyValues:dicResponse[@"data"]];
                if (responseModel) {
                    responseModel(result);
                }
            }else {
                if (responseModel) {
                    responseModel(nil);
                }
            }
        } else {
            if (responseModel) {
                responseModel(nil);
            }
        }
    } faildCallBack:^(ZSURLResponse *response) {
        
    }];
}
///我的收藏
- (void)mineCollectListWithParam:(StairCategoryReq *) req response:(responseModel) responseModel{
    NSDictionary *dic = [req mj_keyValues];
    [[ZSAPIProxy shareProxy] callPOSTWithUrl:mine_collect_list Params:dic isShowLoading:YES successCallBack:^(ZSURLResponse *response) {
        if ([response.content isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dicResponse = (NSDictionary *) response.content;
            if ([dicResponse[@"code"] integerValue] == 200) {
                NSArray *result = [CircleListRes mj_objectArrayWithKeyValuesArray:dicResponse[@"data"][@"resultList"]];
                if (responseModel) {
                    responseModel(result);
                }
            }else {
                if (responseModel) {
                    responseModel(nil);
                }
            }
        } else {
            if (responseModel) {
                responseModel(nil);
            }
        }
    } faildCallBack:^(ZSURLResponse *response) {
        
    }];
}
///限时购
- (void)timeToBuyWithParam:(StairCategoryReq *) req response:(responseModel) responseModel{
    NSDictionary *dic = [req mj_keyValues];
    [[ZSAPIProxy shareProxy] callPOSTWithUrl:Time_To_Buy Params:dic isShowLoading:NO successCallBack:^(ZSURLResponse *response) {
        if ([response.content isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dicResponse = (NSDictionary *) response.content;
            if ([dicResponse[@"code"] integerValue] == 200) {
                NSArray *result = [TimeBuyModel mj_objectArrayWithKeyValuesArray:dicResponse[@"data"]];
                if (responseModel) {
                    responseModel(result);
                }
            }else {
                if (responseModel) {
                    responseModel(nil);
                }
            }
        } else {
            if (responseModel) {
                responseModel(nil);
            }
        }
    } faildCallBack:^(ZSURLResponse *response) {
        
    }];
}
///限时购列表
- (void)timeBuyListWithParam:(StairCategoryReq *) req response:(responseModel) responseModel{
    NSDictionary *dic = [req mj_keyValues];
    [[ZSAPIProxy shareProxy] callPOSTWithUrl:Time_Buy_list Params:dic isShowLoading:NO successCallBack:^(ZSURLResponse *response) {
        if ([response.content isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dicResponse = (NSDictionary *) response.content;
            if ([dicResponse[@"code"] integerValue] == 200) {
                NSArray *result = [TimeBuyModel mj_objectArrayWithKeyValuesArray:dicResponse[@"data"][@"list"]];
                if (responseModel) {
                    responseModel(result);
                }
            }else {
                if (responseModel) {
                    responseModel(nil);
                }
            }
        } else {
            if (responseModel) {
                responseModel(nil);
            }
        }
    } faildCallBack:^(ZSURLResponse *response) {
        
    }];
}
///评论列表
- (void)getCommentListWithParam:(StairCategoryReq *) req response:(responseModel) responseModel{
    NSDictionary *dic = [req mj_keyValues];
    [[ZSAPIProxy shareProxy] callPOSTWithUrl:recipe_comment_list Params:dic isShowLoading:NO successCallBack:^(ZSURLResponse *response) {
        if ([response.content isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dicResponse = (NSDictionary *) response.content;
            if ([dicResponse[@"code"] integerValue] == 200) {
                NSArray *result = [DNCommentList mj_objectArrayWithKeyValuesArray:dicResponse[@"data"][@"list"]];
                if (responseModel) {
                    responseModel(result);
                }
            }else {
                if (responseModel) {
                    responseModel(nil);
                }
            }
        } else {
            if (responseModel) {
                responseModel(nil);
            }
        }
    } faildCallBack:^(ZSURLResponse *response) {
        
    }];
}
@end
