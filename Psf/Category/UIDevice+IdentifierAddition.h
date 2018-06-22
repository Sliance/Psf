//
//  UIDevice(Identifier).h
//  UIDeviceAddition
//
//  Created by Georg Kitz on 20.08.11.
//  Copyright 2011 Aurora Apps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIDevice (IdentifierAddition)

/*
 * @method uuid
 * @description apple identifier support iOS6 and iOS5 below
 */

- (NSString *) uuid;
- (NSString *) udid;
- (NSString *) macaddress;
- (NSString *) macaddressMD5;
- (NSString *) machineType;
- (NSString *) ostype;//显示“ios6，ios5”，只显示大版本号
- (NSString *) createUUID;
@end
