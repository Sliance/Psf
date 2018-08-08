//
//  ChooseServiceTypeController.h
//  Psf
//
//  Created by 燕来秋mac9 on 2018/7/4.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "BaseViewController.h"
#import "OrderListRes.h"
#import "CartProductModel.h"

@interface ChooseServiceTypeController : BaseViewController
@property(nonatomic,strong)OrderListRes *model;
@property(nonatomic,strong)CartProductModel *carmodel;
@end
