//
//  FillEvaluateReq.h
//  Psf
//
//  Created by 燕来秋mac9 on 2018/8/6.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FillEvaluateReq : NSObject
@property(nonatomic,strong)NSMutableArray *commentList;
///应用编号
@property(nonatomic,copy)NSString *appId;
///
@property(nonatomic,copy)NSString *token;
///客户端
@property(nonatomic,strong)NSString *platform;
///时间戳
@property(nonatomic,copy)NSString *timestamp;
@end
