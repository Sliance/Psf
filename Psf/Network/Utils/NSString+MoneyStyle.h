//
//  NSString+MoneyStyle.h
//  AgentApp
//
//  Created by liujianzhong on 16/10/25.
//  Copyright © 2016年 liujianzhong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (MoneyStyle)

+ (NSString *)addPointToString:(NSString *) originString;

+ (NSString *)clearPointToString:(NSString *) originString;

+ (NSString *)toCapitalLetters:(NSString *)money;

+ (NSString *)addBlankToString:(NSString *)originString;

@end
