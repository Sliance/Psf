//
//  UploadImageTool.h
//  SupplierApp
//
//  Created by 安天洋 on 2017/3/30.
//  Copyright © 2017年 liujianzhong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QiniuSDK.h"
#import <UIKit/UIKit.h>
#import "BaseApi.h"
#import "ImageModel.h"

@interface UploadImageTool : BaseApi

@property(nonatomic, strong) NSMutableDictionary * uploadDic;


//存放所有的上传图片的网络请求
@property (nonatomic, strong) NSMutableDictionary *mapRequestList;


+ (instancetype)share;

// 获取七牛上传token
- (void)getQiniuUploadWithImages:(NSArray *)imageArray Token:(void (^)(NSArray *))success failure:(void (^)())failure;

/**
 上传图片 可以取消
 
 @param image
 @param progress
 @param UpCancel 取消上传的回调函数
 @param success success description
 @param failure failure description
 @return return value description
 */
- (NSInteger)uploadImage:(UIImage *)image progress:(QNUpProgressHandler)progress cancleRequest:(QNUpCancellationSignal)UpCancel success:(void (^)(NSString *url,NSInteger requestID))success failure:(void (^)())failure;


// 上传多张图片,按队列依次上传
- (void)uploadImages:(NSArray *)imageArray progress:(void (^)(CGFloat))progress success:(void (^)(NSArray *))success failure:(void (^)())failure;


/**
 上传多图片可以取消
 
 @param imageArray 要上传的数组
 @param progress 上传进度
 @param UpCancel 取消上传的回调函数
 @param success success description
 @param failure failure description
 */
- (void)uploadImages:(NSArray *)imageArray progress:(void (^)(CGFloat))progress cancleRequest:(QNUpCancellationSignal)UpCancel success:(void (^)(NSArray *))success failure:(void (^)())failure;


@end
