//
//  UserDetaultCashe.h
//  PropertyProject
//
//  Created by liujianzhong on 15/12/2.
//  Copyright © 2015年 liujianzhong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserDefaultCashe : NSObject

+ (void)casheDicWith:(NSDictionary *) dic forKey:(NSString *) key;
+ (NSDictionary *)fetchDicWithKey:(NSString *) key;

+ (void)casheArrayWith:(NSArray *) array forKey:(NSString *) key;
+ (NSArray *)fetchArrayWithKey:(NSString *) key;

+ (void)casheStringWith:(NSString *) string forKey:(NSString *) key;
+ (NSString *)fetchStringWithKey:(NSString *) key;

@end
