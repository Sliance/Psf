//
//  NSArray+TYAFNetworking.h
//  ticket99
//
//  Created by jianzhong on 28/1/15.
//  Copyright (c) 2015 xuzhq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (TYAFNetworking)

/** 字母排序之后形成的参数字符串 */
- (NSString *)TY_paramsString;

/** 数组变json */
- (NSString *)TY_jsonString;

@end
