//
//  UIImage+RTStyle.m
//  DistributionProject
//
//  Created by liujianzhong on 15/7/20.
//  Copyright (c) 2015年 T.E.N_. All rights reserved.
//

#import "UIImage+RTStyle.h"
#import "NSString+RTStyle.h"

@implementation UIImage (RTStyle)

- (UIImage *)autoResizableWidthImage{
    UIEdgeInsets insets = UIEdgeInsetsMake(0, ceil(self.size.width/2), 0, ceil(self.size.width/2)+1);
    return  [self resizableImageWithCapInsets:insets];
}

- (UIImage *)autoResizableHeightImage{
    UIEdgeInsets insets = UIEdgeInsetsMake(ceil(self.size.height/2), 0, ceil(self.size.height/2)+1, 0);
    return  [self resizableImageWithCapInsets:insets];
}

- (UIImage *)autoResizableImage{
    UIEdgeInsets insets = UIEdgeInsetsMake(ceil(self.size.height/2), ceil(self.size.width/2), ceil(self.size.height/2)+1, ceil(self.size.width/2)+1);
    return  [self resizableImageWithCapInsets:insets];
}

+ (UIImage *)createImageWithColor:(UIColor *) color
{
    CGRect rect = CGRectMake(0.0f,0.0f,1.0f,1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context =UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage =UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

+ (UIImage *)resizeImage:(UIImage *)image size:(CGSize)size{
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
    
    // Create a stretchable image using the TabBarSelection image but offset 4 pixels down
    [image drawInRect:CGRectMake(0, 0.0, size.width, size.height)];
    
    // Generate a new image
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

+ (UIImage *)createMaskWithImage:(UIImage *)image outColor:(UIColor *)outColor innerColor:(UIColor *)innerColor{
    // Create the proper sized rect
    CGRect imageRect = CGRectMake(0, 0, CGImageGetWidth(image.CGImage), CGImageGetHeight(image.CGImage));
    
    // Create a new bitmap context
    CGContextRef context = CGBitmapContextCreate(NULL, imageRect.size.width, imageRect.size.height, 8, 0, CGImageGetColorSpace(image.CGImage), kCGBitmapAlphaInfoMask);
    
    CGContextSetFillColorWithColor(context, outColor.CGColor);
    CGContextFillRect(context, imageRect);
    
    // Use the passed in image as a clipping mask
    CGContextClipToMask(context, imageRect, image.CGImage);
    
    CGContextSetFillColorWithColor(context, innerColor.CGColor);
    CGContextFillRect(context, imageRect);
    
    // Generate a new image
    CGImageRef newCGImage = CGBitmapContextCreateImage(context);
    UIImage* newImage = [UIImage imageWithCGImage:newCGImage scale:image.scale orientation:image.imageOrientation];
    
    // Cleanup
    CGContextRelease(context);
    CGImageRelease(newCGImage);
    
    return newImage;
}

//+ (UIImage *)getCommonBundleImage:(NSString *)fileName{
//    return [UIImage imageWithContentsOfFile:[NSString getCommonBundlePath:fileName]];
//}

+ (UIImage *)getStyleBundleImage:(NSString *)fileName{

    return [UIImage imageWithContentsOfFile:[NSString getStyleBundlePath:fileName]];
}

+ (UIImage *)autoGetImage:(NSString *)fileName{
    NSInteger pathCount = [[fileName pathComponents] count];
    if (pathCount>2) {
        return [UIImage imageWithContentsOfFile:fileName];
    }else{
        return [UIImage imageNamed:fileName];
    }
}

+ (UIImage *)addImage:(UIImage *)image1 toImage:(UIImage *)image2 {
    UIGraphicsBeginImageContext(image1.size);
    
    // Draw image1
    [image1 drawInRect:CGRectMake(0, 0, image1.size.width, image1.size.height)];
    
    // Draw image2
    [image2 drawInRect:CGRectMake(0, 0, image2.size.width, image2.size.height)];
    
    UIImage *resultingImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return resultingImage;
}
@end
