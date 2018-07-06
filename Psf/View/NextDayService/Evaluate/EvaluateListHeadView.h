//
//  EvaluateListHeadView.h
//  Psf
//
//  Created by 燕来秋mac9 on 2018/6/29.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "BaseView.h"
#import "RatingView.h"

@interface EvaluateListHeadView : BaseView<FloatRatingViewDelegate>
@property(nonatomic,strong)UIButton *allBtn;
@property(nonatomic,strong)UIButton *photoBtn;
@property(nonatomic,strong)UIButton *contentBtn;
@property(nonatomic,strong)UILabel *lineLabel;
@property(nonatomic,strong)RatingView *ratingView;
@property(nonatomic,strong)UILabel *titleLabel;
@end
