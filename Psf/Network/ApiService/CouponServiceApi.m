//
//  CouponServiceApi.m
//  Psf
//
//  Created by 燕来秋mac9 on 2018/7/13.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "CouponServiceApi.h"
#import "CouponListRes.h"

@implementation CouponServiceApi
+ (instancetype)share {
    static CouponServiceApi *global;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (global == nil) {
            global = [[CouponServiceApi alloc] init];
        }
    });
    return global;
}

///获取商品对应的优惠券
- (void)requestCouponListLoadWithParam:(StairCategoryReq *) req response:(responseModel) responseModel{
    req.erpStoreId = [UserCacheBean share].userInfo.erpStoreId;
    NSString *url = @"/lxn/coupon/mobile/v1/list/product/id";
    NSDictionary *dic = [req mj_keyValues];
    [[ZSAPIProxy shareProxy] callPOSTWithUrl:url Params:dic isShowLoading:NO successCallBack:^(ZSURLResponse *response) {
        if ([response.content isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dicResponse = (NSDictionary *) response.content;
            if ([dicResponse[@"code"] integerValue] == 200) {
                NSArray *result = (NSArray*)[CouponListRes mj_objectArrayWithKeyValuesArray:dicResponse[@"data"]];
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
///获取优惠券列表（我的）
- (void)requestMineCouponListWithParam:(StairCategoryReq *) req response:(responseModel) responseModel{
    req.erpStoreId = [UserCacheBean share].userInfo.erpStoreId;
    NSString *url = @"/lxn/member/coupon/mobile/v1/type/list";
    NSDictionary *dic = [req mj_keyValues];
    [[ZSAPIProxy shareProxy] callPOSTWithUrl:url Params:dic isShowLoading:NO successCallBack:^(ZSURLResponse *response) {
        if ([response.content isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dicResponse = (NSDictionary *) response.content;
            if ([dicResponse[@"code"] integerValue] == 200) {
                NSArray *result = (NSArray*)[CouponListRes mj_objectArrayWithKeyValuesArray:dicResponse[@"data"][@"list"]];
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
///获取优惠券列表（填写订单时）
- (void)fillOrderCouponWithParam:(StairCategoryReq *) req response:(responseModel) responseModel{
    req.erpStoreId = [UserCacheBean share].userInfo.erpStoreId;
    NSString *url = @"/lxn/member/coupon/mobile/v1/list/user/coupon";
    NSDictionary *dic = [req mj_keyValues];
    [[ZSAPIProxy shareProxy] callPOSTWithUrl:url Params:dic isShowLoading:NO successCallBack:^(ZSURLResponse *response) {
        if ([response.content isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dicResponse = (NSDictionary *) response.content;
            if ([dicResponse[@"code"] integerValue] == 200) {
                NSArray *result = (NSArray*)[CouponListRes mj_objectArrayWithKeyValuesArray:dicResponse[@"data"]];
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
///领取优惠券
- (void)saveCouponWithParam:(StairCategoryReq *) req response:(responseModel) responseModel{
    NSString *url = @"/lxn/memberCoupon/mobile/v1/save";
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
@end
