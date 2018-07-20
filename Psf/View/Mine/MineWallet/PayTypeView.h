//
//  PayTypeView.h
//  Psf
//
//  Created by 燕来秋mac9 on 2018/7/3.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "BaseView.h"

@interface PayTypeView : BaseView
@property(nonatomic,strong)UIButton *imageLabel;
@property(nonatomic,strong)UILabel *typeLabel;
@property(nonatomic,strong)UIButton *chooseBtn;
@property(nonatomic,copy)void(^chooseBlock)(NSInteger);
@end
