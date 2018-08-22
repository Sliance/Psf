//
//  CalculateReq.h
//  Psf
//
//  Created by 燕来秋mac9 on 2018/7/19.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalculateReq : NSObject
///(181)
@property(nonatomic,copy)NSString *erpStoreId;
///是否使用积分
@property(nonatomic,assign)BOOL usePointIs;
///商品列表
@property(nonatomic,strong)NSArray *productList;
///使用的优惠卷ID
@property(nonatomic,copy)NSString *couponId;
///是否使用余额
@property(nonatomic,assign)BOOL useIsBalance;
///是否配送
@property(nonatomic,assign)BOOL expressEnable;
///发货开始时间
@property(nonatomic,copy)NSString* saleOrderDistributionStartTime;
///发货结束时间
@property(nonatomic,copy)NSString* saleOrderDistributionEndTime;

///应用编号
@property(nonatomic,copy)NSString *appId;
///
@property(nonatomic,copy)NSString *token;
///客户端
@property(nonatomic,strong)NSString *platform;
///时间戳
@property(nonatomic,copy)NSString *timestamp;

///商品编号
@property(nonatomic,assign)NSInteger productId;
///购买数量
@property(nonatomic,assign)NSInteger saleOrderProductQty;
@property(nonatomic,assign)NSInteger productSkuId ;
///是否选中微信
@property(nonatomic,assign)BOOL useIsWeChart;
@end
