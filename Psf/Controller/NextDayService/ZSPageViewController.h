//
//  ZSPageViewController.h
//  Psf
//
//  Created by 燕来秋mac9 on 2018/6/26.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "BaseViewController.h"
#import "ZJScrollPageViewDelegate.h"
#import "StairCategoryRes.h"

@interface ZSPageViewController : BaseViewController

@property(nonatomic,assign)NSInteger selectedIndex;
@property(nonatomic,strong)StairCategoryRes*model;

@end
