//
//  FillOrderTypeView.h
//  Psf
//
//  Created by 燕来秋mac9 on 2018/6/29.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "BaseView.h"

@interface FillOrderTypeView : BaseView
@property(nonatomic,strong)UIButton *kanBtn;
@property(nonatomic,strong)UIButton *reBtn;
@property(nonatomic,strong)UILabel *kanLabel;
@property(nonatomic,strong)UILabel *reLabel;
@property(nonatomic,strong)UILabel *lineLabel;
@property(nonatomic,strong)UIButton *tmpBtn;
@property(nonatomic,copy)void(^chooseTypeBlock)(NSInteger);

@end
