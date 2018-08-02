//
//  NSString+RTStyle.m
//  DistributionProject
//
//  Created by liujianzhong on 15/7/20.
//  Copyright (c) 2015年 T.E.N_. All rights reserved.
//

#import "NSString+RTStyle.h"

@implementation NSString (RTStyle)

+ (NSString *)getCommonBundlePath:(NSString *)fileName{
    NSString *main_images_dir_path = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"RTCommonImages.bundle"];
    NSAssert(main_images_dir_path, @"main_images_dir_path is null");
    return [main_images_dir_path stringByAppendingPathComponent:fileName];
}

+ (NSString *)getStyleBundlePath:(NSString *)fileName{
    NSString *bundleName = @"";
    NSString *main_images_dir_path = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:bundleName];
    NSAssert(main_images_dir_path, @"main_images_dir_path is null");
    return [main_images_dir_path stringByAppendingPathComponent:fileName];
}

- (NSString *)caculateNumberString{
    NSArray *arrayChar = @[@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9"];
    NSString *stringResult = @"";
    for (int i = 0; i < self.length; i ++) {
        NSString *subString = [self substringWithRange:NSMakeRange(i, 1)];
        if ([arrayChar containsObject:subString]) {
            stringResult = [NSString stringWithFormat:@"%@%@", stringResult, subString];
        }
    }
    return stringResult;
}

@end
