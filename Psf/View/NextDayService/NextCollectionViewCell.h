//
//  NextCollectionViewCell.h
//  Psf
//
//  Created by 燕来秋mac9 on 2018/6/19.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StairCategoryListRes.h"
#import "ZSConfig.h"
#import "GroupListRes.h"
#import "TimeBuyModel.h"
#import "GoodDetailRes.h"

@interface NextCollectionViewCell : UICollectionViewCell
///图片
@property(nonatomic,strong)UIImageView *headImage;
///物品名
@property(nonatomic,strong)UILabel *nameLabel;
///物品详情
@property(nonatomic,strong)UILabel *contentLabel;
///预售预定人数
@property(nonatomic,strong)UILabel *presaleLabel;
///物品价格
@property(nonatomic,strong)UILabel *priceLabel;
///物品重量
@property(nonatomic,strong)UILabel *weightLabel;
///加价购
@property(nonatomic,strong)UILabel *raiseLabel;
///爆款
@property(nonatomic,strong)UILabel *quickLabel;
///商品标签
@property(nonatomic,strong)UILabel *productLabel;

@property(nonatomic,strong)UILabel *oripriceLabel;
@property(nonatomic,strong)UILabel *lineLabel;
@property(nonatomic,strong)StairCategoryListRes *model;
@property(nonatomic,strong)GroupListRes *groupmodel;
@property(nonatomic,strong)TimeBuyModel *timeModel;
@property(nonatomic,strong)GoodDetailRes *detailmodel;
@property(nonatomic,assign)CGFloat imageWidth;
@property(nonatomic,strong)UIButton*addBtn;

@property(nonatomic,copy)void(^addBlock)(void);


@end
