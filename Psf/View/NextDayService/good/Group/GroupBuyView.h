//
//  GroupBuyView.h
//  Psf
//
//  Created by 燕来秋mac9 on 2018/7/16.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "BaseView.h"

@interface GroupBuyView : BaseView

@property(nonatomic,strong)UIView *yinBGview;
@property(nonatomic,strong)UIView * BGview;
@property(nonatomic,strong)UIButton *addBtn;
@property(nonatomic,strong)UIButton *subBtn;
@property(nonatomic,strong)UITextField *countField;
@property(nonatomic,strong)UILabel *buyLabel;
@property(nonatomic,strong)UIButton *submitBtn;

@property(nonatomic,copy)void(^submitBlock)(NSInteger);
@property(nonatomic,copy)void(^tapBlock)();
@property(nonatomic,assign)NSInteger height;
@property(nonatomic,assign)NSInteger count;


@end
