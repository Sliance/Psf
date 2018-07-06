//
//  EvaluateTableViewCell.h
//  Psf
//
//  Created by 燕来秋mac9 on 2018/6/26.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "RatingView.h"
@interface EvaluateTableViewCell : BaseTableViewCell<FloatRatingViewDelegate>
///图片
@property(nonatomic,strong)UIImageView *headImage;
///名
@property(nonatomic,strong)UILabel *nameLabel;
@property(nonatomic,strong)UILabel *dateLabel;
///详情
@property(nonatomic,strong)UILabel *contentsLabel;
@property(nonatomic,strong)RatingView *ratingView;
@end
