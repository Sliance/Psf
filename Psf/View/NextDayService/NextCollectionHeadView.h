//
//  NextCollectionHeadView.h
//  Psf
//
//  Created by 燕来秋mac9 on 2018/7/2.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "BaseView.h"
#import "SubjectCategoryModel.h"
#import "StairCategoryRes.h"

@interface NextCollectionHeadView : BaseView
@property(nonatomic,strong)UIView *bgView;
@property(nonatomic,strong)UIButton *typeBtn;
@property(nonatomic,strong)UILabel *detailLabel;
@property(nonatomic,copy)void(^pressTypeBlock)(NSInteger);
@property(nonatomic,strong)UIImageView *headImage;
@property(nonatomic,strong)SubjectCategoryModel *model;
@property(nonatomic,strong)StairCategoryRes *productmodel;
@end
