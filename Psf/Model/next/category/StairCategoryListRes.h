//
//  StairCategoryListRes.h
//  Psf
//
//  Created by 燕来秋mac9 on 2018/7/9.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StairCategoryListRes : NSObject
///
@property(nonatomic,assign)NSInteger productId;
///图片
@property(nonatomic,copy)NSString *productImagePath;
///名字
@property(nonatomic,copy)NSString *productName;
//价格
@property(nonatomic,copy)NSString *productPrice;
///内容
@property(nonatomic,copy)NSString *productTitle;
///单位
@property(nonatomic,copy)NSString *productUnit;
///重量
@property(nonatomic,assign)NSNumber *productWeight;
@end
