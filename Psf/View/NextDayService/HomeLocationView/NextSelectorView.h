//
//  NextSelectorView.h
//  Psf
//
//  Created by 燕来秋mac9 on 2018/7/2.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "BaseView.h"
#import "StairCategoryRes.h"
@interface NextSelectorView : BaseView
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UIButton *rightButton;
@property(nonatomic,strong)NSMutableArray *dataArr;
@property(nonatomic,copy)void(^pressUpBlock)(NSInteger);
@property(nonatomic,copy)void(^chooseBlock)(NSInteger);
@property(nonatomic,strong)UIButton *tmpBtn;
@end
