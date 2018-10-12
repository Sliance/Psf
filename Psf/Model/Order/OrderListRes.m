//
//  OrderListRes.m
//  Psf
//
//  Created by 燕来秋mac9 on 2018/7/23.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "OrderListRes.h"

@implementation OrderListRes
+ (NSDictionary *)mj_objectClassInArray {
    
    return @{
             @"saleOrderProductList":@"CartProductModel",
              @"productList":@"CartProductModel"
             };
}
@end
