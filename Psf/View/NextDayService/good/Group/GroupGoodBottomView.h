//
//  GroupGoodBottomView.h
//  Psf
//
//  Created by 燕来秋mac9 on 2018/7/16.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "BaseView.h"
#import "GoodDetailRes.h"

@interface GroupGoodBottomView : BaseView
@property(nonatomic,strong)UIButton *serviceBtn;
@property(nonatomic,strong)UIButton *shopBtn;
@property(nonatomic,strong)UIButton *addBtn;
@property(nonatomic,strong)UIView *singleView;
@property(nonatomic,strong)UIView *groupView;
@property(nonatomic,strong)UILabel *singlePrice;
@property(nonatomic,strong)UILabel *groupPrice;
@property(nonatomic,strong)UILabel *singleLabel;
@property(nonatomic,strong)UILabel *groupLabel;

@property(nonatomic,copy)void(^SingleBlock)();
@property(nonatomic,copy)void(^GroupBlock)();
@property(nonatomic,strong)GoodDetailRes *model;

@end
