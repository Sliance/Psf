//
//  DetailRecipeHeadView.h
//  Psf
//
//  Created by zhangshu on 2019/1/15.
//  Copyright © 2019 zhangshu. All rights reserved.
//

#import "BaseView.h"
#import "DetailRecipeRes.h"

NS_ASSUME_NONNULL_BEGIN

@interface DetailRecipeHeadView : BaseView
@property(nonatomic,strong)UIImageView *headImage;
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)DetailRecipeRes *model;
@property(nonatomic,copy)void(^heighrBlock)(CGFloat);

@end

NS_ASSUME_NONNULL_END
