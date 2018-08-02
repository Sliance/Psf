//
//  UIImage+Resize.h
//  DistributionProject
//
//  Created by liujianzhong on 15/7/20.
//  Copyright (c) 2015年 T.E.N_. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Resize)

- (UIImage *)croppedImage:(CGRect)bounds;
- (UIImage *)thumbnailImage:(NSInteger)thumbnailSize transparentBorder:(NSUInteger)borderSize cornerRadius:(NSUInteger)cornerRadius interpolationQuality:(CGInterpolationQuality)quality;
- (UIImage *)resizedImage:(CGSize)newSize interpolationQuality:(CGInterpolationQuality)quality;
/**
 压缩图片
 contentMode：设置压缩图片的类型，图片全部展示在压缩框内还是说用压缩框的尺寸去截取图片，选择正确地方式
 bounds：是我要压缩的图片的尺寸，
 quality：图片处理的质量，
 */
- (UIImage *)resizedImageWithContentMode:(UIViewContentMode)contentMode bounds:(CGSize)bounds interpolationQuality:(CGInterpolationQuality)quality;

- (UIImage *)resizedImage:(CGSize)newSize transform:(CGAffineTransform)transform drawTransposed:(BOOL)transpose interpolationQuality:(CGInterpolationQuality)quality;

- (CGAffineTransform)transformForOrientation:(CGSize)newSize;

@end
