//
//  RecipeCollectModel.h
//  Psf
//
//  Created by zhangshu on 2019/1/21.
//  Copyright © 2019 zhangshu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RecipeCollectModel : NSObject
@property(nonatomic,assign)BOOL memberWasCollection;
@property(nonatomic,assign)BOOL memberWasLiked;
@property(nonatomic,strong)NSString* totalCollection;
@property(nonatomic,strong)NSString* totalCommentNum;
@property(nonatomic,strong)NSString* totalForwardCount;
@property(nonatomic,strong)NSString* totalLike;

@end

NS_ASSUME_NONNULL_END
