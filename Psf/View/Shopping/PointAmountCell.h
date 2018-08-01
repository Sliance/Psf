//
//  PointAmountCell.h
//  Psf
//
//  Created by 燕来秋mac9 on 2018/7/20.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface PointAmountCell : BaseTableViewCell
@property(nonatomic,strong)UILabel *nameLabel;
@property(nonatomic,strong)UIButton *yuEswitch;
@property(nonatomic,copy)void(^yuEBlock)(NSInteger);
@property(nonatomic,assign)NSInteger index;
@end
