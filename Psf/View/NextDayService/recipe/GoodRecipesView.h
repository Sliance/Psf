//
//  GoodRecipesView.h
//  Psf
//
//  Created by zhangshu on 2019/1/15.
//  Copyright © 2019 zhangshu. All rights reserved.
//

#import "BaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface GoodRecipesView : BaseView<UICollectionViewDelegate, UICollectionViewDataSource>
@property(nonatomic,strong)UILabel *titleLabel;
@property (nonatomic, strong)UICollectionView *collectionView;
@property(nonatomic,strong)NSMutableArray *dataArr;
@property(nonatomic,copy)void(^selectedCollect)(NSString*);
@end

NS_ASSUME_NONNULL_END
