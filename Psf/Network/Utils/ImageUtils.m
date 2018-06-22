//
//  ImageUtils.m
//  PropertyProject
//
//  Created by liujianzhong on 15/12/9.
//  Copyright © 2015年 liujianzhong. All rights reserved.
//

#import "ImageUtils.h"

@implementation ImageUtils
+ (UIImage*) createImageWithColor: (UIColor*) color
{
    CGRect rect=CGRectMake(0,0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}
@end
