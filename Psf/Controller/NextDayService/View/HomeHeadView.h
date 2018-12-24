//
//  HomeHeadView.h
//  Psf
//
//  Created by zhangshu on 2018/12/20.
//  Copyright © 2018 zhangshu. All rights reserved.
//

#import "BaseView.h"
#import "ZSCycleScrollView.h"
#import "SubjectCategoryModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HomeHeadView : BaseView<ZSCycleScrollViewDelegate>
@property(nonatomic,strong)ZSCycleScrollView *cycleScroll;
@property(nonatomic,strong)UIImageView *headimage;
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UILabel *detailLabel;
@property(nonatomic,strong) SubjectCategoryModel *model;
@property(nonatomic,copy) void (^selected)(NSInteger);
@property(nonatomic,copy) void (^imageBlock)(NSInteger);
@end

NS_ASSUME_NONNULL_END
