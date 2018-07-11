//
//  GoodDetailRes.m
//  Psf
//
//  Created by 燕来秋mac9 on 2018/7/9.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "GoodDetailRes.h"

@implementation GoodDetailRes

+ (NSDictionary *)mj_objectClassInArray {
    
    return @{
             @"productSkuList" : @"ProductSkuModel",
             @"productImageList":@"ImageModel"
             };
}
@end
