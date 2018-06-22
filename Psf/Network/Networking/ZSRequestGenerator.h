//
//  ZSRequestGenerator.h
//  Psf
//
//  Created by 燕来秋mac9 on 2018/6/21.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
@interface ZSRequestGenerator : NSObject
+ (instancetype)shareInstance;
/**
 组建51版GET请求
 */
- (NSURLRequest *)generateGETRequestWithServiceUrl:(NSString *)url requestParams:(NSDictionary *) requestParams;

/**
 组建51版POST请求
 */
- (NSURLRequest *)generatePOSTRequestWithServiceUrl:(NSString *)url requestParams:(NSDictionary *)requestParams;
/**
 组建51版DELETE请求
 */
- (NSURLRequest *)generateDELETERequestWithServiceUrl:(NSString *)url requestParams:(NSDictionary *) requestParams;
/**
 组建51版上传图片
 */
- (NSURLRequest *)generateUploadImageRequestWithServiceData:(UIImage *)image;
/**
 组建51版下载文件
 */
- (NSURLRequest *)generateDownloadFileWithServiceUrl:(NSString *)url;

/**
 网络地址加密
 */
-(NSString *)generateNetWorkingRequestURLWithServiceUrl:(NSString *)url requestParams:(NSDictionary *) requestParams;

/**
 网络请求参数加密
 
 @param url 网络请求地址
 @param requestParams 参数
 @return 返回加密之后的参数
 */
-(NSDictionary *)generateNetWorkingRequestParamsWithServiceUrl:(NSString *)url requestParams:(NSDictionary *) requestParams;


@end
