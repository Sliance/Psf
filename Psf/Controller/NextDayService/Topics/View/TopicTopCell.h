//
//  TopicTopCell.h
//  Psf
//
//  Created by zhangshu on 2018/12/24.
//  Copyright © 2018 zhangshu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StairCategoryListRes.h"

NS_ASSUME_NONNULL_BEGIN

@interface TopicTopCell : UICollectionViewCell
@property(nonatomic,strong)UIView*bgView;
@property(nonatomic,strong)UIImageView*headImage;
@property(nonatomic,strong)UILabel*nameLabel;
@property(nonatomic,strong)UILabel*priceLabel;
@property(nonatomic,strong)UIButton*goBtn;
@property(nonatomic,strong)StairCategoryListRes *model;

@end

NS_ASSUME_NONNULL_END
