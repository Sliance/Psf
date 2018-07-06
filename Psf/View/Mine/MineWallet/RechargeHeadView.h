//
//  RechargeHeadView.h
//  Psf
//
//  Created by 燕来秋mac9 on 2018/7/3.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "BaseView.h"
#import "RechargeBtn.h"
@interface RechargeHeadView : BaseView
@property(nonatomic,strong)NSMutableArray *dataArr;
@property(nonatomic,strong)RechargeBtn *tmpBtn;
@property(nonatomic,copy)void(^chooseBlock)(NSInteger);
@end
