//
//  OrderDetailHeadView.h
//  Psf
//
//  Created by 燕来秋mac9 on 2018/6/28.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "BaseView.h"
#import "ChangeAddressReq.h"

typedef NS_ENUM(NSInteger, CLAIMGOODSTYPE){
    CLAIMGOODSTYPECOMMON = 0,//其他
    CLAIMGOODSTYPEVISIT,//送货上门
    CLAIMGOODSTYPEONESELF,//门店自提
};

@interface OrderDetailHeadView : BaseView
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UILabel *detailLabel;
@property(nonatomic,strong)UILabel *phoneLabel;
@property(nonatomic,strong)UILabel *morenLabel;
@property(nonatomic,strong)UIImageView *lineImage;
@property(nonatomic,strong)UIButton *rightTBtn;
@property(nonatomic,strong)UIView *headView;
@property(nonatomic,strong)UIView *footView;
@property(nonatomic,strong)UILabel *lineLabel;
@property(nonatomic,strong)UILabel *typeLabel;
@property(nonatomic,strong)UILabel *dateLabel;
@property(nonatomic,strong)UIButton *rightBBtn;
@property(nonatomic,strong)UILabel *ciriLabel;

@property(nonatomic,assign)CLAIMGOODSTYPE goodtype;
@property(nonatomic,copy)void (^addressBlock)(NSInteger);
@property(nonatomic,copy)void (^dateBlock)(NSInteger);

@property(nonatomic,strong)UILabel *centerLabel;

@property(nonatomic,strong)ChangeAddressReq *model;

@end
