//
//  AgentImageBaseModel.h
//  AgentApp
//
//  Created by 安天洋 on 2017/4/24.
//  Copyright © 2017年 liujianzhong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MJExtension.h"

@interface AgentImageBaseModel : NSObject

@property (nonatomic, strong) NSNumber *id; // 后台返回的该张张片的ID
@property (nonatomic, strong) NSString *large; //后台返回的该张照片的大图URL
@property (nonatomic, strong) NSString *thumb; //后台返回的该张照片的缩略图URL
@property (nonatomic, strong) NSString *url;   // 后台返回的或者是上传成功之后写入的图片的URL
@property (nonatomic, strong) UIImage  *image; // 本地写入的待上传的图片文件
@property (nonatomic, strong) NSData   * imageData; //本地缓存的图片原数据
@property (nonatomic, strong) id asset;              // 图片的本地数据
@property (nonatomic, strong) NSNumber * imageRequestId; // 网络请求的ID
@property(nonatomic,strong)NSString *base64String;//base64
@end
