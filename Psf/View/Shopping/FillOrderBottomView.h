//
//  FillOrderBottomView.h
//  Psf
//
//  Created by 燕来秋mac9 on 2018/6/29.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "BaseView.h"

@interface FillOrderBottomView : BaseView
@property(nonatomic,strong)UILabel *lineLabel;
@property(nonatomic,strong)UIButton *remindBtn;

///应付金额
@property(nonatomic,strong)UILabel *payableLabel;
@end
