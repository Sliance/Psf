//
//  CardHeadView.h
//  Psf
//
//  Created by 燕来秋mac9 on 2018/9/20.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "BaseView.h"

@interface CardHeadView : BaseView
@property(nonatomic,strong)UIImageView*headImge;
@property(nonatomic,strong)UIImageView*vImage;
@property(nonatomic,strong)UIImageView*cardImage;

@property(nonatomic,strong)UILabel*titleLabel;
@property(nonatomic,strong)UILabel*nameLabel;
@property(nonatomic,strong)UILabel*cardLabel;
@property(nonatomic,strong)UILabel*detailLabel;
@property(nonatomic,strong)UIView*yinView;

@end
