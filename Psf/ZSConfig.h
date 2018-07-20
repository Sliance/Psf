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
//#define DEBUG_DPHOST @"http://192.168.1.104:8088" // 开发环境
#define DPHOST @"http://192.168.1.104:8088" // 测试环境
//#define DPHOST @"http://47.96.229.213:8088"// 生产环境
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

#import <Masonry.h>
#import "UIView+CTExtensions.h"
#import <YYKit.h>
#import <MJExtension.h>
#import <UIImageView+WebCache.h>
#import "NSDate+Add.h"

#endif /* ZSConfig_h */
