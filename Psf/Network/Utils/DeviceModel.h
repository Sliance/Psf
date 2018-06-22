//
//  DeviceModel.h
//  DistributionProject
//
//  Created by liujianzhong on 15/7/18.
//  Copyright © 2015年 T.E.N_. All rights reserved.
//
#import <UIKit/UIKit.h>

#import "DSBaseModel.h"

@interface DeviceModel : DSBaseModel

+ (NSString *)deviceToken;
+ (NSString *)networkStatus;
+ (NSString *)localIPAddress;
+ (NSString *)uniqueIdentifier;
+ (NSString *)iosVersion;
+ (NSString *)appVersion;
+ (NSString *)iosModel;
+ (NSString *)iosType;
+ (UIDeviceBatteryState)batteryState;
+ (NSString *)batteryStateString;
+ (NSString *)totalDiskspace;
+ (NSString *)freeDiskspace;
+ (NSString *)idfaString;
+ (NSString *)getLocationStatus;//判断是否打开定位功能
+ (CGFloat)getScreenScale;
+ (NSString *)getCurrentTime;
+ (NSString *)getLatitude;//经度
+ (NSString *)getLongitude;//维度

@end
