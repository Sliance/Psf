//
//  DetailRecipeProductCell.h
//  Psf
//
//  Created by zhangshu on 2019/1/15.
//  Copyright © 2019 zhangshu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CartProductModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface DetailRecipeProductCell : UICollectionViewCell
@property(nonatomic,strong)UIView *bgView;
@property(nonatomic,strong)UIImageView *headImage;
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UILabel *priceLabel;
@property(nonatomic,strong)UIButton *addBtn;
@property(nonatomic,strong)UILabel *notLabel;
@property(nonatomic,strong)CartProductModel*model;



@end

NS_ASSUME_NONNULL_END
