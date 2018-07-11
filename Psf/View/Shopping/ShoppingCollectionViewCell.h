//
//  ShoppingCollectionViewCell.h
//  Psf
//
//  Created by 燕来秋mac9 on 2018/6/22.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZSConfig.h"
#import "CartProductModel.h"

typedef NS_ENUM(NSInteger, GOODSTYPE){
    TYPEVALID = 1,//有效
    TYPELOSE //失效
};
@interface ShoppingCollectionViewCell : UICollectionViewCell
@property(nonatomic,strong)UIButton *chooseBtn;
@property(nonatomic,strong)UIImageView *headImage;
@property(nonatomic,strong)UILabel *nameLabel;
@property(nonatomic,strong)UILabel *countLabel;
@property(nonatomic,strong)UILabel *weightLabel;
@property(nonatomic,strong)UILabel *priceLabel;
@property(nonatomic,strong)UIButton *addBtn;
@property(nonatomic,strong)UIButton *subBtn;
@property(nonatomic,strong)UITextField *countField;
@property(nonatomic,strong)UILabel *lineLabel;
@property(nonatomic,strong)UILabel *loseLabel;
@property(nonatomic,assign)GOODSTYPE goodtype;
@property(nonatomic,strong)CartProductModel *model;
@property(nonatomic,copy)void(^subBlock)(NSInteger);
@property(nonatomic,copy)void(^addBlock)(NSInteger);

@end
