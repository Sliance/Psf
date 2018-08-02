//
//  UploadImageTool.m
//  SupplierApp
//
//  Created by 安天洋 on 2017/3/30.
//  Copyright © 2017年 liujianzhong. All rights reserved.
//

#import "UploadImageTool.h"
#import "AFNetworking.h"
#import "AFNetworkActivityIndicatorManager.h"
#import "QiniuUploadHelper.h"
#import <CommonCrypto/CommonDigest.h>
#import "UserCacheBean.h"
#import "NSObject+AddKeyValueToObject.h"
#import "UIImage+Resize.h"

//domain = "https://qiubo-dev-static2.dongpinbang.com";
//expires = 1490868856;
//prefix = "media/images/";
//token = "lUWW6AhJ68bbV1eWqvMDN2aJdgyVLj8ggJE8sqEH:8_huwIsjW_XD2GKwqtXYf_FVoZI=:eyJzY29wZSI6ImZyb3plbi11cGxvYWQtZGV2IiwiZGVhZGxpbmUiOjE0OTA4Njg4NTZ9";


#define UPLOADIMAGETOKENDIC  @"UploadImageTokenDic"

@implementation UploadImageTool

- (NSMutableDictionary *)mapRequestList {
    if (_mapRequestList == nil) {
        _mapRequestList = [NSMutableDictionary dictionary];
    }
    return _mapRequestList;
}


+ (instancetype)share {
    static UploadImageTool *global;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (global == nil) {
            global = [[UploadImageTool alloc] init];
        }
    });
    return global;
}

//上传单张图片 可以取消
- (NSInteger)uploadImage:(UIImage *)image progress:(QNUpProgressHandler)progress cancleRequest:(QNUpCancellationSignal)UpCancel success:(void (^)(NSString *url,NSInteger requestID))success failure:(void (^)())failure{
    
    dispatch_group_t group = dispatch_group_create();
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(1);
    
    NSInteger requestID = arc4random() % 99999;
    NSData *data = UIImageJPEGRepresentation(image, 1.0);
    if (!data) {
        if (failure) {
            failure();
        }
    }
    self.uploadDic = [[NSUserDefaults standardUserDefaults] objectForKey:UPLOADIMAGETOKENDIC];
    NSString * fileName = [NSString stringWithFormat:@"%@%@.jpg",[_uploadDic objectForKey:@"prefix"],[self hah1_imagewithData:data]];
    NSString *token = [_uploadDic objectForKey:@"token"];
    QNUploadOption *opt = [[QNUploadOption alloc] initWithMime:nil
                                               progressHandler:progress
                                                        params:nil
                                                      checkCrc:NO
                                            cancellationSignal:UpCancel];
    
    NSNumber *requestNumber = [NSNumber numberWithInteger:requestID];
    self.mapRequestList [requestNumber] = opt;
    
    BOOL isHttps = TRUE;
    QNZone * httpsZone = [[QNAutoZone alloc] initWithDns:nil];
    QNConfiguration *config = [QNConfiguration build:^(QNConfigurationBuilder *builder) {
        builder.zone = httpsZone;
    }];
    
    QNUploadManager *upManager = [[QNUploadManager alloc] initWithConfiguration:config];
    [upManager putData:data
                   key:fileName
                 token:token
              complete:^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
                  if (info.statusCode == 200 && resp) {
                      NSString *url= [NSString stringWithFormat:@"%@/%@", [_uploadDic objectForKey:@"domain"], resp[@"key"]];
                      if (success) {
                          dispatch_semaphore_signal(semaphore);
                          NSLog(@"图片上传成功");
                          success(url,requestID);
                          [self.mapRequestList removeObjectForKey:[NSNumber numberWithInteger:requestID]];
                      }
                  }else {
                      if (failure) {
                          dispatch_semaphore_signal(semaphore);
                          NSLog(@"图片上传失败");
                          failure();
                          [self.mapRequestList removeObjectForKey:[NSNumber numberWithInteger:requestID]];
                      }
                  }
              } option:opt];
    
    dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
    return requestID;
}

//上传多张图片
- (void)uploadImages:(NSArray *)imageArray progress:(void (^)(CGFloat))progress success:(void (^)(NSArray *))success failure:(void (^)())failure {
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    __block CGFloat totalProgress = 0.0f;
    __block CGFloat partProgress = 1.0f / [imageArray count];
    __block NSUInteger currentIndex = 0;
    
    QiniuUploadHelper *uploadHelper = [QiniuUploadHelper sharedUploadHelper];
    __weak typeof(uploadHelper) weakHelper = uploadHelper;
    
    uploadHelper.singleFailureBlock = ^() {
        failure();
        return;
    };
    uploadHelper.singleSuccessBlock  = ^(NSString *url,NSInteger requestID) {
        [array addObject:url];
        totalProgress += partProgress;
        progress(totalProgress);
        currentIndex++;
        if ([array count] == [imageArray count]) {
            success([array copy]);
            return;
        }
        else {
            NSLog(@"---%ld",(unsigned long)currentIndex);
            if (currentIndex<imageArray.count) {
                
                [self uploadImage:imageArray[currentIndex] progress:nil cancleRequest:^BOOL{
                    return YES;
                } success:weakHelper.singleSuccessBlock failure:weakHelper.singleFailureBlock];
            }
            
        }
    };
    
    [self uploadImage:imageArray[0] progress:nil cancleRequest:^BOOL{
        return YES;
    } success:weakHelper.singleSuccessBlock failure:weakHelper.singleFailureBlock];
}

/**
 上传多图片可以取消
 
 @param imageArray 要上传的图片数组
 @param progress 上传进度
 @param UpCancel 取消上传的回调函数
 @param success 成功的回调
 @param failure 失败的回调
 */
- (void)uploadImages:(NSArray *)imageArray progress:(void (^)(CGFloat))progress cancleRequest:(QNUpCancellationSignal)UpCancel success:(void (^)(NSArray *))success failure:(void (^)())failure{
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    __block CGFloat totalProgress = 0.0f;
    __block CGFloat partProgress = 1.0f / [imageArray count];
    __block NSUInteger currentIndex = 0;
    
    QiniuUploadHelper *uploadHelper = [QiniuUploadHelper sharedUploadHelper];
    __weak typeof(uploadHelper) weakHelper = uploadHelper;
    
    uploadHelper.singleFailureBlock = ^() {
        failure();
        return;
    };
    uploadHelper.singleSuccessBlock  = ^(NSString *url,NSInteger requestID) {
        [array addObject:url];
        totalProgress += partProgress;
        progress(totalProgress);
        currentIndex++;
        if ([array count] == [imageArray count]) {
            success([array copy]);
            return;
        }
        else {
            NSLog(@"---%ld",(unsigned long)currentIndex);
            if (currentIndex<imageArray.count) {
                
                [self uploadImage:imageArray[currentIndex] progress:nil cancleRequest:UpCancel success:weakHelper.singleSuccessBlock failure:weakHelper.singleFailureBlock];
            }
            
        }
    };
    
    [self uploadImage:imageArray[0] progress:nil cancleRequest:UpCancel success:weakHelper.singleSuccessBlock failure:weakHelper.singleFailureBlock];
}

-(NSMutableDictionary *)uploadDic{
    if (_uploadDic == nil) {
        _uploadDic = [[NSMutableDictionary alloc] init];
    }
    return _uploadDic;
}

//获取七牛的token
- (void)getQiniuUploadWithImages:(UIImage *)imageArray Token:(void (^)(NSDictionary *))success failure:(void (^)())failure {
    dispatch_group_t group = dispatch_group_create();
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(1);
    
    NSInteger requestID = arc4random() % 99999;
    NSMutableArray *fileArr = [NSMutableArray array];
//    for (UIImage *image in imageArray) {
        NSData *data = UIImageJPEGRepresentation(imageArray, 1.0);
        if (!data) {
            if (failure) {
                failure();
            }
        }
    NSString *dataStr = [data base64EncodedStringWithOptions:0];
    NSString * fileName = [NSString stringWithFormat:@"data:image/jpg;base64,%@",dataStr];
        [fileArr addObject:fileName];
//    }
    
    //网络请求七牛token
    NSString *url = @"/file/file/mobile/app/v1/qiniu/image/base64/upload";
    NSDictionary *dic = @{@"token":[UserCacheBean share].userInfo.token,@"appId":@"993335466657415169",@"base64String":fileName,@"timestamp":@"0",@"platform":@"ios"};
    [[ZSAPIProxy shareProxy] callPOSTWithUrl:url Params:dic isShowLoading:NO successCallBack:^(ZSURLResponse *response) {
        if ([response.content isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dicResponse = (NSDictionary *) response.content;
            if ([dicResponse[@"code"] integerValue] == 200) {
                
                success(dicResponse);
            }
        } else {
            failure();
        }
    } faildCallBack:^(ZSURLResponse *response) {
        failure();
    }];
}

-(BOOL)ISTokenEffective{
    if (_uploadDic.count >0) {
        if ([[_uploadDic objectForKey:@"expires"] integerValue] > [[self getNowTimeTimestamp] integerValue]) {
            return YES;
        }else{
            return NO;
        }
    }else{
        return NO;
    }
}

-(NSString *)getNowTimeTimestamp{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    //设置时区,这个对于时间的处理有时很重要
    
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    
    [formatter setTimeZone:timeZone];
    
    NSDate *datenow = [NSDate date];//现在时间,你可以输出来看下是什么格式
    
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970]];
    
    return timeSp;
    
}


//哈希
-(NSString *)hah1_imagewithData:(NSData *)imageData{
    
    //使用对应的CC_SHA1,CC_SHA256,CC_SHA384,CC_SHA512的长度分别是20,32,48,64
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    //使用对应的CC_SHA256,CC_SHA384,CC_SHA512
    CC_SHA1(imageData.bytes, imageData.length, digest);
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++){
        [output appendFormat:@"%02x", digest[i]];
    }
    // 哈希之后的截取前两位 为子目录的 文件夹名称
    return [NSString stringWithFormat:@"%@/%@",[output substringToIndex:2],output];
}

@end
