//
//  PreSaleListCell.h
//  Psf
//
//  Created by 燕来秋mac9 on 2018/7/31.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "GroupListRes.h"
#import "ZYProGressView.h"

@interface PreSaleListCell : BaseTableViewCell
@property(nonatomic,strong)UIImageView *headImage;
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UILabel *detailLabel;
@property(nonatomic,strong)UILabel *groupLabel;
@property(nonatomic,strong)UILabel *priceLabel;
@property(nonatomic,strong)UILabel *weightLabel;
@property(nonatomic,strong)UIButton *addBtn;
@property(nonatomic,copy)void(^pressAddBlock)(NSInteger);
@property(nonatomic,assign)NSInteger index;
@property(nonatomic,strong)UILabel *lineLabel;
@property(nonatomic,strong)ZYProGressView *progress;
@property(nonatomic,strong)UILabel *progressLabel;

@property(nonatomic,strong)GroupListRes *model;

@end
