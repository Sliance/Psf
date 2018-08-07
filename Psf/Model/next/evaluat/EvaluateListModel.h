//
//  EvaluateListModel.h
//  Psf
//
//  Created by 燕来秋mac9 on 2018/6/28.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ImageModel.h"
#import <UIKit/UIKit.h>
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
///评论内容
@property(nonatomic,copy)NSString *saleOrderProductCommentContent;
///
@property(nonatomic,assign)NSInteger saleOrderProductCommentId;
///
@property(nonatomic,strong)NSArray *saleOrderProductCommentImageList;
///满意度（1-5）
@property(nonatomic,assign)CGFloat saleOrderProductCommentSatisfaction;
///
@property(nonatomic,assign)NSInteger saleOrderProductId;
///
@property(nonatomic,copy)NSString* systemCreateTime;
///是否匿名
@property(nonatomic,assign)BOOL saleOrderProductCommentIsAnonymous ;
@property(nonatomic,assign)NSInteger index;


@end
