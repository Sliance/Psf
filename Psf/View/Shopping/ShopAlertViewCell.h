//
//  ShopAlertViewCell.h
//  Psf
//
//  Created by 燕来秋mac9 on 2018/9/14.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "CartProductModel.h"

@interface ShopAlertViewCell : BaseTableViewCell<UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic,strong)UILabel *dateLabel;
@property(nonatomic,strong)UILabel *totalLabel;
@property(nonatomic,strong)UILabel *priceLabel;
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UILabel *weightLabel;

@property(nonatomic,strong)UIButton *submitBtn;
@property(nonatomic,strong)UIImageView *headImage;
@property(nonatomic,strong)UICollectionView *collectionView;

@property(nonatomic,assign)NSInteger  productType;

@property(nonatomic,strong)CartProductModel *model;
@property(nonatomic,strong)NSArray *dataArr;

@end
