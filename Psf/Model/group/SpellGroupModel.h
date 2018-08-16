//
//  SpellGroupModel.h
//  Psf
//
//  Created by 燕来秋mac9 on 2018/8/3.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SpellGroupModel : NSObject
///团购活动过期时间
@property(nonatomic,copy)NSString* grouponActivityExpireTime;
///团购活动编号
@property(nonatomic,copy)NSString* grouponActivityId;
///团购活动会员计数
@property(nonatomic,assign)NSInteger grouponActivityMemberCount;
///团购活动会员限制
@property(nonatomic,assign)NSInteger grouponActivityMemberLimit;
@property(nonatomic,strong)NSArray *grouponActivityMemberList;
///团购活动价格
@property(nonatomic,copy)NSString* grouponActivityPrice;
///团购活动状态
@property(nonatomic,copy)NSString* grouponActivityStatus;
///团购活动生效时间
@property(nonatomic,copy)NSString* grouponActivityValidTime;
///团购编号
@property(nonatomic,copy)NSString* grouponId;


///会员头像路径
@property(nonatomic,copy)NSString* memberAvatarPath;
///会员编号
@property(nonatomic,copy)NSString* memberId;
///会员昵称
@property(nonatomic,copy)NSString* memberNickName;
@property(nonatomic,assign)NSInteger saleOrderId;
///商品编号
@property(nonatomic,copy)NSString* productId;
///商品规格编号
@property(nonatomic,copy)NSString* productSkuId;
@property(nonatomic,copy)NSString* productImagePath;
@property(nonatomic,copy)NSString* productName;
@property(nonatomic,copy)NSString* productPrice;
@property(nonatomic,copy)NSString* productStock;
@property(nonatomic,copy)NSString* productTitle;
@property(nonatomic,copy)NSString* productUnit;





@end
