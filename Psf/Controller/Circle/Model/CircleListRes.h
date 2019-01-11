//
//  CircleListRes.h
//  Ypc
//
//  Created by zhangshu on 2019/1/8.
//  Copyright © 2019 zhangshu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface CircleListRes : NSObject
///
@property(nonatomic,copy)NSString *memberAvatarPath;
///
@property(nonatomic,copy)NSString *wasLiked;
///
@property(nonatomic,copy)NSString *topicForwardCount;
///
@property(nonatomic,copy)NSString *topicMediaJsonList;
///
@property(nonatomic,copy)NSString *topicImagePath;
///
@property(nonatomic,copy)NSString *topicBookCount;
///
@property(nonatomic,copy)NSString *topicLikeCount;
///
@property(nonatomic,copy)NSString *topicId;
///
@property(nonatomic,copy)NSString *topicContent;
///
@property(nonatomic,copy)NSString *topicCategoryId;
///
@property(nonatomic,copy)NSString *systemCreateTime;
///
@property(nonatomic,copy)NSString *topicCommentCount;
///
@property(nonatomic,copy)NSString *memberNickname;
///
@property(nonatomic,copy)NSString *memberId;
///
@property(nonatomic,assign)CGFloat height;

@end

NS_ASSUME_NONNULL_END
