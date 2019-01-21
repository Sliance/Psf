//
//  UIButton+DNUtility.m
//  DnaerApp
//
//  Created by 燕来秋 on 2018/11/2.
//  Copyright © 2018 燕来秋. All rights reserved.
//

#import "UIButton+DNUtility.h"

@implementation UIButton (DNUtility)

+ (UIButton *)createWithType:(UIButtonType)type target:(id)target action:(SEL)action {
    UIButton *btn = [UIButton buttonWithType:type];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return btn;
}

+ (UIButton *)createWithFrame:(CGRect)frame type:(UIButtonType)type target:(id)target action:(SEL)action {
    UIButton *btn = [self createWithType:type target:target action:action];
    return btn;
}

- (void)setIconInLeftWithSpacing:(CGFloat)Spacing
{
    self.titleEdgeInsets = (UIEdgeInsets){
        .top    = 0,
        .left   = Spacing/2,
        .bottom = 0,
        .right  = -Spacing/2,
    };
    
    self.imageEdgeInsets = (UIEdgeInsets){
        .top    = 0,
        .left   = -Spacing/2,
        .bottom = 0,
        .right  = Spacing/2,
    };
}

- (void)setIconInRightWithSpacing:(CGFloat)Spacing
{
    CGFloat img_W = self.imageView.frame.size.width;
    CGFloat tit_W = self.titleLabel.frame.size.width;
    
    self.titleEdgeInsets = (UIEdgeInsets){
        .top    = 0,
        .left   = - (img_W + Spacing / 2),
        .bottom = 0,
        .right  =   (img_W + Spacing / 2),
    };
    
    self.imageEdgeInsets = (UIEdgeInsets){
        .top    = 0,
        .left   =   (tit_W + Spacing / 2),
        .bottom = 0,
        .right  = - (tit_W + Spacing / 2),
    };
}
- (void)setIconInTopWithSpacing:(CGFloat)Spacing
{
    CGFloat img_W = self.imageView.frame.size.width;
    CGFloat img_H = self.imageView.frame.size.height;
    CGFloat tit_W = self.titleLabel.frame.size.width;
    CGFloat tit_H = self.titleLabel.frame.size.height;
    
    self.titleEdgeInsets = (UIEdgeInsets){
        .top    =   (tit_H / 2 + Spacing / 2),
        .left   = - (img_W / 2),
        .bottom = - (tit_H / 2 + Spacing / 2),
        .right  =   (img_W / 2),
    };
    
    self.imageEdgeInsets = (UIEdgeInsets){
        .top    = - (img_H / 2 + Spacing / 2),
        .left   =   (tit_W / 2),
        .bottom =   (img_H / 2 + Spacing / 2),
        .right  = - (tit_W / 2),
    };
}
- (void)setIconInBottomWithSpacing:(CGFloat)Spacing
{
    CGFloat img_W = self.imageView.frame.size.width;
    CGFloat img_H = self.imageView.frame.size.height;
    CGFloat tit_W = self.titleLabel.frame.size.width;
    CGFloat tit_H = self.titleLabel.frame.size.height;
    
    self.titleEdgeInsets = (UIEdgeInsets){
        .top    = - (tit_H / 2 + Spacing / 2),
        .left   = - (img_W / 2),
        .bottom =   (tit_H / 2 + Spacing / 2),
        .right  =   (img_W / 2),
    };
    
    self.imageEdgeInsets = (UIEdgeInsets){
        .top    =   (img_H / 2 + Spacing / 2),
        .left   =   (tit_W / 2),
        .bottom = - (img_H / 2 + Spacing / 2),
        .right  = - (tit_W / 2),
    };
}


+(CGFloat )getButtonWidth:(UIButton *)btn{
    
    NSString *content = btn.titleLabel.text;
    UIFont *font = btn.titleLabel.font;
    CGSize size = CGSizeMake(MAXFLOAT, 30.0f);
    CGSize buttonSize = [content boundingRectWithSize:size
                                              options:NSStringDrawingTruncatesLastVisibleLine  | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                           attributes:@{ NSFontAttributeName:font}
                                              context:nil].size;
    
    

                         
    return buttonSize.width;
                         
}

// 改变UIButton的文本的 两种以上颜色及字体

+ (void)changeTextBtn:(UIButton *)myBtn
          stringArray:(NSArray *)strArray
           colorArray:(NSArray *)colorArray
            fontArray:(NSArray *)fontArray {
    
    NSMutableAttributedString *mutAttStr = [[NSMutableAttributedString alloc] initWithString:myBtn.titleLabel.text];
    
    NSString* _str = nil;
    UIFont*  _font = nil;
    NSRange _range = NSMakeRange(0, 0);
    
    for (int i=0; i<strArray.count; i++) {
        //NSLog(@"---> strArray.count = %ld",strArray.count);
        _str = strArray[i];
        NSUInteger location = [[mutAttStr string] rangeOfString:_str].location;
        NSUInteger length   = [[mutAttStr string] rangeOfString:_str].length;
        _range = NSMakeRange(location, length);
        // 改变颜色
        if (colorArray.count >= (i+1)) {
            [mutAttStr addAttribute:NSForegroundColorAttributeName value:colorArray[i] range:_range];
        }
        // 改变字体大小
        if (fontArray.count >= (i+1)) {
            _font = fontArray[i];
            [mutAttStr addAttribute:NSFontAttributeName value:_font range:_range];
        }
    }
    
    [myBtn setAttributedTitle:mutAttStr forState:UIControlStateNormal];
}

@end
