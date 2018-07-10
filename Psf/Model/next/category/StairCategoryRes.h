//
//  StairCategoryRes.h
//  Psf
//
//  Created by 燕来秋mac9 on 2018/7/6.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZSConfig.h"
#import "StairCategoryListRes.h"

@interface StairCategoryRes : NSObject
///
@property(nonatomic,assign)NSInteger productCategoryId;
///图片
@property(nonatomic,copy)NSString *productCategoryImagePath;
///名字
@property(nonatomic,copy)NSString *productCategoryName;
///
@property(nonatomic,copy)NSString *productCategoryParentId;
///分类下商品
@property(nonatomic,copy)NSArray *productList;
@end
