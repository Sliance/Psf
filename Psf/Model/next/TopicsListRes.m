//
//  TopicsListRes.m
//  Psf
//
//  Created by zhangshu on 2018/12/24.
//  Copyright © 2018 zhangshu. All rights reserved.
//

#import "TopicsListRes.h"

@implementation TopicsListRes
+ (NSDictionary *)mj_objectClassInArray {
    
    return @{
             @"subjectTopProductList" : @"StairCategoryListRes",
             @"subjectCustomCategoryList":@"SubjectCategoryModel",
             };
}
@end
