//
//  StoreGoodsBuyView.h
//  Psf
//
//  Created by 燕来秋mac9 on 2018/9/27.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "BaseView.h"
#import "GoodDetailRes.h"
#import "StairCategoryListRes.h"

@interface StoreGoodsBuyView : BaseView
@property(nonatomic,strong)UIView *yinBGview;
@property(nonatomic,strong)UIView * BGview;
@property(nonatomic,strong)UILabel *buyLabel;
@property(nonatomic,strong)UITextField *countField;
///图片
@property(nonatomic,strong)UIImageView *headImage;
///物品名
@property(nonatomic,strong)UILabel *nameLabel;
///物品详情
@property(nonatomic,strong)UILabel *contentLabel;
///物品价格
@property(nonatomic,strong)UILabel *priceLabel;
@property(nonatomic,strong)UIButton *submitBtn;

@property(nonatomic,copy)void(^submitBlock)(NSString*,GoodDetailRes *,StairCategoryListRes *);
@property(nonatomic,copy)void(^tapBlock)(void);


@property(nonatomic,strong)GoodDetailRes *model;
@property(nonatomic,strong)StairCategoryListRes *catemodel;
@property(nonatomic,assign)NSInteger height;
@end
