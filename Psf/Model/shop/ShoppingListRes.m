//
//  ShoppingListRes.m
//  Psf
//
//  Created by 燕来秋mac9 on 2018/7/10.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "ShoppingListRes.h"

@implementation ShoppingListRes
+ (NSDictionary *)mj_objectClassInArray {
    
    return @{
             
             @"cartProductList":@"CartProductModel",
              @"preSaleProductList":@"CartProductModel",
              @"nextDayProductList":@"CartProductModel"
             };
}
@end
