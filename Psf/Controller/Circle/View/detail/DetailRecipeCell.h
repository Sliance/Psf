//
//  DetailRecipeCell.h
//  Psf
//
//  Created by zhangshu on 2019/1/15.
//  Copyright © 2019 zhangshu. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "EpicureProductModel.h"
#import "CartProductModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface DetailRecipeCell : BaseTableViewCell
<UICollectionViewDelegate, UICollectionViewDataSource>
@property(nonatomic,strong)UILabel *titleLabel;
@property (nonatomic, strong)UICollectionView *collectionView;
@property(nonatomic,copy)void(^selectedCollect)(CartProductModel*);
@property(nonatomic,strong)EpicureProductModel*model;
@property(nonatomic,strong)NSMutableArray *dataArr;
@end

NS_ASSUME_NONNULL_END
