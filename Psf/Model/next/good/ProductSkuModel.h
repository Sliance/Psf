//
//  ProductSkuModel.h
//  Psf
//
//  Created by 燕来秋mac9 on 2018/7/11.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProductSkuModel : NSObject
///
@property(nonatomic, assign)NSInteger productSkuId;
///
@property(nonatomic, assign)NSInteger productSkuIsDefault;
///
@property(nonatomic, assign)NSInteger productSkuStock;

///
@property(nonatomic, copy)NSString *productSkuMarketPrice;
///
@property(nonatomic, copy)NSString *productSkuName;
///
@property(nonatomic, copy)NSString *productSkuPrice;
///
@property(nonatomic, copy)NSString *productSkuUnit;
///
@property(nonatomic, copy)NSString *productSkuWeight;

@end
