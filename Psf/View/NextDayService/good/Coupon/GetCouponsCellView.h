//
//  GetCouponsCellView.h
//  Psf
//
//  Created by 燕来秋mac9 on 2018/6/29.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "BaseView.h"

@interface GetCouponsCellView : BaseView
@property(nonatomic,strong)UILabel *topLine;
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UILabel *detailLabel;
@property(nonatomic,strong)UIImageView *rightImage;
@property(nonatomic,strong)UIButton *topBtn;
@property(nonatomic,strong)UILabel *lineLabel;
@property (nonatomic, copy) void(^pressCoupBlock)(NSInteger);
@end
