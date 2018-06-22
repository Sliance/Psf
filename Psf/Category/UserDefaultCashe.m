//
//  UserDetaultCashe.m
//  PropertyProject
//
//  Created by liujianzhong on 15/12/2.
//  Copyright © 2015年 liujianzhong. All rights reserved.
//

#import "UserDefaultCashe.h"

@implementation UserDefaultCashe

+ (void)casheDicWith:(NSDictionary *) dic forKey:(NSString *) key {
    [[NSUserDefaults standardUserDefaults] setObject:dic forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSDictionary *)fetchDicWithKey:(NSString *) key {
    NSDictionary *dic = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
    return dic;
}

+ (void)casheArrayWith:(NSArray *) array forKey:(NSString *) key {
    [[NSUserDefaults standardUserDefaults] setObject:array forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSArray *)fetchArrayWithKey:(NSString *) key {
    NSArray *array = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
    return array;
}

+ (void)casheStringWith:(NSString *) string forKey:(NSString *) key {
    [[NSUserDefaults standardUserDefaults] setObject:string forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSString *)fetchStringWithKey:(NSString *) key {
    NSString *string = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
    return string;
}

@end
