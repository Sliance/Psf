//
//  ShopServiceApi.m
//  Psf
//
//  Created by 燕来秋mac9 on 2018/7/10.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "ShopServiceApi.h"

@implementation ShopServiceApi
+ (instancetype)share {
    static ShopServiceApi *global;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (global == nil) {
            global = [[ShopServiceApi alloc] init];
        }
    });
    return global;
}
-(void)requestShopListModelListLoadWithParam:(StairCategoryReq *)req response:(responseModel)responseModel{
    NSString *url = @"/lxn/cart/mobile/v1/list";
    NSDictionary *dic = [req mj_keyValues];
    [[ZSAPIProxy shareProxy] callPOSTWithUrl:url Params:dic isShowLoading:YES successCallBack:^(ZSURLResponse *response) {
        if ([response.content isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dicResponse = (NSDictionary *) response.content;
            if ([dicResponse[@"code"] integerValue] == 200) {
                ShoppingListRes *result = [ShoppingListRes mj_objectWithKeyValues:dicResponse[@"data"]];
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
///选中单条购物车信息
- (void)requestShopCartSelectedSingleWithParam:(StairCategoryReq *) req response:(responseModel) responseModel{
    NSString *url = @"/lxn/cart/mobile/v1/active";
    NSDictionary *dic = [req mj_keyValues];
    [[ZSAPIProxy shareProxy] callPOSTWithUrl:url Params:dic isShowLoading:NO successCallBack:^(ZSURLResponse *response) {
        if ([response.content isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dicResponse = (NSDictionary *) response.content;
            if ([dicResponse[@"code"] integerValue] == 200) {
                ShoppingListRes *result = [ShoppingListRes mj_objectWithKeyValues:dicResponse[@"data"]];
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
///全选或者反选购物车信息
- (void)requestShopCartSelectedAllWithParam:(StairCategoryReq *) req response:(responseModel) responseModel{
    NSString *url = @"/lxn/cart/mobile/v1/active/all";
    NSDictionary *dic = [req mj_keyValues];
    [[ZSAPIProxy shareProxy] callPOSTWithUrl:url Params:dic isShowLoading:YES successCallBack:^(ZSURLResponse *response) {
        if ([response.content isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dicResponse = (NSDictionary *) response.content;
            if ([dicResponse[@"code"] integerValue] == 200) {
                ShoppingListRes *result = [ShoppingListRes mj_objectWithKeyValues:dicResponse[@"data"]];
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
///清空购物车失效商品
- (void)clearLoseProductWithParam:(StairCategoryReq *) req response:(responseModel) responseModel{
    NSString *url = @"/lxn/cart/mobile/v1/clear/is/not/open";
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

///获取购物车数量
- (void)getShopCartCountWithParam:(StairCategoryReq *) req response:(responseModel) responseModel{
    NSString *url = @"/lxn/cart/mobile/v1/count";
    NSDictionary *dic = [req mj_keyValues];
    [[ZSAPIProxy shareProxy] callPOSTWithUrl:url Params:dic isShowLoading:NO successCallBack:^(ZSURLResponse *response) {
        if ([response.content isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dicResponse = (NSDictionary *) response.content;
            if ([dicResponse[@"code"] integerValue] == 200) {
                
                if (responseModel) {
                    responseModel(dicResponse[@"data"]);
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

///新增购物车信息
- (void)addShopCartCountWithParam:(StairCategoryReq *) req response:(responseModel) responseModel{
    NSString *url = @"/lxn/cart/mobile/v1/save";
    NSDictionary *dic = [req mj_keyValues];
    [[ZSAPIProxy shareProxy] callPOSTWithUrl:url Params:dic isShowLoading:YES successCallBack:^(ZSURLResponse *response) {
        if ([response.content isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dicResponse = (NSDictionary *) response.content;
            if ([dicResponse[@"code"] integerValue] == 200) {
                
                ShoppingListRes *result = [ShoppingListRes mj_objectWithKeyValues:dicResponse[@"data"]];
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
///修改购物车信息
- (void)changeShopCartCountWithParam:(StairCategoryReq *) req response:(responseModel) responseModel{
    NSString *url = @"/lxn/cart/mobile/v1/update";
    NSDictionary *dic = [req mj_keyValues];
    [[ZSAPIProxy shareProxy] callPOSTWithUrl:url Params:dic isShowLoading:YES successCallBack:^(ZSURLResponse *response) {
        if ([response.content isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dicResponse = (NSDictionary *) response.content;
            if ([dicResponse[@"code"] integerValue] == 200) {
                
                ShoppingListRes *result = [ShoppingListRes mj_objectWithKeyValues:dicResponse[@"data"]];
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
///猜你喜欢
- (void)guessYouLikeWithParam:(StairCategoryReq *) req response:(responseModel) responseModel{
    NSString *url = @"/lxn/product/mobile/v1/guest/list";
    NSDictionary *dic = [req mj_keyValues];
    [[ZSAPIProxy shareProxy] callPOSTWithUrl:url Params:dic isShowLoading:NO successCallBack:^(ZSURLResponse *response) {
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
///填写订单计算价格
-(void)CalculateThePriceWithParam:(CalculateReq*)req response:(responseModel) responseModel{
    NSString *url = @"/lxn/sale/order/mobile/v1/cal/amount";
    NSDictionary *dic = [req mj_keyValues];
    [[ZSAPIProxy shareProxy] callPOSTWithUrl:url Params:dic isShowLoading:YES successCallBack:^(ZSURLResponse *response) {
        if ([response.content isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dicResponse = (NSDictionary *) response.content;
            if ([dicResponse[@"code"] integerValue] == 200) {
                CalculateThePriceRes *result = [CalculateThePriceRes mj_objectWithKeyValues:dicResponse[@"data"]];
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
