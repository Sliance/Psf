//
//  DetailRecipeCell.h
//  Psf
//
//  Created by zhangshu on 2019/1/15.
//  Copyright © 2019 zhangshu. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "EpicureProductModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface DetailRecipeCell : BaseTableViewCell
<UICollectionViewDelegate, UICollectionViewDataSource>
@property(nonatomic,strong)UILabel *titleLabel;
@property (nonatomic, strong)UICollectionView *collectionView;
@property(nonatomic,strong)NSMutableArray *dataArr;
@property(nonatomic,copy)void(^selectedCollect)(NSInteger);
@property(nonatomic,strong)EpicureProductModel*model;

@end

NS_ASSUME_NONNULL_END
