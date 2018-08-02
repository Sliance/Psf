//
//  UIImage+RTStyle.h
//  DistributionProject
//
//  Created by liujianzhong on 15/7/20.
//  Copyright (c) 2015年 T.E.N_. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (RTStyle)

- (UIImage *)autoResizableWidthImage;
- (UIImage *)autoResizableHeightImage;
- (UIImage *)autoResizableImage;

+ (UIImage *)createImageWithColor:(UIColor *)color;
+ (UIImage *)resizeImage:(UIImage *)image size:(CGSize)size;
+ (UIImage *)createMaskWithImage:(UIImage *)image outColor:(UIColor *)outColor innerColor:(UIColor *)innerColor;
//+ (UIImage *)getCommonBundleImage:(NSString *)fileName;
+ (UIImage *)getStyleBundleImage:(NSString *)fileName;
+ (UIImage *)autoGetImage:(NSString *)fileName;

+ (UIImage *)addImage:(UIImage *)image1 toImage:(UIImage *)image2;

@end
