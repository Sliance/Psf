//
//  GoodBottomView.h
//  Psf
//
//  Created by 燕来秋mac9 on 2018/7/5.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "BaseView.h"

@interface GoodBottomView : BaseView
@property(nonatomic,strong)UIButton *serviceBtn;
@property(nonatomic,strong)UIButton *shopBtn;
@property(nonatomic,strong)UIButton *addBtn;
@property(nonatomic,strong)UILabel *countLabel;
@property(nonatomic,copy)void(^pressAddBlock)();
@property(nonatomic,copy)void(^shopBlock)();
@end
