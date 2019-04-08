//
//  DetailRecipeRes.h
//  Psf
//
//  Created by zhangshu on 2019/1/15.
//  Copyright © 2019 zhangshu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DetailRecipeRes : NSObject
///
@property(nonatomic,copy)NSString *epicureId;
///
@property(nonatomic,copy)NSString *epicureImgId;
///
@property(nonatomic,copy)NSString *epicureImgPath;
///
@property(nonatomic,strong)NSMutableArray *epicureMobileV1IngredientsInfoWrappers;
///
@property(nonatomic,copy)NSString *howTOMake;
///
@property(nonatomic,copy)NSString *epicureName;


@end

NS_ASSUME_NONNULL_END
