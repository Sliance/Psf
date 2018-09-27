//
//  StoreGoodsCell.h
//  Psf
//
//  Created by 燕来秋mac9 on 2018/9/25.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "StairCategoryListRes.h"

@interface StoreGoodsCell : BaseTableViewCell
@property(nonatomic,strong)UIImageView *headImage;
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UILabel *detailLabel;
@property(nonatomic,strong)UILabel *priceLabel;
@property(nonatomic,strong)UILabel *weightLabel;

@property(nonatomic,strong)UIButton *addBtn;

@property(nonatomic,strong)StairCategoryListRes *model;
@property(nonatomic,copy)void (^addBlock)(StairCategoryListRes *);


@end
