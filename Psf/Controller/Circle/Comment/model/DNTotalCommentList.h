//
//  DNTotalCommentList.h
//  DnaerApp
//
//  Created by zhangshu on 2019/3/12.
//  Copyright © 2019 燕来秋. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DNTotalCommentList : NSObject
///
@property (nonatomic,strong) NSArray *list;
///数据条数
@property (nonatomic, assign)NSInteger total;

@end

NS_ASSUME_NONNULL_END
