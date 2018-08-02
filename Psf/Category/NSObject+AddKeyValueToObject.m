//
//  NSObject+AddKeyValueToObject.m
//  DistributionProject
//
//  Created by liujianzhong on 15/7/20.
//  Copyright (c) 2015年 T.E.N_. All rights reserved.
//

#import "NSObject+AddKeyValueToObject.h"
#import <objc/runtime.h>

static void *DSObjectValueParam;

@implementation NSObject (AddKeyValueToObject)

- (void)setObjectDSValue:(id)requestParams
{
    objc_setAssociatedObject(self, &DSObjectValueParam, requestParams, OBJC_ASSOCIATION_COPY);
}

- (id)objectDSValue
{
    return objc_getAssociatedObject(self, &DSObjectValueParam);
}

- (NSString *)DSJSONRepresentation {
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:&error];
    if (!jsonData) {
        NSLog(@"RTJSONRepresentation error: %@", error);
        return @"";
    }
    
    NSString* jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return jsonStr;
}

@end
