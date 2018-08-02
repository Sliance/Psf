//
//  QiniuUploadHelper.h
//  SupplierApp
//
//  Created by 安天洋 on 2017/3/30.
//  Copyright © 2017年 liujianzhong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QiniuUploadHelper : NSObject


@property (copy, nonatomic) void (^singleSuccessBlock)(NSString *url,NSInteger requestID);
@property (copy, nonatomic)  void (^singleFailureBlock)();

+ (instancetype)sharedUploadHelper;
@end
