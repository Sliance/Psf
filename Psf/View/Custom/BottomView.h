//
//  BottomView.h
//  Psf
//
//  Created by 燕来秋mac9 on 2018/6/25.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "BaseView.h"

@interface BottomView : BaseView
@property(nonatomic,strong)UIButton *bottomBtn;
@property(nonatomic,copy)void (^gotoBlock)();
@end
