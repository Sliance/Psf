//
//  OrderDetailBottomView.h
//  Psf
//
//  Created by 燕来秋mac9 on 2018/6/28.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "BaseView.h"
#import "OrderListRes.h"

@interface OrderDetailBottomView : BaseView
@property(nonatomic,strong)UILabel *lineLabel;
@property(nonatomic,strong)UIButton *remindBtn;
///取消订单按钮
@property(nonatomic,strong)UIButton *sendBtn;
///应付金额
@property(nonatomic,strong)UILabel *payableLabel;
///订单状态
@property(nonatomic,strong)OrderListRes* status;
//付款
@property(nonatomic,copy)void (^payBlock)(OrderListRes*);
//提醒发货
@property(nonatomic,copy)void (^remindBlock)(OrderListRes*);
//查看物流
@property(nonatomic,copy)void (^logisticsBlock)(OrderListRes*);
//送达日历
@property(nonatomic,copy)void (^sureBlock)(OrderListRes*);
//再次购买
@property(nonatomic,copy)void (^buyBlock)(OrderListRes*);
//评价
@property(nonatomic,copy)void (^evaBlock)(OrderListRes*);
//退款
@property(nonatomic,copy)void (^refundBlock)(OrderListRes*);
//删除订单
@property(nonatomic,copy)void (^deleteBlock)(OrderListRes*);
//取消订单
@property(nonatomic,copy)void (^cancleBlock)(OrderListRes*);
@end
