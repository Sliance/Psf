//
//  GroupCollectionViewCell.h
//  Psf
//
//  Created by 燕来秋mac9 on 2018/7/3.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZSConfig.h"

@interface GroupCollectionViewCell : UICollectionViewCell
///图片
@property(nonatomic,strong)UIImageView *headImage;
///物品名
@property(nonatomic,strong)UILabel *nameLabel;
///物品详情
@property(nonatomic,strong)UILabel *contentLabel;
///物品价格
@property(nonatomic,strong)UILabel *priceLabel;
///
@property(nonatomic,strong)UILabel *weightLabel;
@property(nonatomic,strong)UILabel *lineLabel;

@end
