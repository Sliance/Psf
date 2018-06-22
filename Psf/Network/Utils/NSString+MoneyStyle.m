//
//  NSString+MoneyStyle.m
//  AgentApp
//
//  Created by liujianzhong on 16/10/25.
//  Copyright © 2016年 liujianzhong. All rights reserved.
//

#import "NSString+MoneyStyle.h"

@implementation NSString (MoneyStyle)

+ (NSString *)addPointToString:(NSString *) originString {
    NSString *localString = originString;
    originString = [NSString stringWithFormat:@"%.2f",[originString doubleValue]];
    originString = [originString stringByReplacingOccurrencesOfString:@"," withString:@""];
    NSArray *array = [originString componentsSeparatedByString:@"."];
    NSString *stringResult = @"";
    if (array.count >= 1) {
        NSString *stringInteger = [NSString stringWithFormat:@"%@",array[0]];
        stringInteger = [stringInteger stringByReplacingOccurrencesOfString:@"-" withString:@""];
        NSMutableArray *arrayChar = [NSMutableArray array];
        for (NSInteger index = stringInteger.length - 1; index >= 0; index --) {
            [arrayChar addObject:[stringInteger substringWithRange:NSMakeRange(index, 1)]];
            if ((stringInteger.length - index)%3 == 0 && index!=0) {
                [arrayChar addObject:@","];
            }
        }
        NSMutableArray *arrayOrderChar = [NSMutableArray array];
        for (NSInteger index = arrayChar.count-1; index>=0; index --) {
            [arrayOrderChar addObject:arrayChar[index]];
        }
        for (NSInteger index = 0; index < arrayOrderChar.count; index ++) {
            if (stringResult.length > 0) {
                stringResult = [NSString stringWithFormat:@"%@%@", stringResult,arrayOrderChar[index]];
            } else {
                stringResult = [NSString stringWithFormat:@"%@",arrayOrderChar[index]];
            }
        }
    }
    if (array.count == 2) {
        stringResult = [NSString stringWithFormat:@"%@.%@",stringResult,array[1]];
    }
    if ([localString doubleValue] < 0) {
        stringResult = [NSString stringWithFormat:@"-%@",stringResult];
    }
    return stringResult;
}

+ (NSString *)clearPointToString:(NSString *) originString{
    NSString *stringResult = @"";
    stringResult=[originString stringByReplacingOccurrencesOfString:@","withString:@""];
    return stringResult;

}

+ (NSString *)toCapitalLetters:(NSString *)money
{
    //首先转化成标准格式        “200.23”
    NSMutableString *tempStr = [[NSMutableString alloc] initWithString:money];
    //位
    NSArray *carryArr1=@[@"元", @"拾", @"佰", @"仟", @"万", @"拾", @"佰", @"仟", @"亿", @"拾", @"佰", @"仟", @"兆", @"拾", @"佰", @"仟" ];
    NSArray *carryArr2=@[@"分",@"角"];
    //数字
    NSArray *numArr=@[@"零", @"壹", @"贰", @"叁", @"肆", @"伍", @"陆", @"柒", @"捌", @"玖"];
    
    NSArray *temarr = [tempStr componentsSeparatedByString:@"."];
    //小数点前的数值字符串
    NSString *firstStr=[NSString stringWithFormat:@"%.0f",[temarr[0] doubleValue]];
    if (firstStr.length > 16) {
        firstStr = [firstStr substringToIndex:16];
        return @"超出计算长度";
    }
    //小数点后的数值字符串
    NSString *secondStr;
    if (temarr.count > 1) {
        secondStr = [NSString stringWithFormat:@"%@",temarr[1]];
    } else {
        secondStr = @"";
    }
    
    //是否拼接了“零”，做标记
    bool zero=NO;
    //拼接数据的可变字符串
    NSMutableString *endStr=[[NSMutableString alloc] init];
    
    /**
     *  首先遍历firstStr，从最高位往个位遍历    高位----->个位
     */
    
    for(int i=(int)firstStr.length;i>0;i--)
    {
        //取最高位数
        NSInteger MyData=[[firstStr substringWithRange:NSMakeRange(firstStr.length-i, 1)] integerValue];
        
        if ([numArr[MyData] isEqualToString:@"零"]) {
            if ([carryArr1[i-1] isEqualToString:@"万"]||[carryArr1[i-1] isEqualToString:@"亿"]||[carryArr1[i-1] isEqualToString:@"元"]||[carryArr1[i-1] isEqualToString:@"兆"]) {
                //去除有“零万”
                if (zero) {
                    endStr =[NSMutableString stringWithFormat:@"%@",[endStr substringToIndex:(endStr.length-1)]];
                    [endStr appendString:carryArr1[i-1]];
                    zero=NO;
                }else{
                    [endStr appendString:carryArr1[i-1]];
                    zero=NO;
                }
                
                //去除有“亿万”、"兆万"的情况
                if ([carryArr1[i-1] isEqualToString:@"万"]) {
                    if ([[endStr substringWithRange:NSMakeRange(endStr.length-2, 1)] isEqualToString:@"亿"]) {
                        endStr =[NSMutableString stringWithFormat:@"%@",[endStr substringToIndex:endStr.length-1]];
                    }
                    
                    if ([[endStr substringWithRange:NSMakeRange(endStr.length-2, 1)] isEqualToString:@"兆"]) {
                        endStr =[NSMutableString stringWithFormat:@"%@",[endStr substringToIndex:endStr.length-1]];
                    }
                    
                }
                //去除“兆亿”
                if ([carryArr1[i-1] isEqualToString:@"亿"]) {
                    if ([[endStr substringWithRange:NSMakeRange(endStr.length-2, 1)] isEqualToString:@"兆"]) {
                        endStr =[NSMutableString stringWithFormat:@"%@",[endStr substringToIndex:endStr.length-1]];
                    }
                }
                
                
            }else{
                if (!zero) {
                    [endStr appendString:numArr[MyData]];
                    zero=YES;
                }
                
            }
            
        }else{
            //拼接数字
            [endStr appendString:numArr[MyData]];
            //拼接位
            [endStr appendString:carryArr1[i-1]];
            //不为“零”
            zero=NO;
        }
    }
    
    /**
     *  再遍历secondStr    角位----->分位
     */
    
    
    if ([secondStr isEqualToString:@"00"]) {
        secondStr = [secondStr stringByReplacingOccurrencesOfString:@"00" withString:@""];
    }
    if (secondStr.length > 0) {
        [endStr appendString:@"."];
    }
    //    else{
    for(int i=(int)secondStr.length;i>0;i--)
    {
        //取最高位数
        NSInteger MyData=[[secondStr substringWithRange:NSMakeRange(secondStr.length-i, 1)] integerValue];
        if (MyData < numArr.count) {
            [endStr appendString:numArr[MyData]];
        }
        //[endStr appendString:carryArr2[i-1]];
    }
    //    }
    if([endStr containsString:@"元"]){
        endStr = [NSMutableString  stringWithString:[endStr stringByReplacingOccurrencesOfString:@"元" withString:@""]];
    }
    if([endStr containsString:@"角"]){
        endStr = [NSMutableString  stringWithString:[endStr stringByReplacingOccurrencesOfString:@"角" withString:@""]];
    }
    if([endStr containsString:@"分"]){
        endStr = [NSMutableString  stringWithString:[endStr stringByReplacingOccurrencesOfString:@"分" withString:@""]];
    }
    return endStr;
}
+(NSString *)addBlankToString:(NSString *)originString{
    originString = [originString stringByReplacingOccurrencesOfString:@"   " withString:@""];
    NSArray *array = [originString componentsSeparatedByString:@"."];
    NSString *stringResult = @"";
    if (array.count >= 1) {
        NSString *stringInteger = array[0];
        NSMutableArray *arrayChar = [NSMutableArray array];
        for (NSInteger index = 0; index <= stringInteger.length - 1; index ++) {
            [arrayChar addObject:[stringInteger substringWithRange:NSMakeRange(index, 1)]];
            if ((index)%4 == 3 && index!=0) {
                [arrayChar addObject:@"   "];
            }
        }
        for (NSInteger index = 0; index < arrayChar.count; index ++) {
            if (stringResult.length > 0) {
                stringResult = [NSString stringWithFormat:@"%@%@", stringResult,arrayChar[index]];
            } else {
                stringResult = [NSString stringWithFormat:@"%@",arrayChar[index]];
            }
        }
    }
    if (array.count == 2) {
        stringResult = [NSString stringWithFormat:@"%@.%@",stringResult,array[1]];
    }
    return stringResult;

}
@end
