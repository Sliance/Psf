//
//  CircleListCell.h
//  Ypc
//
//  Created by zhangshu on 2019/1/8.
//  Copyright © 2019 zhangshu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CircleListRes.h"

NS_ASSUME_NONNULL_BEGIN

@interface CircleListCell : UICollectionViewCell

@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UIImageView *headImage;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UIImageView *memberImage;
@property (nonatomic, strong)CircleListRes*model;

@property (nonatomic, copy)void (^heightBlock)(CGFloat);

+(CGFloat)getHeight:(CircleListRes*)model;

@end

NS_ASSUME_NONNULL_END
