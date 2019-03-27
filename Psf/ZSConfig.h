//
//  ZSConfig.h
//  Psf
//
//  Created by 燕来秋mac9 on 2018/6/21.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#ifndef ZSConfig_h
#define ZSConfig_h
#define DPSIGNATURE @"RNKCoeffPosGEwv7FpLsWokxTozPt9ki"//加密key
//#define DPHOST @"http://192.168.1.51:8088" // 开发环境-鹏飞
#define DPHOST @"http://192.168.1.156:8088" // 测试环境-梅芳
//#define DPHOST @"http://47.98.233.125:8088" // 测试环境
//#define DPHOST @"https://xcx.lxnong.com"// 生产环境
#define IMAGEHOST  @"https://xcxmmeida.lxnong.com/"//图片地址
#define APPNAME @"Psf"
#define SUPPLIERAPIKEY @"PsfAppApiKey"
/**屏幕尺寸*/
#define SCREENWIDTH [[UIScreen mainScreen] bounds].size.width
#define SCREENHEIGHT [[UIScreen mainScreen] bounds].size.height
/**封装颜色*/
#define DSColorMake(r, g, b)            [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]
#define DSColorAlphaMake(r, g, b, a)    [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define DSColorFromHex(rgb)     [UIColor colorWithRed:((float)((rgb & 0xFF0000) >> 16))/255.0 green:((float)((rgb & 0xFF00) >> 8))/255.0 blue:((float)(rgb & 0xFF))/255.0 alpha:1.0]
#define DSColorAlphaFromHex(rgb,a)     [UIColor colorWithRed:((float)((rgb & 0xFF0000) >> 16))/255.0 green:((float)((rgb & 0xFF00) >> 8))/255.0 blue:((float)(rgb & 0xFF))/255.0 alpha:a]
#define DSNavi  [UIColor whiteColor] //navigation的颜色
/**
 *  自适应大小
 */
#define AUTOLAYOUTSIZE(size) (SCREENWIDTH / 375.0 * size)
/**
 *  弱引用
 */

#define WEAKSELF typeof(self) __weak weakSelf = self;
#define STRONGSELF typeof(self) __strong strongSelf = self;

#define TopStatuHeight       [[UIApplication sharedApplication] statusBarFrame].size.height
// 适配iPhone x 底栏高度
#define TabbarHeight    ([[UIApplication sharedApplication] statusBarFrame].size.height>20?83:49)
// 适配iPhone x 导航高度
#define NavitionbarHeight   ([[UIApplication sharedApplication] statusBarFrame].size.height>20?88:64)
// 适配iPhone x 导航高度
#define BottomSafebarHeight    ([[UIApplication sharedApplication] statusBarFrame].size.height>20?34:0)

#import "UIView+CTExtensions.h"
#import <UIImageView+WebCache.h>
#import "NSDate+Add.h"
#import "MBProgressHUD.h"

#import <SDImageCache.h>
#import "UserCacheBean.h"
#import <Masonry.h>
#import <YYKit.h>
#import <MJExtension.h>
#import <MBProgressHUD.h>
#import "ZSNotification.h"
#import <MJRefresh.h>
#import "DPTextViewVerify.h"
#import "UILabel+String.h"
#import "UIButton+DNUtility.h"
#import "UIImage+Resize.h"
#import "CHGAdapter.h"
#import "UILabel+String.h"
#import "UIButton+DNUtility.h"

#endif /* ZSConfig_h */
