//
//  PresaleGoodBottomView.h
//  Psf
//
//  Created by 燕来秋mac9 on 2018/7/16.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "BaseView.h"

@interface PresaleGoodBottomView : BaseView
@property(nonatomic,strong)UIButton *serviceBtn;

@property(nonatomic,strong)UIButton *addBtn;
@property(nonatomic,strong)UIButton *shopBtn;
@property(nonatomic,strong)UIButton *addShopBtn;
@property(nonatomic,strong)UILabel *countLabel;
@property(nonatomic,copy)void(^pressAddBlock)(void);
@property(nonatomic,copy)void(^pressshopBlock)(void);
@property(nonatomic,copy)void(^serviceBlock)(void);
@property(nonatomic,copy)void(^goShopeBlock)(void);
@property(nonatomic,assign)BOOL preSaleIsComplete;

@end
