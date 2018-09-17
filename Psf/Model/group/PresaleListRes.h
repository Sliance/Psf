//
//  PresaleListRes.h
//  Psf
//
//  Created by 燕来秋mac9 on 2018/9/17.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PresaleListRes : NSObject
///日期
@property(nonatomic,copy)NSString *preSaleExpireTimeStr;
///星期
@property(nonatomic,copy)NSString *preSaleExpireTimeWeek;
///model
@property(nonatomic,strong)NSArray *preSaleMobileV1ListResponseList;
@end
