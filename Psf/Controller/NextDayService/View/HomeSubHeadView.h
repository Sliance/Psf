//
//  HomeSubHeadView.h
//  Psf
//
//  Created by zhangshu on 2018/12/20.
//  Copyright © 2018 zhangshu. All rights reserved.
//

#import "BaseView.h"
#import "SubjectCategoryModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface HomeSubHeadView : BaseView
@property(nonatomic,strong)UIImageView *headimage;
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UILabel *detailLabel;
@property(nonatomic,strong) SubjectCategoryModel *model;
@property(nonatomic,strong) NSString *title;

@end

NS_ASSUME_NONNULL_END
