//
//  NSURLRequest+TYAFNetworking.m
//  ticket99
//
//  Created by jianzhong on 29/1/15.
//  Copyright (c) 2015 xuzhq. All rights reserved.
//

#import "NSURLRequest+TYAFNetworking.h"
#import <objc/runtime.h>

static void *TYNetworkingRequestParams;

@implementation NSURLRequest (TYAFNetworking)

- (void)setRequestParams:(NSDictionary *)requestParams
{
    objc_setAssociatedObject(self, &TYNetworkingRequestParams, requestParams, OBJC_ASSOCIATION_COPY);
}

- (NSDictionary *)requestParams
{
    return objc_getAssociatedObject(self, &TYNetworkingRequestParams);
}

@end
