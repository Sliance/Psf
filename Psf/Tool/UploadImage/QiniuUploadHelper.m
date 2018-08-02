//
//  QiniuUploadHelper.m
//  SupplierApp
//
//  Created by 安天洋 on 2017/3/30.
//  Copyright © 2017年 liujianzhong. All rights reserved.
//

#import "QiniuUploadHelper.h"

@implementation QiniuUploadHelper


static id _instance = nil;
+ (id)allocWithZone:(struct _NSZone *)zone {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}

+ (instancetype)sharedUploadHelper {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}

- (id)copyWithZone:(NSZone *)zone {
    
    return _instance;
}
@end
