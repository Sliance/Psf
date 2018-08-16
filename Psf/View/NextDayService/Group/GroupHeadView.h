//
//  GroupHeadView.h
//  Psf
//
//  Created by 燕来秋mac9 on 2018/7/3.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "BaseView.h"
#import "SpellGroupModel.h"

@interface GroupHeadView : BaseView<UIScrollViewDelegate>
///图片
@property(nonatomic,strong)UIImageView *headImage;
@property(nonatomic,strong)UIView *bgView;
@property(nonatomic,strong)UIView*headView;
@property(nonatomic,strong)UILabel  *nameLabel;
@property(nonatomic,strong)UILabel  *shortLabel;
@property(nonatomic,strong)UIImageView *goodImage;
@property(nonatomic,strong)UILabel  *goodLabel;
@property(nonatomic,strong)UILabel  *pinLabel;
@property(nonatomic,strong)UILabel  *danLabel;
@property(nonatomic,strong)UILabel  *priceLabel;
@property(nonatomic,strong)UILabel  *lineLabel;
@property(nonatomic,strong)UILabel  *dateLabel;

@property(nonatomic,strong)UIButton *submitBtn;
@property(nonatomic,strong)UILabel *nextLabel;
@property(nonatomic,strong)UILabel *tuanLabel;
@property(nonatomic,copy)void (^subnitBtn)(NSInteger);
@property(nonatomic,strong)SpellGroupModel *model;
@property(nonatomic,strong)UIScrollView *bgscrollow;
@end
