//
//  ZSSignatureGenerator.h
//  Psf
//
//  Created by 燕来秋mac9 on 2018/6/21.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 这个类是用来签名用的，需要有下面几个必须的方法：
 1，生成token，
 2，把参数按字母排序并拼接成字符串，
 3，生成签名字符串
 */
@interface ZSSignatureGenerator : NSObject
/**
 加密字符串，用于签名
 签名时把参数拼接成字符串，传到这个方法加密，返回的就是签名
 */
+ (NSString *)signGETRestfulRequestWithSignParams:(NSString *) signature;

/**
 组合新的参数字典，接上签名参数
 原始参数+公共参数+签名参数
 */
+ (NSDictionary *)compomentParamsAndOrder:(NSDictionary *) originParam;

/**
 得到签名需要的TOKEN
 */
+ (NSString *)getAccessToken;

/**
 没做特殊字符处理，暂不可用！
 
 拼接签名参数字符串，在拼接url时，参数部分可以用这个方法
 
 参数：
 dicSign : 原始参数+公共参数
 */
+ (NSString *)paramStringWithDictionary:(NSDictionary *) dicSign;

@end
