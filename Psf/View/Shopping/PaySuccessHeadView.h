//
//  PaySuccessHeadView.h
//  Psf
//
//  Created by 燕来秋mac9 on 2018/8/15.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "BaseView.h"

@interface PaySuccessHeadView : BaseView
@property(nonatomic,strong)UIButton *successBtn;
@property(nonatomic,strong)UILabel *lineLabel;
@property(nonatomic,strong)UILabel *priceLabel;
@property(nonatomic,strong)UIButton *homeBtn;
@property(nonatomic,strong)UIButton *orderBtn;
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,copy)void (^homeBlock)();

@property(nonatomic,copy)void (^orderBlock)();
@end
