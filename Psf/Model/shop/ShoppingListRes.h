//
//  ShoppingListRes.h
//  Psf
//
//  Created by 燕来秋mac9 on 2018/7/10.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShoppingListRes : NSObject
///购物车编号
@property(nonatomic,copy)NSString *cartId;
///总金额
@property(nonatomic,copy)NSString *cartTotalAmount;
///满减金额
@property(nonatomic,copy)NSString *cartRewardAmount;
///实付金额
@property(nonatomic,copy)NSString *cartPayAmount;
///购物车是否全选
@property(nonatomic,assign)NSInteger cartIsActive;
///购物车商品列表
@property(nonatomic,strong)NSArray *cartProductList;
///商品总数量
@property(nonatomic,assign)NSInteger productQuantity;
///商品选中数量
@property(nonatomic,assign)NSInteger productActiveQuantity;


@end
