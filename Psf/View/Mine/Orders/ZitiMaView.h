//
//  ZitiMaView.h
//  Psf
//
//  Created by 燕来秋mac9 on 2018/8/20.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "BaseView.h"
#import "CreatQRCodeAndBarCodeFromLeon.h"
#import "OrderServiceApi.h"

@interface ZitiMaView : BaseView
@property(nonatomic,strong)UIView *yinView;
@property(nonatomic,strong)UIView *bgview;
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UILabel *linelabel;
@property(nonatomic,strong)UIButton *closeBtn;
@property(nonatomic,strong)UIImageView *codeimage;
///销售订单编号
@property(nonatomic,copy)NSString *saleOrderId;
@property(nonatomic,copy)void (^closeBlock)(void);
@end
