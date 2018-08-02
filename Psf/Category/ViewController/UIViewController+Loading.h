//
//  UIViewController+Loading.h
//  AnjukeBroker_New
//
//  Created by Wu sicong on 13-11-8.
//  Copyright (c) 2013年 Wu sicong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface UIViewController (Loading)

- (void)hideLoadWithAnimated:(BOOL)animated;
- (void)showLoadingActivity:(BOOL)activity;
-(void)showLoadingWithInfo:(NSString *)info andAnimated:(BOOL)animated;
- (void)showInfo:(NSString *)info;
/**
 显示小字体提示
 */
- (void)showInfoDetail:(NSString *)info;
/**
 显示的LOading 动画
 
 @param title 显示的文字
 @param activity 是否有动画
 */
- (void)showLoadingwithtitle:(NSString *)title andActivity:(BOOL)activity;
@end
