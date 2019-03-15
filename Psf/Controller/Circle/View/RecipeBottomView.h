//
//  RecipeBottomView.h
//  Psf
//
//  Created by zhangshu on 2019/1/21.
//  Copyright © 2019 zhangshu. All rights reserved.
//

#import "BaseView.h"
#import "RecipeCollectModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface RecipeBottomView : BaseView
@property(nonatomic,strong)UIButton *collectBtn;
@property(nonatomic,strong)UIButton *shareBtn;
@property(nonatomic,strong)UIButton *commentBtn;
@property(nonatomic,strong)UIButton *zanBtn;
@property(nonatomic,strong)RecipeCollectModel *model;
@property(nonatomic,copy)void (^selectedBlock)(NSInteger);

@end

NS_ASSUME_NONNULL_END
