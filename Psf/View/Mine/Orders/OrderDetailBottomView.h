//
//  OrderDetailBottomView.h
//  Psf
//
//  Created by 燕来秋mac9 on 2018/6/28.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "BaseView.h"
#import "OrderDetailRes.h"

@interface OrderDetailBottomView : BaseView
@property(nonatomic,strong)UILabel *lineLabel;
@property(nonatomic,strong)UIButton *remindBtn;
///取消订单按钮
@property(nonatomic,strong)UIButton *sendBtn;
///应付金额
@property(nonatomic,strong)UILabel *payableLabel;
///订单状态
@property(nonatomic,strong)OrderDetailRes* status;
@property(nonatomic,assign)NSInteger type;
//付款
@property(nonatomic,copy)void (^payBlock)(OrderDetailRes*);
//提醒发货
@property(nonatomic,copy)void (^remindBlock)(OrderDetailRes*);
//查看物流
@property(nonatomic,copy)void (^logisticsBlock)(OrderDetailRes*);
//送达日历
@property(nonatomic,copy)void (^sureBlock)(OrderDetailRes*);
//再次购买
@property(nonatomic,copy)void (^buyBlock)(OrderDetailRes*);
//评价
@property(nonatomic,copy)void (^evaBlock)(OrderDetailRes*);
//退款
@property(nonatomic,copy)void (^refundBlock)(OrderDetailRes*);
//删除订单
@property(nonatomic,copy)void (^deleteBlock)(OrderDetailRes*);
//取消订单
@property(nonatomic,copy)void (^cancleBlock)(OrderDetailRes*);
//自提码
@property(nonatomic,copy)void(^zitiBlock)(OrderDetailRes*);
@end
