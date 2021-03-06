//
//  PresaleBuyView.h
//  Psf
//
//  Created by 燕来秋mac9 on 2018/7/16.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "BaseView.h"
#import "GoodDetailRes.h"
#import "ProductSkuModel.h"

@interface PresaleBuyView : BaseView
@property(nonatomic,strong)UIView *yinBGview;
@property(nonatomic,strong)UIView * BGview;
@property(nonatomic,strong)UIButton *addBtn;
@property(nonatomic,strong)UIButton *subBtn;
@property(nonatomic,strong)UITextField *countField;
@property(nonatomic,strong)UILabel *buyLabel;
@property(nonatomic,strong)UIButton *submitBtn;

@property(nonatomic,copy)void(^submitBlock)(NSInteger,NSInteger,NSInteger);
@property(nonatomic,copy)void(^tapBlock)();
@property(nonatomic,assign)NSInteger height;
@property(nonatomic,assign)NSInteger count;
@property(nonatomic,strong)GoodDetailRes *model;

///图片
@property(nonatomic,strong)UIImageView *headImage;
///物品名
@property(nonatomic,strong)UILabel *nameLabel;
///物品详情
@property(nonatomic,strong)UILabel *contentLabel;
///物品价格
@property(nonatomic,strong)UILabel *priceLabel;
@property(nonatomic,strong)UIButton *tmpBtn;

@property(nonatomic,assign)NSInteger index;
//0预售，1正常多规格
@property(nonatomic,assign)NSInteger type;

@end
