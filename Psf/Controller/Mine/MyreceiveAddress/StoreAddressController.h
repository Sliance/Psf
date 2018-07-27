//
//  StoreAddressController.h
//  Psf
//
//  Created by 燕来秋mac9 on 2018/7/20.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "BaseViewController.h"
#import "StoreRes.h"

@interface StoreAddressController : BaseViewController
@property(nonatomic,copy)void (^storeBlock)(StoreRes*);

@end
