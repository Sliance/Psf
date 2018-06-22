//
//  ZSSignatureGenerator.m
//  Psf
//
//  Created by 燕来秋mac9 on 2018/6/21.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "ZSSignatureGenerator.h"
#import "NSString+Hash.h"
#define DPSIGNATURE @"RNKCoeffPosGEwv7FpLsWokxTozPt9ki"//加密key

@implementation ZSSignatureGenerator
/**
 加密字符串，用于签名
 签名时把参数拼接成字符串，传到这个方法加密，返回的就是签名
 */
+ (NSString *)signGETRestfulRequestWithSignParams:(NSString *) signature{
    // 加密字符串
    NSString *encryptStr = [signature hmacSHA1StringWithKey:DPSIGNATURE];
    return encryptStr;
}

+ (NSDictionary *)compomentParamsAndOrder:(NSDictionary *) originParam {
    NSMutableDictionary *dictionaryResult = [NSMutableDictionary dictionary];
    NSMutableDictionary *dictionarySign = [NSMutableDictionary dictionaryWithDictionary:originParam];
    NSMutableArray *keys = [[NSMutableArray alloc]initWithCapacity:5];
    [keys addObjectsFromArray:[dictionarySign allKeys]];
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"" ascending:YES];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:&sortDescriptor count:1];
    [keys  sortUsingDescriptors:sortDescriptors];
    for(NSString* key in keys){
        NSString *val = [dictionarySign objectForKey:key];
        [dictionaryResult setValue:val forKey:key];
    }
    return dictionaryResult;
}

+ (NSString *)getAccessToken {
    //    MemberEntity *mem = [[TYConfigManager shared] getMember];
    //    NSString *token = mem.accessToken;
    //    if (token.length == 0) {
    //        token = @"";
    //    }
    return @"";
}

+ (NSString *)paramStringWithDictionary:(NSDictionary *) dicSign {
    NSDictionary *dicParam = [ZSSignatureGenerator compomentParamsAndOrder:dicSign];
    NSMutableString *signature  = [NSMutableString string];
    NSArray *keys = [dicParam allKeys];
    for(NSString* key in keys){
        NSString *val = [dicSign objectForKey:key];
        if ([signature length] <= 0) {
            //第一个参数
        }else{
            [signature appendString:@"&"];
        }
        [signature appendFormat:@"%@=%@", key, val];
    }
    return signature;
}

@end
