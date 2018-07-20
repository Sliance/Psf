//
//  GroupListRes.h
//  Psf
//
//  Created by 燕来秋mac9 on 2018/7/13.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GroupListRes : NSObject
///成团过期小时
@property(nonatomic,copy)NSString *grouponActiveExpireHour;
///成团过期时间
@property(nonatomic,copy)NSString *grouponExpireTime;
///商品编号
@property(nonatomic,assign)NSInteger productId;
///商品名称
@property(nonatomic,copy)NSString *productName;
///商品标题
@property(nonatomic,copy)NSString *productTitle;
///商品价格
@property(nonatomic,copy)NSString *productPrice;
///单位
@property(nonatomic,copy)NSString *productUnit;
///团购价格
@property(nonatomic,copy)NSString *grouponPrice;
///商品图片路径
@property(nonatomic,copy)NSString *productImagePath;
///预售编号
@property(nonatomic,copy)NSString *preSaleId;
///预售过期时间
@property(nonatomic,copy)NSString *preSaleExpireTime;
@end
