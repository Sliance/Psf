//
//  CouponListRes.h
//  Psf
//
//  Created by 燕来秋mac9 on 2018/7/13.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CouponListRes : NSObject
///优惠券过期时间
@property(nonatomic,copy)NSString *couponExpireTime;
///优惠券编号
@property(nonatomic,copy)NSString *couponId;
///优惠券生效时间
@property(nonatomic,copy)NSString *couponValidTime;
///优惠券会员编号
@property(nonatomic,copy)NSString* memberCouponId;

///优惠券图片路径
@property(nonatomic,copy)NSString* couponImagePath;
///优惠券名称
@property(nonatomic,copy)NSString* couponName;
///优惠券标题
@property(nonatomic,copy)NSString* couponTitle;
///优惠券类型
@property(nonatomic,copy)NSString* couponType;
@property(nonatomic,copy)NSString* couponSubTitle;
@property(nonatomic,copy)NSString* couponDescription;
///生效天数
@property(nonatomic,copy)NSString* couponValidDay;
@end
