//
//  MineFootView.h
//  Psf
//
//  Created by 燕来秋mac9 on 2018/6/20.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "BaseView.h"


@interface MineFootView : BaseView
@property(nonatomic,strong)UIImageView *headImage;
@property(nonatomic,strong)UILabel *lineLabel;


@property (nonatomic, copy) void(^skipMineBlock)(NSInteger);

@end
