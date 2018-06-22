//
//  ZSAPIProxy.h
//  Psf
//
//  Created by 燕来秋mac9 on 2018/6/21.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"
#import "FunctionMethodsUtil.h"
#import <AFNetworking/AFNetworking.h>
#import "ZSURLResponse.h"
/**
 用法：
 1， //拼接请求参数
 NSDictionary *param = [NSDictionary dictionary];
 2，调用Proxy发送服务
 NSInteger requestID = [[TYAPIProxy shareProxy] callGETWithParams:param identify:ApiArk methodName:@"trainTicketdetail" successCallBack:^(TYURLResponse *response) {
 3， //成功回调处理
 NSLog(@"%@",response.contentString);
 } faildCallBack:^(TYURLResponse *response) {
 4， //失败回调处理
 }];
 5， //取消上面的服务
 [[TYAPIProxy shareProxy] cancelRequestByRequestID:requestID];
 6， 取消所有TYAPIProxy的服务
 [[TYAPIProxy shareProxy] cancelAllRequest];
 */
typedef void (^callBackBlock) (ZSURLResponse *response);

@interface ZSAPIProxy : NSObject

//存放所有的服务请求ID
@property (nonatomic, strong) NSMutableDictionary *mapRequestList;
//请求ID（不重复）
@property (nonatomic, strong) NSNumber *requestID;
/**
 请求服务的nameger，用来发送服务，和接受反回
 */
@property (nonatomic, strong) AFHTTPSessionManager *requestOperationManager;

//转过菊花的viewcontroller都存放到这个数组，以便后面取消转菊花
@property (nonatomic, strong) NSMutableArray *arrayLodingControllers;

+ (instancetype)shareProxy;

/**
 GET请求
 参数：
 params：服务所需要的参数，不包括公共参数和签名参数
 identify:服务的baseURL，定义在TYconfig.h中
 methodName:请求的方法名，注意：这个参数是baseURL和?之间的部分，可能是"requestUserName"，也可能是"10086/train/tieyou/getTrainList"
 successCallBack:成功回调
 faildCallBack：失败回调
 */
- (NSInteger)callGETWithUrl:(NSString *)url Params:(NSDictionary *)params isShowLoading:(BOOL)isShow successCallBack:(callBackBlock) success faildCallBack:(callBackBlock) fail;

/**
 POST请求
 参数：
 params：服务所需要的参数，不包括公共参数和签名参数
 identify:服务的baseURL，定义在TYconfig.h中
 methodName:请求的方法名，注意：这个参数是baseURL和?之间的部分，可能是"requestUserName"，也可能是"10086/train/tieyou/getTrainList"
 successCallBack:成功回调
 faildCallBack：失败回调
 */
- (NSInteger)callPOSTWithUrl:(NSString *)url Params:(NSDictionary *)params isShowLoading:(BOOL)isShow successCallBack:(callBackBlock) success faildCallBack:(callBackBlock)fail;

/**
 下载文件
 
 @param url 网络请求地址
 @param isShow 是否显示Loding 动画
 @param success 请求成功
 @param fail 请求失败
 @return 返回
 */
- (NSInteger)callDownloadFileWithUrl:(NSString *)url isShowLoading:(BOOL)isShow successCallBack:(callBackBlock) success faildCallBack:(callBackBlock)fail;

/**返回网络状态*/
- (NSString *)getNetworkingStatus;

/**
 取消指定ID的请求
 */
- (void)cancelRequestByRequestID:(NSInteger) identify;

/**
 取消所有的服务请求
 */
- (void)cancelAllRequest;
@end
