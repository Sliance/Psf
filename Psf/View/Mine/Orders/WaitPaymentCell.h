//
//  WaitPaymentCell.h
//  Psf
//
//  Created by 燕来秋mac9 on 2018/6/27.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "OrderListRes.h"
#import "CartProductModel.h"

typedef NS_ENUM(NSInteger, ORDERSTYPE){
    ORDERSTYPEAll= -1 ,//全部
    ORDERSTYPEWaitPayment ,//待付款
    ORDERSTYPEWaitDeliver , //待发货
    ORDERSTYPEWaitReceive , //待收货
    ORDERSTYPEWaitEvaluate //待评价
};
@interface WaitPaymentCell : BaseTableViewCell
@property(nonatomic,strong)UIView *bgView;
@property(nonatomic,strong)UIImageView *headImage;
@property(nonatomic,strong)UIImageView *headImageTwo;
@property(nonatomic,strong)UIImageView *headImageThree;
@property(nonatomic,strong)UILabel *nameLabel;
///购买份数
@property(nonatomic,strong)UILabel *countLabel;
@property(nonatomic,strong)UILabel *weightLabel;

///订单编号
@property(nonatomic,strong)UILabel *orderNumLabel;
///删除、取消订单按钮
@property(nonatomic,strong)UIButton *cancleBtn;
///应付金额
@property(nonatomic,strong)UILabel *payableLabel;
///状态
@property(nonatomic,strong)UILabel *statusLabel;
@property(nonatomic,strong)UILabel *topline;
@property(nonatomic,strong)UILabel *bottomline;
///配送按钮
@property(nonatomic,strong)UIButton *sendBtn;
///付款按钮
@property(nonatomic,strong)UIButton *payBtn;
///订单状态
@property(nonatomic,assign)ORDERSTYPE ordertype;
///是否多选
@property(nonatomic,assign)BOOL isMultiSelect;

@property(nonatomic,strong)OrderListRes *model;
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
//拼团详情
@property(nonatomic,copy)void (^groupBlock)(OrderListRes*);
@end
