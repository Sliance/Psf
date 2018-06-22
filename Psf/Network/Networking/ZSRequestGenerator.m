//
//  ZSRequestGenerator.m
//  Psf
//
//  Created by 燕来秋mac9 on 2018/6/21.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "ZSRequestGenerator.h"
#import "ZSAFNetworkingConfig.h"
#import "ZSSignatureGenerator.h"
#import "FilePathManager.h"
#import "ZSConfig.h"
#import "NSString+Hash.h"
#import "DeviceModel.h"
@interface ZSRequestGenerator ()

@property (nonatomic, strong) AFHTTPRequestSerializer *httpRequestSerializer;

@end
@implementation ZSRequestGenerator
#pragma mark - getters and setters
- (AFHTTPRequestSerializer *)httpRequestSerializer
{
    if (_httpRequestSerializer == nil) {
        _httpRequestSerializer = [AFHTTPRequestSerializer serializer];
        _httpRequestSerializer.timeoutInterval = kAIFNetworkingTimeoutSeconds;
        _httpRequestSerializer.cachePolicy = NSURLRequestUseProtocolCachePolicy;
    }
    return _httpRequestSerializer;
}

+ (instancetype)shareInstance {
    static ZSRequestGenerator *reqest = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (reqest == nil) {
            reqest = [[ZSRequestGenerator alloc] init];
        }
    });
    return reqest;
}
//读取保存到本地的 Api
-(NSString *)supplierApiStr{
    NSString * apistr;
#ifdef DEBUG_quibo
    apistr = [[NSUserDefaults standardUserDefaults] valueForKey:SUPPLIERAPIKEY];
    if ([apistr length] < 1) {
        apistr = DEBUG_DPHOST;
        [[NSUserDefaults standardUserDefaults] setObject:DEBUG_DPHOST forKey:SUPPLIERAPIKEY];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
#else
    apistr = DPHOST;
#endif
    
    return apistr;
}
- (NSURLRequest *)generateGETRequestWithServiceUrl:(NSString *)url requestParams:(NSDictionary *) requestParams
{
    NSMutableDictionary *dicParams = [NSMutableDictionary dictionaryWithDictionary:requestParams];
    [dicParams addEntriesFromDictionary:[self commonParams]];
    
    //参数表按字母排序，拼接成字符串
    NSDictionary *dicOrder = [NSDictionary dictionary];
    dicOrder = [ZSSignatureGenerator compomentParamsAndOrder:dicParams];
    NSString *paramString = [dicOrder TY_urlParamsStringSignature:YES];
    
    NSMutableDictionary *dicSignature = [NSMutableDictionary dictionaryWithDictionary:dicParams];
    [dicSignature setObject:[self commonHeader] forKey:@"useragent"];
    NSDictionary *dicOrderSigneture = [NSDictionary dictionary];
    [dicSignature setObject:[self commonHeader] forKey:@"useragent"];
    dicOrderSigneture = [ZSSignatureGenerator compomentParamsAndOrder:dicSignature];//参数表按字母排序，拼接成字符串
    NSString *paramStringSigneture = [dicOrderSigneture TY_urlParamsStringSignature:YES];
    NSString *signature = [ZSSignatureGenerator signGETRestfulRequestWithSignParams:paramStringSigneture];
    
    NSString *urlString = @"";
    if ([url rangeOfString:@"?"].length > 0) {
        urlString = [NSString stringWithFormat:@"%@%@%@&signature=%@",[self supplierApiStr], url, paramString,
                     signature];
    } else {
        urlString = [NSString stringWithFormat:@"%@%@?%@&signature=%@",[self supplierApiStr], url, paramString,
                     signature];
    }
    urlString =  [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"NEW reqeust URL:%@", urlString);
    
    NSMutableURLRequest *request = [self.httpRequestSerializer requestWithMethod:@"GET" URLString:urlString parameters:nil error:NULL];
    request.timeoutInterval = kAIFNetworkingTimeoutSeconds;
    [self setCommonHeaderInfo:request];
    return request;
}

- (NSURLRequest *)generatePOSTRequestWithServiceUrl:(NSString *)url requestParams:(NSDictionary *)requestParams
{
    //参数
    NSMutableDictionary *dicParams = [NSMutableDictionary dictionaryWithDictionary:requestParams];
    [dicParams addEntriesFromDictionary:[self commonParams]];
    
    //签名
    NSMutableDictionary *dicSignature = [NSMutableDictionary dictionaryWithDictionary:dicParams];
    [dicSignature setObject:[self commonHeader] forKey:@"useragent"];
    NSDictionary *dicOrder = [NSDictionary dictionary];
    dicOrder = [ZSSignatureGenerator compomentParamsAndOrder:dicSignature];//参数表按字母排序，拼接成字符串
    NSString *paramStringSigneture = [dicOrder TY_urlParamsStringSignature:YES];
    NSString *signature = [ZSSignatureGenerator signGETRestfulRequestWithSignParams:paramStringSigneture];
    NSString *urlString = [NSString stringWithFormat:@"%@%@",[self supplierApiStr], url];
    urlString =  [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"NEW reqeust URL:%@", urlString);
    
    //加上签名串
    [dicParams setValue:signature forKey:@"signature"];
    
    NSMutableURLRequest *request = [self.httpRequestSerializer requestWithMethod:@"POST" URLString:urlString parameters:dicParams error:NULL];
    [self setCommonHeaderInfo:request];
    request.timeoutInterval = kAIFNetworkingTimeoutSeconds;
    return request;
}

- (NSURLRequest *)generateDELETERequestWithServiceUrl:(NSString *)url requestParams:(NSDictionary *) requestParams
{
    NSMutableDictionary *dicParams = [NSMutableDictionary dictionaryWithDictionary:requestParams];
    [dicParams addEntriesFromDictionary:[self commonParams]];
    
    //参数表按字母排序，拼接成字符串
    NSDictionary *dicOrder = [NSDictionary dictionary];
    dicOrder = [ZSSignatureGenerator compomentParamsAndOrder:dicParams];
    NSString *paramString = [dicOrder TY_urlParamsStringSignature:YES];
    
    NSMutableDictionary *dicSignature = [NSMutableDictionary dictionaryWithDictionary:dicParams];
    [dicSignature setObject:[self commonHeader] forKey:@"useragent"];
    NSDictionary *dicOrderSigneture = [NSDictionary dictionary];
    [dicSignature setObject:[self commonHeader] forKey:@"useragent"];
    dicOrderSigneture = [ZSSignatureGenerator compomentParamsAndOrder:dicSignature];//参数表按字母排序，拼接成字符串
    NSString *paramStringSigneture = [dicOrderSigneture TY_urlParamsStringSignature:YES];
    NSString *signature = [ZSSignatureGenerator signGETRestfulRequestWithSignParams:paramStringSigneture];
    
    NSString *urlString = @"";
    if ([url rangeOfString:@"?"].length > 0) {
        urlString = [NSString stringWithFormat:@"%@%@%@&signature=%@",[self supplierApiStr], url, paramString,
                     signature];
    } else {
        urlString = [NSString stringWithFormat:@"%@%@?%@&signature=%@",[self supplierApiStr], url, paramString,
                     signature];
    }
    urlString =  [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"NEW reqeust URL:%@", urlString);
    
    NSMutableURLRequest *request = [self.httpRequestSerializer requestWithMethod:@"DELETE" URLString:urlString parameters:nil error:NULL];
    request.timeoutInterval = kAIFNetworkingTimeoutSeconds;
    [self setCommonHeaderInfo:request];
    return request;
}

- (NSURLRequest *)generateUploadImageRequestWithServiceData:(UIImage *)image
{
    NSMutableDictionary *dicParams = [NSMutableDictionary dictionaryWithDictionary:@{}];
    [dicParams addEntriesFromDictionary:[self commonParams]];
    //签名
    NSMutableDictionary *dicSignature = [NSMutableDictionary dictionaryWithDictionary:dicParams];
    [dicSignature setObject:[self commonHeader] forKey:@"useragent"];
    NSDictionary *dicOrder = [NSDictionary dictionary];
    dicOrder = [ZSSignatureGenerator compomentParamsAndOrder:dicSignature];//参数表按字母排序，拼接成字符串
    NSString *paramStringSigneture = [dicOrder TY_urlParamsStringSignature:YES];
    NSString *signature = [ZSSignatureGenerator signGETRestfulRequestWithSignParams:paramStringSigneture];
    
    NSString *url = @"/upload/image?";
    NSString *urlString = [NSString stringWithFormat:@"%@%@",[self supplierApiStr], url];
    urlString =  [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    //加上签名串
    [dicParams setValue:signature forKey:@"signature"];
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:urlString parameters:dicParams constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileData:UIImagePNGRepresentation(image) name:@"filedata" fileName:[NSString stringWithFormat:@"%@_ds.jpg",[self getNowTime]] mimeType:@"image/jpg"];
    } error:nil];
    [self setCommonHeaderInfo:request];
    return request;
}

- (NSURLRequest *)generateDownloadFileWithServiceUrl:(NSString *)url
{
    NSString *requestUrl = [NSString stringWithFormat:@"%@%@", [self supplierApiStr], url];
    NSMutableURLRequest *request = [self.httpRequestSerializer requestWithMethod:@"GET" URLString:requestUrl parameters:@{} error:NULL];
    [self setCommonHeaderInfo:request];
    request.timeoutInterval = kAIFNetworkingTimeoutSeconds;
    return request;
}

/**签名是参数+User-Agent加密组成的，而实际的网络请求参数中不包含User-Agent，User-Agent仅仅参与签名与header*/
- (NSString *)componentHeaderWithParamString:(NSString *) paramString {
    NSString *stringSign = [NSString stringWithFormat:@"%@&useragent=%@", paramString, [self commonHeader]];
    return stringSign;
}

/**公共参数放在这里*/
-(NSDictionary *)commonParams
{
#pragma mark - 修改参数
    NSMutableDictionary *dicCommonParams = [NSMutableDictionary dictionary];
    [dicCommonParams setValue:[NSNumber numberWithInt:(int)[self getRandomPositiveInteger]] forKey:@"nonce"];
    [dicCommonParams setValue:@1 forKey:@"app_id"];
    [dicCommonParams setValue:[self getNowTime] forKey:@"timestamp"];
    [dicCommonParams setValue:[DeviceModel getLatitude] forKey:@"latitude"];
    [dicCommonParams setValue:[DeviceModel getLongitude] forKey:@"longitude"];
    //暂留
    return dicCommonParams;
}

/**给request设置一个User-Agent值，给后台做数据统计用*/
- (void)setCommonHeaderInfo:(NSMutableURLRequest *) request {
    NSString *requestHeader = [self commonHeader];
    [request setValue:requestHeader forHTTPHeaderField:@"User-Agent"];
}

- (NSString *)commonHeader {
    NSString *stringHeader = [NSString stringWithFormat:@"%@/%@ (OS:iOS %@;Model:%@;UUID:%@;NetType:%@;GPS:%@;PM:%@)",
                              APPNAME,
                              [DeviceModel appVersion],
                              [DeviceModel iosVersion],
                              [DeviceModel iosType],
                              [DeviceModel uniqueIdentifier],
                              [DeviceModel networkStatus],
                              [DeviceModel getLocationStatus],
                              [self environment]];
    return stringHeader;
}
//不同环境的渠道号
- (NSString *)environment {
    NSString *envi = @"";
    NSString *hostUrl = @"";
    NSString *localHost = [[NSUserDefaults standardUserDefaults] valueForKey:SUPPLIERAPIKEY];;
    if (localHost != nil && localHost.length > 1) {
        hostUrl = localHost;
    } else {
        hostUrl = DPHOST;
    }
    if ([hostUrl containsString:@"dev"]) {
        envi = @"Development";
    } else if ([hostUrl containsString:@"test"]) {
        envi = @"Test";
    } else if ([hostUrl containsString:@"api"]) {
        envi = @"Production";
    }else if ([hostUrl containsString:@"sandbox"]) {
        envi = @"qiubo-sandbox";
    }
    return envi;
}
//获取当前时间戳
- (NSString *)getNowTime
{
    //获取系统当前的时间戳
    UInt64 recordTime = [[NSDate date] timeIntervalSince1970]*1000;
    NSString *timeStr = [NSString stringWithFormat:@"%lld", recordTime];
    //    NSLog(@"%ld", [timeStr integerValue]);
    return timeStr;
}

//生成随机正整数
- (NSInteger)getRandomPositiveInteger
{
    return  (NSInteger)(1 + (arc4random() % (100 - 1 + 1)));
}

/**
 网络地址加密
 */
-(NSString *)generateNetWorkingRequestURLWithServiceUrl:(NSString *)url requestParams:(NSDictionary *) requestParams{
    
    NSMutableDictionary *dicParams = [NSMutableDictionary dictionaryWithDictionary:requestParams];
    [dicParams addEntriesFromDictionary:[self commonParams]];
    
    //参数表按字母排序，拼接成字符串
    NSDictionary *dicOrder = [NSDictionary dictionary];
    dicOrder = [ZSSignatureGenerator compomentParamsAndOrder:dicParams];
    NSString *paramString = [dicOrder TY_urlParamsStringSignature:YES];
    
    NSMutableDictionary *dicSignature = [NSMutableDictionary dictionaryWithDictionary:dicParams];
    [dicSignature setObject:[self commonHeader] forKey:@"useragent"];
    NSDictionary *dicOrderSigneture = [NSDictionary dictionary];
    [dicSignature setObject:[self commonHeader] forKey:@"useragent"];
    dicOrderSigneture = [ZSSignatureGenerator compomentParamsAndOrder:dicSignature];//参数表按字母排序，拼接成字符串
    NSString *paramStringSigneture = [dicOrderSigneture TY_urlParamsStringSignature:YES];
    NSString *signature = [ZSSignatureGenerator signGETRestfulRequestWithSignParams:paramStringSigneture];
    
    NSString *urlString = @"";
    if ([url rangeOfString:@"?"].length > 0) {
        urlString = [NSString stringWithFormat:@"%@%@%@&signature=%@",[self supplierApiStr], url, paramString,
                     signature];
    } else {
        urlString = [NSString stringWithFormat:@"%@%@?%@&signature=%@",[self supplierApiStr], url, paramString,
                     signature];
    }
    urlString =  [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"NEW reqeust URL:%@", urlString);
    
    NSMutableURLRequest *request = [self.httpRequestSerializer requestWithMethod:@"GET" URLString:urlString parameters:nil error:NULL];
    request.timeoutInterval = kAIFNetworkingTimeoutSeconds;
    [self setCommonHeaderInfo:request];
    
    return urlString;
    
}

/**
 网络请求参数加密
 
 @param url 网络请求地址
 @param requestParams 参数
 @return 返回加密之后的参数
 */
-(NSDictionary *)generateNetWorkingRequestParamsWithServiceUrl:(NSString *)url requestParams:(NSDictionary *) requestParams{
    //参数
    NSMutableDictionary *dicParams = [NSMutableDictionary dictionaryWithDictionary:requestParams];
    [dicParams addEntriesFromDictionary:[self commonParams]];
    
    //签名
    NSMutableDictionary *dicSignature = [NSMutableDictionary dictionaryWithDictionary:dicParams];
    [dicSignature setObject:[self commonHeader] forKey:@"useragent"];
    NSDictionary *dicOrder = [NSDictionary dictionary];
    dicOrder = [ZSSignatureGenerator compomentParamsAndOrder:dicSignature];//参数表按字母排序，拼接成字符串
    NSString *paramStringSigneture = [dicOrder TY_urlParamsStringSignature:YES];
    NSString *signature = [ZSSignatureGenerator signGETRestfulRequestWithSignParams:paramStringSigneture];
    NSString *urlString = [NSString stringWithFormat:@"%@%@",[self supplierApiStr], url];
    urlString =  [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"NEW reqeust URL:%@", urlString);
    
    //加上签名串
    [dicParams setValue:signature forKey:@"signature"];
    
    NSMutableURLRequest *request = [self.httpRequestSerializer requestWithMethod:@"POST" URLString:urlString parameters:dicParams error:NULL];
    [self setCommonHeaderInfo:request];
    request.timeoutInterval = kAIFNetworkingTimeoutSeconds;
    return dicParams;
}

@end
