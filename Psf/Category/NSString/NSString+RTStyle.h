//
//  NSString+RTStyle.h
//  DistributionProject
//
//  Created by liujianzhong on 15/7/20.
//  Copyright (c) 2015年 T.E.N_. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (RTStyle)

+ (NSString *)getCommonBundlePath:(NSString *)fileName;
+ (NSString *)getStyleBundlePath:(NSString *)fileName;

- (NSString *)caculateNumberString;

@end
