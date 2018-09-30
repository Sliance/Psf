//
//  OrderCollectionViewCell.h
//  Psf
//
//  Created by 燕来秋mac9 on 2018/6/27.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WaitPaymentCell.h"

@interface OrderCollectionViewCell : UICollectionViewCell
@property(nonatomic,strong)UIView *bgView;
@property(nonatomic,strong)UIImageView *headImage;
@property(nonatomic,strong)UIImageView *headImageTwo;
@property(nonatomic,strong)UIImageView *headImageThree;
@property(nonatomic,strong)UILabel *nameLabel;
///购买份数
@property(nonatomic,strong)UILabel *countLabel;
@property(nonatomic,strong)UILabel *weightLabel;

///订单编号
@property(nonatomic,strong)UILabel *orderNumLabel;
///删除、取消订单按钮
@property(nonatomic,strong)UIButton *cancleBtn;
///应付金额
@property(nonatomic,strong)UILabel *payableLabel;
///状态
@property(nonatomic,strong)UILabel *statusLabel;
@property(nonatomic,strong)UILabel *topline;
@property(nonatomic,strong)UILabel *bottomline;
///配送按钮
@property(nonatomic,strong)UIButton *sendBtn;
///付款按钮
@property(nonatomic,strong)UIButton *payBtn;
///订单状态
@property(nonatomic,assign)NSInteger ordertype;
@property(nonatomic,strong)CartProductModel *model;
//再次购买
@property(nonatomic,copy)void (^buyBlock)(CartProductModel*);
//付款
@property(nonatomic,copy)void (^payBlock)(CartProductModel*);
//退款
@property(nonatomic,copy)void (^refundBlock)(CartProductModel*);
///退款详情
@property(nonatomic,copy)void (^detailBlock)(CartProductModel*);



@end
