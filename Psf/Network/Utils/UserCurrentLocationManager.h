//
//  UserCurrentLocationManager.h
//  AgentApp
//
//  Created by liujianzhong on 16/11/4.
//  Copyright © 2016年 liujianzhong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserCurrentLocationManager : NSObject
+ (instancetype)share;
- (void)initManager;
- (void)startLocation;
- (NSString *)getLocalLat;
- (NSString *)getLocalLon;

@end
