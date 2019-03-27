//
//  detailGoodsViewController.h
//  Psf
//
//  Created by 燕来秋mac9 on 2018/6/22.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "BaseViewController.h"

@interface detailGoodsViewController : BaseViewController

@property(nonatomic,assign)NSInteger productID;

@property(nonatomic,strong)NSString *navStr;
@property(nonatomic,copy)NSString* erpProductId;
@property(nonatomic,copy)NSString* productType;

@end
