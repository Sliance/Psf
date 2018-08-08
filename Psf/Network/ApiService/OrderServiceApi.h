//
//  OrderServiceApi.h
//  Psf
//
//  Created by 燕来秋mac9 on 2018/7/18.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "BaseApi.h"
#import "StairCategoryReq.h"
#import "OrderListRes.h"
#import "OrderDetailRes.h"
#import "RefundOrderReq.h"
@interface OrderServiceApi : BaseApi
+ (instancetype)share;
///获取订单列表
- (void)getOrderListWithParam:(StairCategoryReq *) req response:(responseModel) responseModel;
///获取订单详情
- (void)getDetailOrderWithParam:(StairCategoryReq *) req response:(responseModel) responseModel;
///提醒发货
- (void)noticeOrderWithParam:(StairCategoryReq *) req response:(responseModel) responseModel;
///再来一单
- (void)againOrderWithParam:(StairCategoryReq *) req response:(responseModel) responseModel;
///取消订单
- (void)cancleOrderWithParam:(StairCategoryReq *) req response:(responseModel) responseModel;
///删除订单
- (void)deleteOrderWithParam:(StairCategoryReq *) req response:(responseModel) responseModel;
///确认收货
- (void)confirmOrderWithParam:(StairCategoryReq *) req response:(responseModel) responseModel;
///退款
- (void)refundOrderWithParam:(RefundOrderReq *) req response:(responseModel) responseModel;
@end
