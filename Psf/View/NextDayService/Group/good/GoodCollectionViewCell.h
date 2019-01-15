//
//  GoodCollectionViewCell.h
//  Psf
//
//  Created by 燕来秋mac9 on 2018/6/29.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZSConfig.h"
#import "GoodDetailRes.h"
#import "CartProductModel.h"
#import "CircleListRes.h"

@interface GoodCollectionViewCell : UICollectionViewCell
///图片
@property(nonatomic,strong)UIImageView *headImage;
///物品名
@property(nonatomic,strong)UILabel *nameLabel;
@property(nonatomic,strong)UILabel *priceLabel;
@property(nonatomic,strong)GoodDetailRes *model;
@property(nonatomic,strong)CartProductModel *carmodel;
@property(nonatomic,strong)CircleListRes *recipeModel;

@property(nonatomic,assign)NSInteger width;

@end
