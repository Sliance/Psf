//
//  DPSwizzledMethod.m
//  SupplierApp
//
//  Created by 张舒 on 17/4/1.
//  Copyright © 2017年 liujianzhong. All rights reserved.
//

#import "DPSwizzledMethod.h"
#import <objc/runtime.h>
void swizzleMethod(Class originalClass, SEL originalSelector, Class swizzledClass,SEL swizzledSelector)
{
    Method originalMethod = class_getInstanceMethod(originalClass, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(swizzledClass, swizzledSelector);
    
    BOOL didAddMethod = class_addMethod(originalClass, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    if (didAddMethod) {
        class_replaceMethod(originalClass, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    }
    else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}
