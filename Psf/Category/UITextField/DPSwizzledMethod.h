//
//  DPSwizzledMethod.h
//  SupplierApp
//
//  Created by 张舒 on 17/4/1.
//  Copyright © 2017年 liujianzhong. All rights reserved.
//

#import <Foundation/Foundation.h>

void swizzleMethod(Class originalClass, SEL originalSelector, Class swizzledClass,SEL swizzledSelector);
