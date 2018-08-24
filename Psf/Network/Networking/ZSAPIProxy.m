//
//  ZSAPIProxy.m
//  Psf
//
//  Created by 燕来秋mac9 on 2018/6/21.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "ZSAPIProxy.h"
#import "ZSRequestGenerator.h"
#import "ZSURLResponse.h"
#import "FilePathManager.h"
#import "UIViewController+Loading.h"
#import "FunctionMethodsUtil.h"
#import "NSString+Cache.h"
#import "NSString+CLTools.h"
#import "CLNetworking.h"
#import "CLNetworkingManager.h"
#import "DeviceModel.h"
#import "ZSConfig.h"
#import "PsfTabBarController.h"

typedef NS_ENUM(NSInteger, NetworkRequestType) {
    NetworkRequestTypeGET,  // GET请求
    NetworkRequestTypePOST,  // POST请求
};
@implementation ZSAPIProxy
#pragma mark - getter && setter
- (NSMutableDictionary *)mapRequestList {
    if (_mapRequestList == nil) {
        _mapRequestList = [NSMutableDictionary dictionary];
    }
    return _mapRequestList;
}

- (NSMutableArray *)arrayLodingControllers {
    if (_arrayLodingControllers == nil) {
        return [NSMutableArray array];
    }
    return _arrayLodingControllers;
}

- (AFHTTPSessionManager *)requestOperationManager {
    if (_requestOperationManager == nil) {
        _requestOperationManager = [[AFHTTPSessionManager alloc] init];
    }
    return _requestOperationManager;
}

- (NSNumber *)generateRequestId
{
    if (_requestID == nil) {
        _requestID = @(1);
    } else {
        if ([_requestID integerValue] == NSIntegerMax) {
            _requestID = @(1);
        } else {
            _requestID = @([_requestID integerValue] + 1);
        }
    }
    return _requestID;
}

#pragma mark - mainMethods

+ (instancetype)shareProxy {
    static ZSAPIProxy *proxy = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (proxy == nil) {
            proxy = [[ZSAPIProxy alloc] init];
            proxy.arrayLodingControllers = [NSMutableArray array];
        }
    });
    return proxy;
}
// 读取保存到本地的 Api
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

/**
 GET请求
 */
- (NSInteger)callGETWithUrl:(NSString *)url Params:(NSDictionary *)params isShowLoading:(BOOL)isShow successCallBack:(callBackBlock) success faildCallBack:(callBackBlock) fail {
    
    NSString * urlStr = [[ZSRequestGenerator shareInstance] generateNetWorkingRequestURLWithServiceUrl:url requestParams:params];
    return [self requestType:NetworkRequestTypeGET url:urlStr parameters:nil isShowLoading:isShow cacheTime:0.5 succeed:success fail:fail];
}

/**
 POST 请求
 */
- (NSInteger)callPOSTWithUrl:(NSString *)url Params:(NSDictionary *)params isShowLoading:(BOOL)isShow successCallBack:(callBackBlock) success faildCallBack:(callBackBlock)fail{
    NSString * spiStr = [self supplierApiStr];
    NSString *urlString = [NSString stringWithFormat:@"%@%@",spiStr, url];
    urlString =  [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    //    NSString * urlStr =[[DSRequestGenerator shareInstance] generateNetWorkingRequestURLWithServiceUrl:url requestParams:params];
//    NSDictionary * paraDic = [[ZSRequestGenerator shareInstance] generateNetWorkingRequestParamsWithServiceUrl:url requestParams:params];
   
    return [self requestType:NetworkRequestTypePOST url:urlString parameters:params
               isShowLoading:isShow cacheTime:0.5 succeed:success fail:fail];
}

// 文件下载
- (NSInteger)callDownloadFileWithUrl:(NSString *)url isShowLoading:(BOOL)isShow successCallBack:(callBackBlock) success faildCallBack:(callBackBlock)fail{
    if (isShow == YES) {
        [self showLoading];
    }
    NSNumber *requestID = [self generateRequestId];
    NSURLRequest *request=[NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error ) {
        [self hiddenLoading];
        //        NSLog(@"%@",data);
        id responseData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:NULL];
        
        if (data) {
            //            UIImage *image = [UIImage imageWithData:data];
            if (success != nil) {
                ZSURLResponse *response = [[ZSURLResponse alloc] initWithResponseString:nil
                                                                              requestId:requestID
                                                                                request:request
                                                                           responseData:data
                                                                                 status:ResponseStatusSuccess];
                response.value = data;
                success(response);
            }
        } else {
            NSLog(@"%@",error);
            if (fail != nil) {
                ZSURLResponse *response = [[ZSURLResponse alloc] initWithResponseString:nil
                                                                              requestId:requestID
                                                                                request:request
                                                                           responseData:data
                                                                                 status:ResponseStatusErrorFail];
                fail(response);
            }
        }
    }];
    return [requestID integerValue];
}


#pragma mark -- 网络请求 --
/**
 *  网络请求
 *
 *  @param type       请求类型，get请求/Post请求
 *  @param urlString  请求地址字符串
 *  @param parameters 请求参数
 *  @param isCache    是否缓存
 *  @param time       缓存时间
 *  @param succeed    请求成功回调
 *  @param fail       请求失败回调
 */
- (NSInteger)requestType:(NetworkRequestType)type
                     url:(NSString *)urlString
              parameters:(id)parameters
           isShowLoading:(BOOL)isShow
               cacheTime:(float)time
                 succeed:(callBackBlock)succeed
                    fail:(callBackBlock)fail{
    
    if (isShow == YES) {
        [self showLoading];
    }
    NSURLSessionDataTask * sessionTask;
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    ///入参转json格式
     manager.requestSerializer = [AFJSONRequestSerializer serializer];
    //请求头
    NSString *requestHeader = [self commonHeader];
    [manager.requestSerializer setValue:requestHeader forHTTPHeaderField:@"User-Agent"];
    //
    NSNumber *requestID = [self generateRequestId];
    //
    if (type == NetworkRequestTypeGET) {
        // GET请求
        NSURLRequest *request =  [[AFHTTPRequestSerializer serializer] requestWithMethod:@"GET" URLString:urlString parameters:nil error:NULL];
        sessionTask = [manager GET:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            
            NSURLSessionDataTask * storeGettask = self.mapRequestList[requestID];
            if (storeGettask == nil) {
                return ;
            } else {
                [self.mapRequestList removeObjectForKey:requestID];
            }
            if (isShow == YES) {
                [self hiddenLoading];
            }
            [FunctionMethodsUtil doLoginCheckWithData:responseObject isShow:isShow];
            // 请求成功，加入缓存，解析数据
            ZSURLResponse *response = [[ZSURLResponse
                                        alloc] initWithResponseString:[NSString stringWithDate:responseObject]
                                                                          requestId:requestID
                                                                            request:request
                                                                       responseData:responseObject
                                                                             status:ResponseStatusSuccess];
            if (succeed) {
                succeed(response);
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"%@", error);
            [self hiddenLoading];
            if (isShow == YES) {
//                [self showInfo:@"网络连接失败,请重试"];
            }
            if (fail) {
                succeed(nil);
            }
            NSURLSessionDataTask * storeGettask = self.mapRequestList[requestID];
            if (storeGettask == nil) {
                return ;
            } else {
                [self.mapRequestList removeObjectForKey:requestID];
            }
        }];
    }else{
        NSURLRequest *request = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"POST" URLString:urlString parameters:parameters error:NULL];
        // POST请求
        sessionTask = [manager POST:urlString parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
            // 请求的进度
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if (isShow == YES) {
                [self hiddenLoading];
            }
            NSURLSessionDataTask * storeGettask = self.mapRequestList[requestID];
            if (storeGettask == nil) {
                return ;
            } else {
                [self.mapRequestList removeObjectForKey:requestID];
            }
            [FunctionMethodsUtil doLoginCheckWithData:responseObject isShow:isShow];
            // 请求成功，加入缓存，解析数据
            ZSURLResponse *response = [[ZSURLResponse alloc] initWithResponseString:[NSString stringWithDate:responseObject]
                                                                          requestId:requestID
                                                                            request:request
                                                                       responseData:responseObject
                                                                             status:ResponseStatusSuccess];
            if (succeed) {
                succeed(response);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"%@", error);
            [self hiddenLoading];
            if (isShow == YES) {
//                [self showInfo:@"网络连接失败,请重试"];
            }
            if (fail) {
                succeed(nil);
            }
            NSURLSessionDataTask * storeGettask = self.mapRequestList[requestID];
            if (storeGettask == nil) {
                return ;
            } else {
                [self.mapRequestList removeObjectForKey:requestID];
            }
        }];
    }
    self.mapRequestList[requestID] = sessionTask;
    return [requestID integerValue];
}

- (void)cancelRequestByRequestID:(NSInteger) identify {
    NSNumber *requestID = [NSNumber numberWithInteger:identify];
    NSURLSessionDataTask * sessionTask = self.mapRequestList[requestID];
    [sessionTask cancel];
    [self.mapRequestList removeObjectForKey:requestID];
}

- (void)cancelAllRequest{
    NSArray *arrayRequestKey = [self.mapRequestList allKeys];
    [arrayRequestKey enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSURLSessionDataTask * sessionTask = self.mapRequestList[obj];
        [sessionTask cancel];
        [self.mapRequestList removeObjectForKey:obj];
    }];
}

- (void)showLoading {
    UIViewController *viewController = [FunctionMethodsUtil getCurrentRootViewController];
    if (viewController == nil || ![viewController isKindOfClass:[UIViewController class]])
    {
        return;
    }
    if ([viewController isKindOfClass:[PsfTabBarController class]]) {
        PsfTabBarController *tabbar = (PsfTabBarController *)viewController;
        if ([tabbar.selectedViewController isKindOfClass:[UINavigationController class]]) {
            UINavigationController *nav = (UINavigationController *)tabbar.selectedViewController;
            [self.arrayLodingControllers addObjectsFromArray:nav.viewControllers];
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUDForView:nav.visibleViewController.view animated:NO];
                [MBProgressHUD showHUDAddedTo:nav.visibleViewController.view animated:YES];
            });
        }
    } else {
        [self.arrayLodingControllers addObject:viewController];
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD showHUDAddedTo:viewController.view animated:YES];
        });
    }
}

- (void)hiddenLoading {
    UIViewController *controller = [FunctionMethodsUtil getCurrentRootViewController];
    if ([controller isKindOfClass:[PsfTabBarController class]]) {
        PsfTabBarController *tabbar = (PsfTabBarController *)controller;
        if ([tabbar.selectedViewController isKindOfClass:[UINavigationController class]]) {
            UINavigationController *nav = (UINavigationController *)tabbar.selectedViewController;
            [self.arrayLodingControllers addObjectsFromArray:nav.viewControllers];
            dispatch_async(dispatch_get_main_queue(), ^{
                for (UIViewController *controller in self.arrayLodingControllers) {
                    [MBProgressHUD hideHUDForView:controller.view animated:YES];
                }
                [self.arrayLodingControllers removeAllObjects];
            });
            if ([nav presentedViewController]) {
                UIViewController *presentedVC = [nav presentedViewController];
                if ([presentedVC isKindOfClass:[UINavigationController class]]) {
                    [self.arrayLodingControllers addObjectsFromArray:[(UINavigationController *)presentedVC viewControllers]];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        for (UIViewController *controller in self.arrayLodingControllers) {
                            [MBProgressHUD hideHUDForView:controller.view animated:YES];
                        }
                        [self.arrayLodingControllers removeAllObjects];
                    });
                }
            }
        }
    } else {
        if(controller != nil) {
            [self.arrayLodingControllers addObject:controller];
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUDForView:controller.view animated:YES];
            });
        }
    }
    //    [self.arrayLodingControllers removeAllObjects];
}

//- (void)showLoading {
//    UIViewController *viewController = [FunctionMethodsUtil getCurrentRootViewController];
//    if (viewController == nil && ![viewController isKindOfClass:[UIViewController class]])
//    {
//        return;
//    }
//    [self.arrayLodingControllers addObject:viewController];
//    dispatch_async(dispatch_get_main_queue(), ^{
//        [MBProgressHUD showHUDAddedTo:viewController.view animated:YES];
//    });
//}
//
//- (void)hiddenLoading {
//
//    for (UIViewController *controller in self.arrayLodingControllers) {
//        [MBProgressHUD hideHUDForView:controller.view animated:YES];
//    }
//    UIViewController *controller = [FunctionMethodsUtil getCurrentRootViewController];
//    [MBProgressHUD hideHUDForView:controller.view animated:YES];
//    [self.arrayLodingControllers removeAllObjects];
//}

- (void)showInfo:(NSString *) info {
    if ([FunctionMethodsUtil getCurrentRootViewController] != nil) {
        UIViewController *controller = [FunctionMethodsUtil getCurrentRootViewController];
        [controller showInfo:info];
    }
}

- (NSString *)getNetworkingStatus {
    NSString *networkStatus = [[AFNetworkReachabilityManager sharedManager] localizedNetworkReachabilityStatusString];
    if ([networkStatus rangeOfString:@"WiFi"].length > 0) {
        return @"WiFi";
    } else if ([networkStatus rangeOfString:@"WWAN"].length > 0) {
        return @"2G/3G";
    } else {
        return @"unknow";
    }
}

#pragma mark -- 缓存处理 --
/**
 *  缓存文件夹下某地址的文件名，及UserDefaulets中的key值
 *
 *  @param urlString 请求地址
 *  @param params    请求参数
 *
 *  @return 返回一个MD5加密后的字符串
 */
- (NSString *)cacheKey:(NSString *)urlString params:(id)params{
    NSString *absoluteURL = [NSString generateGETAbsoluteURL:urlString params:params];
    NSString *key = [NSString networkingUrlString_md5:absoluteURL];
    return key;
}

//单个文件的大小
- (long long)fileSizeAtPath:(NSString*)filePath{
    NSFileManager* manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]){
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    return 0;
}


/**
 *  判断文件是否已经存在，若存在删除
 *
 *  @param path 文件路径
 */
- (void)deleteFileWithPath:(NSString *)path
{
    NSURL *url = [NSURL fileURLWithPath:path];
    NSFileManager *fm = [NSFileManager defaultManager];
    BOOL exist = [fm fileExistsAtPath:url.path];
    NSError *err;
    if (exist) {
        [fm removeItemAtURL:url error:&err];
        NetworkLog(@"file deleted success");
        if (err) {
            NetworkLog(@"file remove error, %@", err.localizedDescription );
        }
    } else {
        NetworkLog(@"no file by that name");
    }
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


#pragma maik - utilMehods

@end
