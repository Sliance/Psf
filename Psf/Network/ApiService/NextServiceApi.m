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
- (void)requestApplyLoadWithParam:(StairCategoryReq *) req response:(responseModel) responseModel {
    NSString *url = @"/lxn/product/category/mobile/v1/list";
    NSDictionary *dic = [req mj_keyValues];
    [[ZSAPIProxy shareProxy] callPOSTWithUrl:url Params:dic isShowLoading:YES successCallBack:^(ZSURLResponse *response) {
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

@end
