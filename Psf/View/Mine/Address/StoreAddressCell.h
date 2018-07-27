//
//  StoreAddressCell.h
//  Psf
//
//  Created by 燕来秋mac9 on 2018/7/23.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "StoreRes.h"

@interface StoreAddressCell : BaseTableViewCell
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UILabel *detailLabel;
@property(nonatomic,strong)UILabel *phoneLabel;
@property(nonatomic,strong)UILabel *morenLabel;
@property(nonatomic,strong)UIImageView *lineImage;
@property(nonatomic,strong)UIButton *editBtn;
@property(nonatomic,strong)UILabel *distanceLabel;

@property(nonatomic,assign)NSInteger index;
@property(nonatomic,copy)void (^selectedBlock)(StoreRes*);
@property(nonatomic,strong)StoreRes *model;

@end
