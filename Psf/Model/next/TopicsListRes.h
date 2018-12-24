//
//  TopicsListRes.h
//  Psf
//
//  Created by zhangshu on 2018/12/24.
//  Copyright © 2018 zhangshu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StairCategoryListRes.h"

NS_ASSUME_NONNULL_BEGIN

@interface TopicsListRes : NSObject
///
@property(nonatomic,copy)NSString *subjectTopImagePath;
///
@property(nonatomic,copy)NSString *subjectImagePath;
///
@property(nonatomic,strong)NSArray *subjectCategoryList;
///
@property(nonatomic,strong)NSArray *subjectCustomCategoryList;
///
@property(nonatomic,strong)NSArray *subjectTopProductList;

@end

NS_ASSUME_NONNULL_END
