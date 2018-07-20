//
//  ShopFootView.h
//  Psf
//
//  Created by 燕来秋mac9 on 2018/6/22.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "BaseView.h"
#import "ShoppingListRes.h"

@interface ShopFootView : BaseView
@property(nonatomic,strong)UIButton *chooseBtn;
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UIButton *submitBtn;
@property(nonatomic,strong)UILabel *priceLabel;
@property(nonatomic,strong)UILabel *lineLabel;
@property(nonatomic,strong)ShoppingListRes*model;
@property(nonatomic,copy)void (^AllBlock)(BOOL);
@end
