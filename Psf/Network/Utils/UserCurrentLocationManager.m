//
//  UserCurrentLocationManager.m
//  AgentApp
//
//  Created by liujianzhong on 16/11/4.
//  Copyright © 2016年 liujianzhong. All rights reserved.
//

#import "UserCurrentLocationManager.h"
#import <CoreLocation/CLLocationManager.h>

@interface UserCurrentLocationManager () <CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) NSString *lat;
@property (nonatomic, strong) NSString *lon;

@end

@implementation UserCurrentLocationManager

#pragma mark - view life cycle
+ (instancetype)share {
    static UserCurrentLocationManager *global;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (global == nil) {
            global = [[UserCurrentLocationManager alloc] init];
        }
    });
    return global;
}

- (void)initManager {
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.distanceFilter = kCLDistanceFilterNone;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [self.locationManager requestWhenInUseAuthorization];
    [_locationManager requestWhenInUseAuthorization];
    [self startLocation];
}

#pragma mark - Actions
- (void)startLocation
{
    // 判断的手机的定位功能是否开启
    // 开启定位:设置 > 隐私 > 位置 > 定位服务
    if ([CLLocationManager locationServicesEnabled]) {
        // 启动位置更新
        // 开启位置更新需要与服务器进行轮询所以会比较耗电，在不需要时用stopUpdatingLocation方法关闭;
        [self.locationManager startUpdatingLocation];
        [_locationManager requestWhenInUseAuthorization];
    }
    else {
        NSLog(@"请开启定位功能！");
    }
}

- (NSString *)getLocalLat {
    if (self.lat != nil) {
        return self.lat;
    }
    return @"";
}

- (NSString *)getLocalLon {
    if (self.lon != nil) {
        return self.lon;
    }
    return @"";
}

#pragma mark - CLLocationManagerDelegate
// 地理位置发生改变时触发
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    // 获取经纬度
    NSLog(@"纬度:%f",newLocation.coordinate.latitude);
    NSLog(@"经度:%f",newLocation.coordinate.longitude);
    // 停止位置更新
    [manager stopUpdatingLocation];
}

// 定位失误时触发
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"error:%@",error);
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    CLLocation *location = [locations lastObject];
    NSLog(@"lat%f - lon%f", location.coordinate.latitude, location.coordinate.longitude);
    
    self.lat = [NSString stringWithFormat:@"lat%f",location.coordinate.latitude];
    self.lon = [NSString stringWithFormat:@"lon%f",location.coordinate.longitude];
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status  {

}

- (void)locationManager:(CLLocationManager *)manager didStartMonitoringForRegion:(CLRegion *)region {

}
@end