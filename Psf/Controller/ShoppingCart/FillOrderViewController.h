//
//  FillOrderViewController.h
//  Psf
//
//  Created by 燕来秋mac9 on 2018/6/29.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "BaseViewController.h"
#import "ShoppingListRes.h"
#import "GoodDetailRes.h"

typedef NS_ENUM(NSInteger, GOOGSTYPE){
    GOOGSTYPENormal= 0 ,//正常订单
    GOOGSTYPEGroup ,//团购购买
    GOOGSTYPESingle,//团购单独购买
    GOOGSTYPEPresale , //预售

};
@interface FillOrderViewController : BaseViewController
@property(nonatomic,strong)ShoppingListRes *result;//正常
@property(nonatomic,strong)GoodDetailRes *gooddetail;//团购

@property(nonatomic,assign)GOOGSTYPE goodstype;
@property(nonatomic,strong)ProductSkuModel *skumodel;
@property(nonatomic,strong)NSArray *productArr;
@property(nonatomic,strong)NSString *navStr;
@property(nonatomic,assign)NSInteger orderType;

@end
