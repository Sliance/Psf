//
//  SortCollectionViewCell.h
//  Psf
//
//  Created by 燕来秋mac9 on 2018/6/20.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StairCategoryRes.h"
#import "ZSConfig.h"
#import "SubjectModel.h"
@interface SortCollectionViewCell : UICollectionViewCell
///图片
@property(nonatomic,strong)UIImageView *headImage;
///物品名
@property(nonatomic,strong)UILabel *nameLabel;
@property(nonatomic,assign)NSInteger imageHeight;
@property(nonatomic,strong)StairCategoryRes *model;
///首页banner
@property(nonatomic,strong)SubjectModel* homeBannermodel;
@end
