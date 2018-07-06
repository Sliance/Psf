//
//  GoodCollectionViewCell.h
//  Psf
//
//  Created by 燕来秋mac9 on 2018/6/29.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZSConfig.h"

@interface GoodCollectionViewCell : UICollectionViewCell
///图片
@property(nonatomic,strong)UIImageView *headImage;
///物品名
@property(nonatomic,strong)UILabel *nameLabel;
@property(nonatomic,strong)UILabel *priceLabel;
@end
