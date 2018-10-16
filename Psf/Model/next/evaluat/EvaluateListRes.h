//
//  EvaluateListRes.h
//  Psf
//
//  Created by 燕来秋mac9 on 2018/7/10.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EvaluateListRes : NSObject
@property(nonatomic,copy)NSString *rate;
@property(nonatomic,strong)NSArray *saleOrderProductCommentList;
@property(nonatomic,assign)NSInteger total;
@end
