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
+  (NSString *)cStringFromTimestamp:(NSString *)timestamp Formatter:(NSString*)formatter{
    //时间戳转时间的方法
    NSTimeInterval interval    =[timestamp doubleValue] / 1000.0;
    NSDate *timeData = [NSDate dateWithTimeIntervalSince1970:interval];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:formatter];
    NSString *strTime = [dateFormatter stringFromDate:timeData];
    return strTime;
}

/**
 *  计算剩余时间
 *
 *  @param endTime   结束日期
 *
 *  @return 剩余时间
 */
+(NSString *)getCountDownStringWithEndTime:(NSString *)endTime {
    NSDate *nowDate = [NSDate date];
    NSDateFormatter *dateFomatter = [[NSDateFormatter alloc] init];
    dateFomatter.dateFormat = @"yyyy-MM-dd HH:mm:ss.0";
    // 截止时间字符串格式
    NSString *expireDateStr = endTime;
    // 当前时间字符串格式
    NSString *nowDateStr = [dateFomatter stringFromDate:nowDate];
    // 截止时间data格式
    NSDate *expireDate = [dateFomatter dateFromString:expireDateStr];
    // 当前时间data格式
    nowDate = [dateFomatter dateFromString:nowDateStr];
    // 当前日历
    NSCalendar *calendar = [NSCalendar currentCalendar];
    // 需要对比的时间数据
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth
    | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    // 对比时间差
    NSDateComponents *dateCom = [calendar components:unit fromDate:nowDate toDate:expireDate options:0];

    NSString * timeStr;
    if (dateCom.day==0) {
         timeStr = [NSString stringWithFormat:@"%02ld:%02ld:%02ld",dateCom.hour,dateCom.minute,dateCom.second];
    }else{
        timeStr = [NSString stringWithFormat:@"%ld天%02ld:%02ld:%02ld",dateCom.day,dateCom.hour,dateCom.minute,dateCom.second];
    }
    if (dateCom.second<0) {
        timeStr = @"已截单";
    }
    return timeStr;
}

@end
