//
//  MyReceiveAddressController.h
//  Psf
//
//  Created by 燕来秋mac9 on 2018/6/25.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "BaseViewController.h"
#import "AddressServiceApi.h"
typedef NS_ENUM(NSInteger, ADDRESSTYPE){
    ADDRESSTYPEMine= 0 ,//我的
    ADDRESSTYPEOrder ,//填写订单
    
};
@interface MyReceiveAddressController : BaseViewController
@property(nonatomic,assign)ADDRESSTYPE type;

@property(nonatomic,copy)void (^chooseBlock)(ChangeAddressReq*);
@end
