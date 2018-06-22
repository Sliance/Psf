//
//  DSBaseModel.h
//  DistributionProject
//
//  Created by liujianzhong on 15/7/15.
//  Copyright © 2015年 T.E.N_. All rights reserved.
//
/**
 一：必须实现下面方法，做好从dic转成对象时的key的对应关系
 + (NSDictionary *)JSONKeyPathsByPropertyKey {
 
 二：把一个dictionary转成object
 NSError *error = nil;
 XYUser *user = [MTLJSONAdapter modelOfClass:XYUser.class fromJSONDictionary:JSONDictionary error:&error];
 
 三：把一个object转成nsdictionary
 NSDictionary *JSONDictionary = [MTLJSONAdapter JSONDictionaryFromModel:user];
 
 四：JSON返回的数据分为NSArray,NSDictinory,NSNumber,NSString,所以我们的model中对于int，bool，float等等类型都要写成NSNunber
 
 */
#import <Foundation/Foundation.h>
#import "Mantle.h"

@interface DSBaseModel : MTLModel <MTLJSONSerializing>

@end
