//
//  DetailSortHeadView.h
//  Psf
//
//  Created by 燕来秋mac9 on 2018/7/16.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "BaseView.h"

@interface DetailSortHeadView : BaseView
@property(nonatomic,strong)UIButton *searchBtn;
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,copy)void(^searchBlock)(void);
@end
