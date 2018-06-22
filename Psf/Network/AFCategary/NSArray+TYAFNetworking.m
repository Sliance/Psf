//
//  NSArray+TYAFNetworking.m
//  ticket99
//
//  Created by jianzhong on 28/1/15.
//  Copyright (c) 2015 xuzhq. All rights reserved.
//

#import "NSArray+TYAFNetworking.h"

@implementation NSArray (TYAFNetworking)
/** 字母排序之后形成的参数字符串 */
- (NSString *)TY_paramsString
{
    NSMutableString *paramString = [[NSMutableString alloc] init];
    
    NSArray *sortedParams = [self sortedArrayUsingSelector:@selector(compare:)];
    [sortedParams enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([paramString length] == 0) {
            [paramString appendFormat:@"%@", obj];
        } else {
            [paramString appendFormat:@"&%@", obj];
        }
    }];
    
    return paramString;
}

/** 数组变json */
- (NSString *)TY_jsonString
{
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:NULL];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

@end
