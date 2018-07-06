//
//  DetailMessageCell.h
//  Psf
//
//  Created by 燕来秋mac9 on 2018/7/4.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface DetailMessageCell : BaseTableViewCell
@property(nonatomic,strong)UIView *bgview;
@property(nonatomic,strong)UILabel *topLabel;
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UILabel *contentLabel;
@property(nonatomic,strong)UIImageView *rightImage;
@end
