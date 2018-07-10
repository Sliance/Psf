//
//  EvaluateListModel.h
//  Psf
//
//  Created by 燕来秋mac9 on 2018/6/28.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ImageModel.h"

@interface EvaluateListModel : NSObject
///
@property(nonatomic,copy)NSString *memberAvatarPath;
///
@property(nonatomic,assign)NSInteger memberId;
///
@property(nonatomic,copy)NSString *memberNickName;
///
@property(nonatomic,assign)NSInteger productId;
///
@property(nonatomic,assign)NSInteger productSkuId;
///
@property(nonatomic,assign)NSInteger saleOrderId;
///
@property(nonatomic,copy)NSString *saleOrderProductCommentContent;
///
@property(nonatomic,assign)NSInteger saleOrderProductCommentId;
///
@property(nonatomic,strong)NSArray *saleOrderProductCommentImageList;
///
@property(nonatomic,assign)NSInteger saleOrderProductCommentSatisfaction;
///
@property(nonatomic,assign)NSInteger saleOrderProductId;
///
@property(nonatomic,assign)NSInteger systemCreateTime;
@end
