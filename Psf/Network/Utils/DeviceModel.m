//
//  DeviceModel.m
//  DistributionProject
//
//  Created by liujianzhong on 15/7/18.
//  Copyright © 2015年 T.E.N_. All rights reserved.
//

#import "DeviceModel.h"
#import "UIDevice+IdentifierAddition.h"
#import "ZSAPIProxy.h"
#import <ifaddrs.h>
#import <arpa/inet.h>
#import <AdSupport/AdSupport.h>
#import <CoreLocation/CLLocation.h>
#import <CoreLocation/CoreLocation.h>
#import "UserCurrentLocationManager.h"

@implementation DeviceModel

+ (NSString *) hostname
{
    char baseHostName[256]; // Thanks, Gunnar Larisch
    int success = gethostname(baseHostName, 255);
    if (success != 0) return nil;
    baseHostName[255] = '\0';
    
#if TARGET_IPHONE_SIMULATOR
    return [NSString stringWithFormat:@"%s", baseHostName];
#else
    return [NSString stringWithFormat:@"%s.local", baseHostName];
#endif
}

+ (NSString *)localIPAddress
{
    NSString *address = @"error";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    // retrieve the current interfaces - returns 0 on success
    success = getifaddrs(&interfaces);
    if (success == 0) {
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        while(temp_addr != NULL) {
            if(temp_addr->ifa_addr->sa_family == AF_INET) {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                }
            }
            temp_addr = temp_addr->ifa_next;
        }
    }
    // Free memory
    freeifaddrs(interfaces);
    return address;
}

+ (NSString *)networkStatus {
    return [[ZSAPIProxy shareProxy] getNetworkingStatus];
}

+ (NSString *)deviceToken
{
    return @"";
}

+ (NSString *)uniqueIdentifier {
    UIDevice *device = [UIDevice currentDevice];
    return [device udid];
}

+ (NSString *)iosVersion {
    UIDevice *device = [UIDevice currentDevice];
    NSString *deviceString = [device systemVersion];
    if (deviceString == nil || deviceString.length == 0) {
        deviceString = @"";
    }
    return deviceString;
}

+ (NSString *)iosModel {
    UIDevice *device = [UIDevice currentDevice];
    NSString *deviceModel = [device model];
    if (deviceModel == nil || deviceModel.length == 0) {
        deviceModel = @"";
    }
    return deviceModel;
}


+ (NSString *)appVersion {
    NSString *appVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    if (!appVersion || [appVersion length] == 0)
        appVersion = @"0.0";
    return appVersion;
}

+ (NSString *)iosType{
    UIDevice *device = [UIDevice currentDevice];
    NSString *iosType = [device machineType];
    if (iosType == nil || iosType.length == 0) {
        iosType = [DeviceModel iosModel];
        if (iosType.length == 0) {
            iosType = @"";
        }
    }
    return iosType;
}

+ (NSString *)freeDiskspace {
    uint64_t totalSpace = 0;
    uint64_t totalFreeSpace = 0;
    NSError *error = nil;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSDictionary *dictionary = [[NSFileManager defaultManager] attributesOfFileSystemForPath:[paths lastObject] error: &error];
    
    if (dictionary) {
        NSNumber *fileSystemSizeInBytes = [dictionary objectForKey: NSFileSystemSize];
        NSNumber *freeFileSystemSizeInBytes = [dictionary objectForKey:NSFileSystemFreeSize];
        totalSpace = [fileSystemSizeInBytes unsignedLongLongValue];
        totalFreeSpace = [freeFileSystemSizeInBytes unsignedLongLongValue];
    } else {
    }
    
    return [NSString stringWithFormat:@"%llu", ((totalFreeSpace/1024ll)/1024ll)];
}

+ (NSString *)totalDiskspace {
    uint64_t totalSpace = 0;
    uint64_t totalFreeSpace = 0;
    NSError *error = nil;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSDictionary *dictionary = [[NSFileManager defaultManager] attributesOfFileSystemForPath:[paths lastObject] error: &error];
    
    if (dictionary) {
        NSNumber *fileSystemSizeInBytes = [dictionary objectForKey: NSFileSystemSize];
        NSNumber *freeFileSystemSizeInBytes = [dictionary objectForKey:NSFileSystemFreeSize];
        totalSpace = [fileSystemSizeInBytes unsignedLongLongValue];
        totalFreeSpace = [freeFileSystemSizeInBytes unsignedLongLongValue];
    }
    
    return [NSString stringWithFormat:@"%llu", ((totalSpace/1024ll)/1024ll)];
}

+ (UIDeviceBatteryState)batteryState {
    [[UIDevice currentDevice] setBatteryMonitoringEnabled:YES];
    
    return [[UIDevice currentDevice] batteryState];
}

+ (NSString *)batteryStateString {
    NSString *state;
    switch ([DeviceModel batteryState]) {
        case UIDeviceBatteryStateUnknown:
        {
            state = @"battery unknown";
        }
            break;
        case UIDeviceBatteryStateUnplugged:
        {
            state = @"no battery";
        }
            break;
        case UIDeviceBatteryStateCharging:
        {
            state = @"battery less than 100%";
        }
            break;
        case UIDeviceBatteryStateFull:
        {
            state = @"battery is full";
        }
            break;
        default:
            break;
    }
    
    return state;
}

+ (NSString *)idfaString
{
    
    NSBundle *adSupportBundle = [NSBundle bundleWithPath:@"/System/Library/Frameworks/AdSupport.framework"];
    [adSupportBundle load];
    if (adSupportBundle == nil) {
        return @"";
    }
    else{
        Class asIdentifierMClass = NSClassFromString(@"ASIdentifierManager");
        if(asIdentifierMClass == nil){
            return @"";
        }
        else{
            ASIdentifierManager *asIM = [[asIdentifierMClass alloc] init];
            if (asIM == nil) {
                return @"";
            }else{
                if(asIM.advertisingTrackingEnabled){
                    return [asIM.advertisingIdentifier UUIDString];
                } else{
                    return [asIM.advertisingIdentifier UUIDString];
                }
            }
        }
    }
}

+ (NSString *)getLocationStatus {
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    if (kCLAuthorizationStatusDenied == status || kCLAuthorizationStatusRestricted == status) {
        return @"0";
    }
    return @"1";
}

+ (CGFloat)getScreenScale {
    float scale = [[UIScreen mainScreen] scale];
    return scale;
}

+ (NSString *)getCurrentTime {
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss:SSS"];
    NSString *time = [formatter stringFromDate:date];
    if (time.length < 1) {
        time = @"";
    }
    return time;
}

+ (NSString *)getLatitude {
    return [[UserCurrentLocationManager share] getLocalLat];
}

+ (NSString *)getLongitude {
    return [[UserCurrentLocationManager share] getLocalLon];
}

@end
