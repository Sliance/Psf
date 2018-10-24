//
//  GoodEvaluateView.h
//  Psf
//
//  Created by 燕来秋mac9 on 2018/6/29.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "BaseView.h"
#import "EvaluateListRes.h"
#import "EvaluateListModel.h"
#import "RatingView.h"

@interface GoodEvaluateView : BaseView<FloatRatingViewDelegate>
@property(nonatomic,strong)UILabel *topLine;
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UILabel *detailLabel;
@property(nonatomic,strong)UIImageView *rightImage;
@property(nonatomic,strong)UIButton *topBtn;
@property(nonatomic,strong)UILabel *lineLabel;
///图片
@property(nonatomic,strong)UIImageView *headImage;
///名
@property(nonatomic,strong)UILabel *nameLabel;
@property(nonatomic,strong)UILabel *dateLabel;
///详情
@property(nonatomic,strong)UILabel *contentsLabel;
@property(nonatomic, strong)UIView *cardImgsView;
@property(nonatomic,strong)RatingView *ratingView;

@property (nonatomic, copy) void(^skipBlock)(NSInteger);

@property(nonatomic,strong)EvaluateListRes *models;

+(CGFloat)getCellHeightWithData:(EvaluateListRes *)models;

@end
