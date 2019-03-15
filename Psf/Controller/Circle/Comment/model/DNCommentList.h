//
//  DNCommentList.h
//  DnaerApp
//
//  Created by zhangshu on 2019/3/8.
//  Copyright © 2019 燕来秋. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DNCommentExtsReplysModel.h"

#import "ZSConfig.h"
NS_ASSUME_NONNULL_BEGIN

@interface DNCommentList : NSObject<CHGTableViewHeaderFooterModelProtocol>
/// 评论编号
@property (nonatomic, strong) NSString *commentId;
///
@property (nonatomic, strong) NSString *memberCommentTypeId;
/// 评论类型
@property (nonatomic, strong) NSString *memberCommentType;
/// 评论内容
@property (nonatomic, strong) NSString *commentContent;
/// 点赞数
@property (nonatomic, assign) NSInteger commentLikeCount;
///
@property (nonatomic, strong) NSString *memberCommentId;
/// 回复扩展
@property (nonatomic, strong) NSMutableArray<DNCommentExtsReplysModel*> *childComment;
/// 版本号
@property (nonatomic, strong) NSString *systemVersion;
///发评论时间
@property (nonatomic, strong) NSString *systemCreateTime;
///
@property(nonatomic,assign)BOOL wasLiked;
///头像
@property (nonatomic, strong) NSString *memberAvatarPath;
///昵称
@property (nonatomic, strong) NSString *memberNickname;
@property (nonatomic, strong) NSString *memberId;

/// 文本内容的高度
@property(nonatomic,assign) CGFloat content_height;
@property(nonatomic,assign) CGFloat media_height;
@property(nonatomic,assign) CGFloat replay_height;

@end

NS_ASSUME_NONNULL_END
