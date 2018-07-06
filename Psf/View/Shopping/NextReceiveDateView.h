//
//  NextReceiveDateView.h
//  Psf
//
//  Created by 燕来秋mac9 on 2018/7/6.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "BaseView.h"

@interface NextReceiveDateView : BaseView
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UILabel *lineLabel;
@property(nonatomic,strong)UIButton *nowBtn;
@property(nonatomic,strong)UIButton *nextBtn;
@property(nonatomic,strong)UIView *bgview;
@property(nonatomic,strong)UIView *leftview;
@property(nonatomic,strong)UIView *yinview;
@property(nonatomic,strong)UIButton *oneBtn;
@property(nonatomic,strong)UIButton *twoBtn;
@property(nonatomic,strong)UIButton *threeBtn;
@property(nonatomic,strong)UIButton *fourBtn;
@property(nonatomic,strong)UIButton *tmpBtn;
@property(nonatomic,strong)UIButton *leftBtn;
@property(nonatomic,strong)UIButton *cancleBtn;
@property(nonatomic,copy)void(^cancleBlock)(NSInteger);

@end
