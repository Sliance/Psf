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
@property(nonatomic,copy)NSString *epicureId;
///
@property(nonatomic,copy)NSString *epicureImgPath;
///
@property(nonatomic,copy)NSString *epicureName;
///
@property(nonatomic,copy)NSString *memberWasLiked;
///
@property(nonatomic,copy)NSString *totalLike;
///
@property(nonatomic,assign)CGFloat height;
///
@property(nonatomic,copy)NSString *articleId;
///
@property(nonatomic,copy)NSString *articleImgPath;
///
@property(nonatomic,copy)NSString *articleName;

@end

NS_ASSUME_NONNULL_END
