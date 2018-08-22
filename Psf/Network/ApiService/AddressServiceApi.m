//
//  AddressServiceApi.m
//  Psf
//
//  Created by 燕来秋mac9 on 2018/7/12.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "AddressServiceApi.h"

@implementation AddressServiceApi
+ (instancetype)share {
    static AddressServiceApi *global;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (global == nil) {
            global = [[AddressServiceApi alloc] init];
        }
    });
    return global;
}
///删除会员地址信息
- (void)deleteAddressWithParam:(AddressBaeReq *) req response:(responseModel) responseModel{
    NSString *url = @"/lxn/member/address/mobile/v1/delete";
    req.erpStoreId = @"";
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
///获取单条会员地址信息
- (void)getSingleAddresWithParam:(AddressBaeReq *) req response:(responseModel) responseModel{
    NSString *url = @"/lxn/member/address/mobile/v1/find";
    req.erpStoreId = @"181";
    NSDictionary *dic = [req mj_keyValues];
    [[ZSAPIProxy shareProxy] callPOSTWithUrl:url Params:dic isShowLoading:NO successCallBack:^(ZSURLResponse *response) {
        if ([response.content isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dicResponse = (NSDictionary *) response.content;
            if ([dicResponse[@"code"] integerValue] == 200) {
                
                NSArray *result = (NSArray*)[ChangeAddressReq mj_objectArrayWithKeyValuesArray:dicResponse[@"data"]];
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
///获取单条默认会员地址信息
- (void)getSingleDefaultAddresWithParam:(AddressBaeReq *) req response:(responseModel) responseModel{
    req.erpStoreId = @"181";
    NSString *url = @"/lxn/member/address/mobile/v1/find/default";
    NSDictionary *dic = [req mj_keyValues];
    [[ZSAPIProxy shareProxy] callPOSTWithUrl:url Params:dic isShowLoading:NO successCallBack:^(ZSURLResponse *response) {
        if ([response.content isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dicResponse = (NSDictionary *) response.content;
            if ([dicResponse[@"code"] integerValue] == 200) {
                
                ChangeAddressReq *result = [ChangeAddressReq mj_objectWithKeyValues:dicResponse[@"data"]];
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
///新增会员收货地址信息
- (void)addAddressWithParam:(ChangeAddressReq *) req response:(responseModel) responseModel{
    NSString *url = @"/lxn/member/address/mobile/v1/save";
    req.erpStoreId = @"181";
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
///修改会员地址信息
- (void)updateAddressWithParam:(ChangeAddressReq *) req response:(responseModel) responseModel{
    NSString *url = @"/lxn/member/address/mobile/v1/update";
    req.erpStoreId = @"181";
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
///获取会员地址信息列表
- (void)getAddressListWithParam:(AddressBaeReq *) req response:(responseModel)responseModel{
    NSString *url = @"/lxn/member/address/mobile/v1/list";
    req.erpStoreId = @"181";
    NSDictionary *dic = [req mj_keyValues];
    [[ZSAPIProxy shareProxy] callPOSTWithUrl:url Params:dic isShowLoading:NO successCallBack:^(ZSURLResponse *response) {
        if ([response.content isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dicResponse = (NSDictionary *) response.content;
            if ([dicResponse[@"code"] integerValue] == 200) {
                
                NSArray *result = (NSArray*)[ChangeAddressReq mj_objectArrayWithKeyValuesArray:dicResponse[@"data"]];
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
///获取单条默认会员门店地址信息（填写订单界面的）
- (void)pickUpSingleDefaultAddresWithParam:(AddressBaeReq *) req response:(responseModel) responseModel{
    req.erpStoreId = @"181";
    NSString *url = @"/lxn/member/store/mobile/v1/find";
    NSDictionary *dic = [req mj_keyValues];
    [[ZSAPIProxy shareProxy] callPOSTWithUrl:url Params:dic isShowLoading:NO successCallBack:^(ZSURLResponse *response) {
        if ([response.content isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dicResponse = (NSDictionary *) response.content;
            if ([dicResponse[@"code"] integerValue] == 200) {
                
                StoreRes *result = [StoreRes mj_objectWithKeyValues:dicResponse[@"data"]];
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
///获取会员门店地址列填表（填写订单界面的）
- (void)pickUpAddresListWithParam:(AddressBaeReq *) req response:(responseModel) responseModel{
    NSString *url = @"/lxn/merchantStore/mobile/v1/list";
    req.erpStoreId = @"181";
    NSDictionary *dic = [req mj_keyValues];
    [[ZSAPIProxy shareProxy] callPOSTWithUrl:url Params:dic isShowLoading:NO successCallBack:^(ZSURLResponse *response) {
        if ([response.content isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dicResponse = (NSDictionary *) response.content;
            if ([dicResponse[@"code"] integerValue] == 200) {
                
                NSArray *result = (NSArray*)[StoreRes mj_objectArrayWithKeyValuesArray:dicResponse[@"data"]];
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
///修改门店信息
- (void)updateStoreAddresWithParam:(AddressBaeReq *) req response:(responseModel) responseModel{
    NSString *url = @"/lxn/merchantStore/mobile/v1/update";
    req.erpStoreId = @"181";
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
@end
