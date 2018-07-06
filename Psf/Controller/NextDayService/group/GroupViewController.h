//
//  GroupViewController.h
//  Psf
//
//  Created by 燕来秋mac9 on 2018/6/29.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "BaseViewController.h"
typedef NS_ENUM(NSInteger, GOODTYPE){
    GOODTYPECOMMON= 0 ,//普通
    GOODTYPEPRESELL ,//预售
    GOODTYPEGROUP , //团购
};
@interface GroupViewController : BaseViewController
@property(nonatomic,assign)GOODTYPE goodtype;
@end
