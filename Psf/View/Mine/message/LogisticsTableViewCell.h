//
//  LogisticsTableViewCell.h
//  Psf
//
//  Created by 燕来秋mac9 on 2018/7/4.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface LogisticsTableViewCell : BaseTableViewCell
@property(nonatomic,strong)UIView *bgView;
@property(nonatomic,strong)UIImageView *headImage;
@property(nonatomic,strong)UIImageView *headImageTwo;
@property(nonatomic,strong)UIImageView *headImageThree;
@property(nonatomic,strong)UILabel *nameLabel;
///购买份数
@property(nonatomic,strong)UILabel *countLabel;
@property(nonatomic,strong)UILabel *weightLabel;

///订单编号
@property(nonatomic,strong)UILabel *orderNumLabel;
///删除、取消订单按钮
@property(nonatomic,strong)UIButton *cancleBtn;

@property(nonatomic,strong)UILabel *topline;
@property(nonatomic,strong)UILabel *topLabel;

@end
