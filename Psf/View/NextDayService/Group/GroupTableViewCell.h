//
//  GroupTableViewCell.h
//  Psf
//
//  Created by 燕来秋mac9 on 2018/7/2.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface GroupTableViewCell : BaseTableViewCell
@property(nonatomic,strong)UIImageView *headImage;
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UILabel *detailLabel;
@property(nonatomic,strong)UILabel *groupLabel;
@property(nonatomic,strong)UILabel *priceLabel;
@property(nonatomic,strong)UIButton *addBtn;
@property(nonatomic,copy)void(^pressAddBlock)(NSInteger);
@property(nonatomic,assign)NSInteger index;
@property(nonatomic,strong)UILabel *lineLabel;
@end
