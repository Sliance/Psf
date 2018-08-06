//
//  FillEvaluateHwadView.h
//  Psf
//
//  Created by 燕来秋mac9 on 2018/7/5.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "BaseView.h"
#import "RatingView.h"
#import "UIPlaceHolderTextView.h"
@interface FillEvaluateHwadView : BaseView<FloatRatingViewDelegate>
@property(nonatomic,strong)UIImageView *headImage;
@property(nonatomic,strong)UILabel *nameLabel;
@property(nonatomic,strong)UILabel *countLabel;
@property(nonatomic,strong)UILabel *weightLabel;

@property(nonatomic,strong)UILabel *pingLabel;
@property(nonatomic,strong)UILabel *gradeLabel;
@property(nonatomic,strong)RatingView *ratingView;
@property(nonatomic,strong)UILabel *lineLabel;
@property(nonatomic,strong)UIPlaceHolderTextView *contentTXT;

@end
