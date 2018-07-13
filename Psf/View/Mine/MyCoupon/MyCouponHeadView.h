//
//  MyCouponHeadView.h
//  Psf
//
//  Created by 燕来秋mac9 on 2018/6/28.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "BaseView.h"

@interface MyCouponHeadView : BaseView
@property(nonatomic,strong)UIView *bgView;
///全场
@property(nonatomic,strong)UILabel *allTitle;
@property(nonatomic,strong)UILabel *allType;
@property(nonatomic,strong)UILabel *allLine;
///分类
@property(nonatomic,strong)UILabel *sortTitle;
@property(nonatomic,strong)UILabel *sortType;
@property(nonatomic,strong)UILabel *sortLine;
///单品
@property(nonatomic,strong)UILabel *singleTitle;
@property(nonatomic,strong)UILabel *singleType;
@property(nonatomic,strong)UILabel *singleLine;
///
@property(nonatomic,strong)UIButton *allBtn;
@property(nonatomic,strong)UIButton *sortBtn;
@property(nonatomic,strong)UIButton *singleBtn;
@property(nonatomic,strong)UIButton *tmpBtn;
@property(nonatomic,copy)void (^typeBlock)(NSInteger);

@end
