//
//  OrderDetailViewController.h
//  Psf
//
//  Created by 燕来秋mac9 on 2018/6/27.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "BaseViewController.h"
#import "WaitPaymentCell.h"
#import "OrderServiceApi.h"

@interface OrderDetailViewController : BaseViewController
///订单状态
@property(nonatomic,assign)ORDERSTYPE ordertype;

@property(nonatomic,strong)OrderListRes *model;

@end
