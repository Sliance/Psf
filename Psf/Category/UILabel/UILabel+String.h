//
//  UILabel+String.h
//  Shh
//
//  Created by 燕来秋mac9 on 2018/8/28.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (String)
+ (UILabel *)createFont:(UIFont *)font color:(UIColor *)color;
+ (UILabel *)createFont:(UIFont *)font color:(UIColor *)color alignment:(NSTextAlignment)alignment;
/**
 设置文本,并指定行间距
 
 @param text 文本内容
 @param lineSpacing 行间距
 */
-(void)setText:(NSString*)text lineSpacing:(CGFloat)lineSpacing;
-(void)setTotal:(NSString*)text stringArray:(NSArray *)strArray
     colorArray:(NSArray *)colorArray
      fontArray:(NSArray *)fontArray;


///计算label高度
- (CGFloat)getHeightLineWithString:(NSString *)string withWidth:(CGFloat)width withFont:(UIFont *)font  lineSpacing:(CGFloat)lineSpacing;
/*!
 * 根据指定文本和字体计算宽度
 */
- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font;
@end
