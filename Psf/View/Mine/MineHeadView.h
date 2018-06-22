//
//  MineHeadView.h
//  Psf
//
//  Created by 燕来秋mac9 on 2018/6/20.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "BaseView.h"

@interface MineHeadView : BaseView
@property(nonatomic,strong)UIButton *headbtn;
@property(nonatomic,strong)UILabel *nameLabel;
@property(nonatomic,strong)UILabel *lineLabel;
@property (nonatomic, copy) void(^skipBlock)(NSInteger);
@end
