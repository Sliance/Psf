//
//  ChoosePayTypeView.h
//  Psf
//
//  Created by 燕来秋mac9 on 2018/9/5.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "BaseView.h"

@interface ChoosePayTypeView : BaseView
@property(nonatomic,strong)UIView *yinView;
@property(nonatomic,strong)UIView *bgview;
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UILabel *linelabel;
@property(nonatomic,strong)UIButton *closeBtn;
@property(nonatomic,strong)UIButton *sureBtn;
@property(nonatomic,strong)UIImageView *wechartimage;
@property(nonatomic,strong)UIImageView *alipayimage;
@property(nonatomic,strong)UILabel *weixinLabel;
@property(nonatomic,strong)UILabel *alipayLabel;
@property(nonatomic,strong)UIButton *tmpBtn;
@property(nonatomic,strong)UIButton *wxBtn;
@property(nonatomic,strong)UIButton *alipayBtn;
@property(nonatomic,copy)void (^sureBlock)(NSString*);
@property(nonatomic,copy)void (^closeBlock)(void);
@end
