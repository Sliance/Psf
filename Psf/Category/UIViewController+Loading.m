//
//  UIViewController+Loading.m
//  AnjukeBroker_New
//
//  Created by Wu sicong on 13-11-8.
//  Copyright (c) 2013年 Wu sicong. All rights reserved.
//

#import "UIViewController+Loading.h"

@implementation UIViewController (Loading)

- (void)hideLoadWithAnimated:(BOOL)animated{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
}

-(void)showLoadingWithInfo:(NSString *)info andAnimated:(BOOL)animated{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.userInteractionEnabled = YES;
    hud.yOffset = -45;
    hud.label.text = info;
}

- (void)showLoadingwithtitle:(NSString *)title andActivity:(BOOL)activity{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.yOffset = -45;
    hud.labelText = title;
    
}

- (void)showLoadingActivity:(BOOL)activity{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.yOffset = -45;
    hud.label.text = @"加载中...";
}

/**
 显示提示
 */
- (void)showInfo:(NSString *)info{
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:window animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.userInteractionEnabled = NO;
    hud.label.text = info;
    hud.yOffset = -85;
    [hud hide:YES afterDelay:3];
}

/**
 显示小字体提示
 */
- (void)showInfoDetail:(NSString *)info{
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.userInteractionEnabled = NO;
    hud.detailsLabel.text = info;
    hud.yOffset = -85;
    [hud hide:YES afterDelay:3];
}
@end
