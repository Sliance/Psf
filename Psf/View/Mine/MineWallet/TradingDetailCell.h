//
//  TradingDetailCell.h
//  Psf
//
//  Created by 燕来秋mac9 on 2018/7/2.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "IntegralRecord.h"

@interface TradingDetailCell : BaseTableViewCell
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UILabel *contentLabel;
@property(nonatomic,strong)UILabel *priceLabel;

@property(nonatomic,strong)IntegralRecord *model;
@property(nonatomic,assign)NSInteger type;

@end
