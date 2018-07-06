//
//  OrderDetailBottomView.h
//  Psf
//
//  Created by 燕来秋mac9 on 2018/6/28.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "BaseView.h"

@interface OrderDetailBottomView : BaseView
@property(nonatomic,strong)UILabel *lineLabel;
@property(nonatomic,strong)UIButton *remindBtn;
///取消订单按钮
@property(nonatomic,strong)UIButton *sendBtn;
///应付金额
@property(nonatomic,strong)UILabel *payableLabel;
@end
