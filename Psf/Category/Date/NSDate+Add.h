//
//  NSDate+Add.h
//  Psf
//
//  Created by 燕来秋mac9 on 2018/7/19.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Add)


// 字符串时间—>时间戳
+ (NSString *)cTimestampFromString:(NSString *)theTime ;
// 时间戳—>字符串时间
+ (NSString *)cStringFromTimestamp:(NSString *)timestamp Formatter:(NSString*)formatter;
/**
 *  计算剩余时间
 *
 *  @param endTime   结束日期
 *
 *  @return 剩余时间
 */
+(NSString *)getCountDownStringWithEndTime:(NSString *)endTime;

@end
