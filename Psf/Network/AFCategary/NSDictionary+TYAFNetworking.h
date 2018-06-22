//
//  NSDictionary+TYAFNetworking.h
//  ticket99
//
//  Created by jianzhong on 28/1/15.
//  Copyright (c) 2015 xuzhq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (TYAFNetworking)

/** 字符串前面是没有问号的，如果用于POST，那就不用加问号，如果用于GET，就要加个问号 */
- (NSString *)TY_urlParamsStringSignature:(BOOL)isForSignature;

/** 字典变json */
- (NSString *)TY_jsonString;

/** 转义参数 */
- (NSArray *)TY_transformedUrlParamsArraySignature:(BOOL)isForSignature;

@end
