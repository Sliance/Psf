//
//  EpicureProductModel.h
//  Psf
//
//  Created by zhangshu on 2019/1/15.
//  Copyright © 2019 zhangshu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface EpicureProductModel : NSObject
///
@property(nonatomic,strong)NSArray *epicureMobileV1ProductWrapper;
///
@property(nonatomic,copy)NSString *ingredientsCategoryId;
///
@property(nonatomic,copy)NSString *ingredientsCategoryName;
///
@property(nonatomic,copy)NSString *priority;

@end

NS_ASSUME_NONNULL_END
