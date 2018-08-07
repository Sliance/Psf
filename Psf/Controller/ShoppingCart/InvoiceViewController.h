//
//  InvoiceViewController.h
//  Psf
//
//  Created by 燕来秋mac9 on 2018/8/6.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "BaseViewController.h"
#import "PlaceOrderReq.h"

@interface InvoiceViewController : BaseViewController
@property(nonatomic,copy)void(^submintBlock)(PlaceOrderReq *);
@property(nonatomic,strong)PlaceOrderReq *placemodel;
@end
