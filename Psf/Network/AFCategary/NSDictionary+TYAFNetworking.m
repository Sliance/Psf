//
//  NSDictionary+TYAFNetworking.m
//  ticket99
//
//  Created by jianzhong on 28/1/15.
//  Copyright (c) 2015 xuzhq. All rights reserved.
//

#import "NSDictionary+TYAFNetworking.h"
#import "NSArray+TYAFNetworking.h"

@implementation NSDictionary (TYAFNetworking)
/** 字符串前面是没有问号的，如果用于POST，那就不用加问号，如果用于GET，就要加个问号
 PARAM:isForSignature
 YES:拼接的字符串前加？ 用于GET请求
 NO:拼接字符串前不加问号  用于POST请求
 */
- (NSString *)TY_urlParamsStringSignature:(BOOL)isForSignature
{
    NSArray *sortedArray = [self TY_transformedUrlParamsArraySignature:isForSignature];
    return [sortedArray TY_paramsString];
}

/** 字典变json */
- (NSString *)TY_jsonString
{
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:nil error:NULL];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

/** 转义参数 */
- (NSArray *)TY_transformedUrlParamsArraySignature:(BOOL)isForSignature
{
    NSMutableArray *result = [[NSMutableArray alloc] init];
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        if (![obj isKindOfClass:[NSString class]]) {
            obj = [NSString stringWithFormat:@"%@", obj];
        }
        if (!isForSignature) {
            obj = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL,  (CFStringRef)obj,  NULL,  (CFStringRef)@"!*'();:@&;=+$,/?%#[]|",  kCFStringEncodingUTF8));
        }
        if ([obj length] > 0) {
            [result addObject:[NSString stringWithFormat:@"%@=%@", key, obj]];
        } else {
            [result addObject:[NSString stringWithFormat:@"%@=%@", key, @""]];
        }
    }];
    NSArray *sortedResult = [result sortedArrayUsingSelector:@selector(compare:)];
    return sortedResult;
}

@end
