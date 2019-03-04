//
//  TimeBuyModel.h
//  Psf
//
//  Created by zhangshu on 2019/2/21.
//  Copyright © 2019 zhangshu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TimeBuyModel : NSObject
///
@property(nonatomic,copy)NSString * activityEndTime;
///
@property(nonatomic,copy)NSString *activityName;
///
@property(nonatomic,copy)NSString *ruleActivityId;
///
@property(nonatomic,assign)NSInteger activityStartTime;
///
@property(nonatomic,copy)NSString *activityImagePath;
///
@property(nonatomic,copy)NSString *activityImageId;

///
@property(nonatomic,assign)NSInteger productId;
///
@property(nonatomic,copy)NSString *erpProductId;
///
@property(nonatomic,copy)NSString *productUnit;
///
@property(nonatomic,copy)NSString *productWeight;
///
@property(nonatomic,copy)NSString *productName;
///
@property(nonatomic,copy)NSString *productTitle;
///
@property(nonatomic,copy)NSString *productImagePath;
///
@property(nonatomic,assign)NSInteger productStyle;
///
@property(nonatomic,assign)NSInteger productSaleArtificialCount;
///
@property(nonatomic,assign)NSInteger productSaleSystemCount;
///
@property(nonatomic,copy)NSString *productActivityPrice;
///
@property(nonatomic,copy)NSString *productPrice;
///
@property(nonatomic,strong)NSString *productLabel;

@end

NS_ASSUME_NONNULL_END
