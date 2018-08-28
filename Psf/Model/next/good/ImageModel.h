//
//  ImageModel.h
//  Psf
//
//  Created by 燕来秋mac9 on 2018/7/9.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImageModel : NSObject
@property(nonatomic,assign)NSInteger productImageId;
@property(nonatomic,copy)NSString* productImagePath;
@property(nonatomic,copy)NSString* saleOrderProductCommentImagePath;
@property(nonatomic,assign)NSInteger saleOrderProductCommentImageId;
///上传图片返回
@property(nonatomic,assign)NSInteger fileId;
@property(nonatomic,copy)NSString* fileOriginalPath;

///
@property(nonatomic,assign)NSInteger saleOrderRefundImageId;
@property(nonatomic,copy)NSString* saleOrderRefundImagePath;
@end
