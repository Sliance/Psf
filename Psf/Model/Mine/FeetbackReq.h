//
//  FeetbackReq.h
//  Psf
//
//  Created by 燕来秋mac9 on 2018/8/10.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FeetbackReq : NSObject
///(181)
@property(nonatomic,copy)NSString *erpStoreId;
///反馈类型
@property(nonatomic,copy)NSString *memberFeedbackType;
///反馈内容
@property(nonatomic,copy)NSString *memberFeedbackContent;
///反馈人手机号
@property(nonatomic,copy)NSString *memberFeedbackPhone;
///
@property(nonatomic,strong)NSArray *memberFeedbackImage;
///
@property(nonatomic,copy)NSString *appId;
///
@property(nonatomic,copy)NSString *token;
///
@property(nonatomic,copy)NSString *platform;
///
@property(nonatomic,copy)NSString *timestamp;

@end
