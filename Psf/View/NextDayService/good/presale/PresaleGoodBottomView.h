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

@property(nonatomic,copy)void(^pressAddBlock)();
@end
