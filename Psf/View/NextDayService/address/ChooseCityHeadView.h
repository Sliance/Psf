//
//  ChooseCityHeadView.h
//  Psf
//
//  Created by 燕来秋mac9 on 2018/6/25.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "BaseView.h"

@interface ChooseCityHeadView : BaseView<UITextFieldDelegate>
@property(nonatomic,strong)UIView *bgView;
@property(nonatomic,strong)UIButton *cityBtn;
@property(nonatomic,strong)UILabel *lineLabel;
@property(nonatomic,strong)UIImageView *searchImage;
@property(nonatomic,strong)UITextField *searchField;

@end
