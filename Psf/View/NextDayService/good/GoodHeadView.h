//
//  GoodHeadView.h
//  Psf
//
//  Created by 燕来秋mac9 on 2018/6/29.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "BaseView.h"
#import "GoodDetailRes.h"
#import "ZYProGressView.h"

@interface GoodHeadView : BaseView
///分享按钮
@property(nonatomic,strong)UIButton *shareBtn;
///物品名
@property(nonatomic,strong)UILabel *nameLabel;
///物品详情
@property(nonatomic,strong)UILabel *contentLabel;
///物品价格
@property(nonatomic,strong)UILabel *priceLabel;
///物品重量
@property(nonatomic,strong)UILabel *weightLabel;
///已售数量
@property(nonatomic,strong)UILabel *soldLabel;

@property(nonatomic,strong)GoodDetailRes *model;
///拼团、预售
@property(nonatomic,strong)UIView *groupView;
///
@property(nonatomic,strong)UILabel *groupLabel;
///剩余时间
@property(nonatomic,strong)UILabel *dateLabel;

@property(nonatomic,strong)UILabel *originLabel;
@property(nonatomic,strong)UILabel *lineLabel;
///已经多少人购买（预售）
@property(nonatomic,strong)UILabel *buyerLabel;

@property(nonatomic,strong)ZYProGressView *progress;
@property(nonatomic,strong)UILabel *limitLabel;
@property(nonatomic,strong)UILabel *limitTitleLabel;
@property(nonatomic,strong)UILabel *arriveLabel;
@property(nonatomic,strong)UILabel *arriveTitleLabel;
@property(nonatomic,strong)UILabel *remainLabel;
@property(nonatomic,strong)UILabel *remainTitleLabel;
@end
