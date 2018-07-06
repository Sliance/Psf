//
//  MyCouponCell.h
//  Psf
//
//  Created by 燕来秋mac9 on 2018/6/25.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZSConfig.h"

@interface MyCouponCell : UITableViewCell
///图片
@property(nonatomic,strong)UIImageView *headImage;
///名
@property(nonatomic,strong)UILabel *nameLabel;
///详情
@property(nonatomic,strong)UILabel *contentLabel;

@property(nonatomic,strong)UIView *bgView;
@property(nonatomic,strong)UIButton *getBtn;
@property(nonatomic,assign)NSInteger index;
@property(nonatomic,copy)void(^getBlock)(NSInteger);
@end
