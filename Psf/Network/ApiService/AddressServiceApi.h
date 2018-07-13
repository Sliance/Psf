//
//  AddressServiceApi.h
//  Psf
//
//  Created by 燕来秋mac9 on 2018/7/12.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "BaseApi.h"
#import "AddressBaeReq.h"
#import "ChangeAddressReq.h"


@interface AddressServiceApi : BaseApi
+ (instancetype)share;
///删除会员地址信息
- (void)deleteAddressWithParam:(AddressBaeReq *) req response:(responseModel) responseModel;
///获取单条会员地址信息
- (void)getSingleAddresWithParam:(AddressBaeReq *) req response:(responseModel) responseModel;
///获取单条默认会员地址信息（填写订单界面的）
- (void)getSingleDefaultAddresWithParam:(AddressBaeReq *) req response:(responseModel) responseModel;
///新增会员收货地址信息
- (void)addAddressWithParam:(ChangeAddressReq *) req response:(responseModel) responseModel;
///修改会员地址信息
- (void)updateAddressWithParam:(ChangeAddressReq *) req response:(responseModel) responseModel;
///获取会员地址信息列表
- (void)getAddressListWithParam:(AddressBaeReq *) req response:(responseModel)responseModel;

@end
