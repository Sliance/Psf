//
//  ZSScrollButton.h
//  ZSSortSelectorView
//
//  Created by 燕来秋mac9 on 2018/6/15.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZSConfig.h"

@protocol ZSScrollButtonDelegate

@optional
- (void)selectedButton:(NSInteger)sender;

@end;
@interface ZSScrollButton : UIView
- (instancetype)initWithFrame:(CGRect)frame miantitle:(NSString *)title count:(NSString*)count;

- (void)changeStatus:(BOOL)sender;

@property (nonatomic , weak) id<ZSScrollButtonDelegate>delegate;
@end
