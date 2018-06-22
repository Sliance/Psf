//
//  NSData+ZSCache.h
//  ZSCycleScrollView
//
//  Created by 燕来秋mac9 on 2018/6/15.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (ZSCache)
/**
 *  根据identifier存储数据缓存
 *
 *  @param identifier 数据缓存的唯一标识符
 */
- (void)savaDataCacheWithIdentifier:(NSString*)identifier;

/**
 *  根据identifier获取数据缓存
 *
 *  @param identifier 数据缓存的唯一标识符
 *
 *  @return 唯一标识符所对应的数据缓存
 */
+ (NSData *)getDataCacheWithIdentifier:(NSString*)identifier;


/**
 *  清除所有缓存
 */
+ (void)clear;

@end
