//
//  DPTextViewVerify.h
//  SupplierApp
//
//  Created by 张舒 on 17/4/1.
//  Copyright © 2017年 liujianzhong. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <CoreGraphics/CoreGraphics.h>
static NSInteger DPVerifyNullValue = -1;      ///< 空值

typedef NS_ENUM(NSInteger, DPVerifyResult)
{
    DPVerifyResultUnknown = 1,              ///< 未知，为空
    DPVerifyResultSuccess,                  ///< 成功
    DPVerifyResultErrorMax,                 ///< 最大值匹配错误，不会返回，可以不用考虑
    DPVerifyResultErrorMin,                 ///< 最小值匹配错误
    DPVerifyResultErrorRegexString          ///< 正则匹配错误
};

/**
 * 手机号码:
 * 13[0-9], 14[5,7], 15[0, 1, 2, 3, 5, 6, 7, 8, 9], 17[6, 7, 8], 18[0-9], 170[0-9]
 * 移动号段: 134,135,136,137,138,139,150,151,152,157,158,159,182,183,184,187,188,147,178,1705
 * 联通号段: 130,131,132,155,156,185,186,145,176,1709
 * 电信号段: 133,153,180,181,189,177,1700
 */
#define DP_REGEX_MOBILE @"^1(3[0-9]|4[57]|5[0-35-9]|8[0-9]|7[06-8])\\d{8}$"
/**
 * 中国移动：China Mobile
 * 134,135,136,137,138,139,150,151,152,157,158,159,182,183,184,187,188,147,178,1705
 */
#define DP_REGEX_MOBILE_CM  @"(^1(3[4-9]|4[7]|5[0-27-9]|7[8]|8[2-478])\\d{8}$)|(^1705\\d{7}$)"
/**
 * 中国联通：China Unicom
 * 130,131,132,155,156,185,186,145,176,1709
 */
#define DP_REGEX_MOBILE_CU @"(^1(3[0-2]|4[5]|5[56]|7[6]|8[56])\\d{8}$)|(^1709\\d{7}$)"
/**
 * 中国电信：China Telecom
 * 133,153,180,181,189,177,1700
 */
#define DP_REGEX_MOBILE_CT @"(^1(33|53|77|8[019])\\d{8}$)|(^1700\\d{7}$)"


#define Filter_NUMBER @"0123456789\n"
#define Filter_PASSWORD @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789\n"


#import <UIKit/UIKit.h>

/// 验证协议
@protocol DPTextInputVerify <NSObject>

@required
/// 最大小数点位数
@property (assign, nonatomic) NSInteger maxPoint;
/// 最大允许字符长度，默认不校验
@property (assign, nonatomic) NSInteger maxLength;

/// 最小允许字符长度，默认不校验
@property (assign, nonatomic) NSInteger minLength;

/// 验证字符串的是否符合正则表达式
@property (copy, nonatomic) NSString *regexString;

/// 验证结果
@property (readonly, assign, nonatomic) DPVerifyResult verifyResult;

/// 当验证结果改变时回调，只有使用了该属性才会生效，verifyResult表示验证的信息，changeString，验证后的字符串
@property (copy, nonatomic) void (^validityChange)(DPVerifyResult verifyResult, NSString *changeString);

/// 需要验证文本
- (void)setNeedsVerifyText;

@end

/// 验证文本
@protocol DPTextVerify <NSObject>

@required
/// 字符串值,即UITextField、UITextView的Text值
@property (strong, nonatomic) NSString *verifyText;

@end

/// UITextField校验
@interface UITextField (Verify) <DPTextInputVerify, DPTextVerify>

@end

/// UITextView校验
@interface UITextView (Verify) <DPTextInputVerify, DPTextVerify>

@end
