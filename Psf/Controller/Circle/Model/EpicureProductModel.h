//
//  EpicureProductModel.h
//  Psf
//
//  Created by zhangshu on 2019/1/15.
//  Copyright © 2019 zhangshu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CartProductModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface EpicureProductModel : NSObject
///
@property(nonatomic,strong)NSMutableArray <CartProductModel*>*epicureMobileV1ProductWrapper;
///
@property(nonatomic,strong)NSString *ingredientsCategoryId;
///
@property(nonatomic,strong)NSString *ingredientsCategoryName;
///
@property(nonatomic,strong)NSString *priority;

@end

NS_ASSUME_NONNULL_END
