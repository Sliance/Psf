//
//  NSDate+Add.m
//  Psf
//
//  Created by 燕来秋mac9 on 2018/7/19.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "NSDate+Add.h"

@implementation NSDate (Add)

// 字符串时间—>时间戳  
+ (NSString *)cTimestampFromString:(NSString *)theTime{
    // theTime __@"%04d-%02d-%02d %02d:%02d:00"
    // 转换为时间戳
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    // NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    // [formatter setTimeZone:timeZone];
    NSDate* dateTodo = [formatter dateFromString:theTime];
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[dateTodo timeIntervalSince1970]];
    return timeSp;

}

// 时间戳—>字符串时间
+ (NSString *)cStringFromTimestamp:(NSString *)timestamp {
    //时间戳转时间的方法
    NSDate *timeData = [NSDate dateWithTimeIntervalSince1970:[timestamp intValue]];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy年MM月dd日 HH:mm"];
    NSString *strTime = [dateFormatter stringFromDate:timeData];
    return strTime;
}

@end
