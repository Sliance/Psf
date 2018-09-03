//
//  HomeTableViewCell.h
//  Psf
//
//  Created by 燕来秋mac9 on 2018/8/27.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "GroupBannerModel.h"

@interface HomeTableViewCell : BaseTableViewCell

@property(nonatomic,strong)UIImageView *headimage;
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UILabel *leftlLabel;
@property(nonatomic,strong)UILabel *rightLabel;

@property(nonatomic,strong)GroupBannerModel *model;
@property(nonatomic,strong)UILabel *lineLabel;

@end
