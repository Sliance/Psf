//
//  RefundViewController.h
//  Psf
//
//  Created by 燕来秋mac9 on 2018/7/4.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "BaseViewController.h"
#import "CartProductModel.h"

@interface RefundViewController : BaseViewController
@property(nonatomic,strong)CartProductModel *carmodel;
@property(nonatomic,assign)NSInteger type;

@end
