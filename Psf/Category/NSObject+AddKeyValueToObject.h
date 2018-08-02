//
//  NSObject+AddKeyValueToObject.h
//  DistributionProject
//
//  Created by liujianzhong on 15/7/20.
//  Copyright (c) 2015年 T.E.N_. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (AddKeyValueToObject)

@property (nonatomic, strong) id objectDSValue;

- (NSString *)DSJSONRepresentation;

@end
