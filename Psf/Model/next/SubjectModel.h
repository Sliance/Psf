//
//  SubjectModel.h
//  Psf
//
//  Created by 燕来秋mac9 on 2018/7/17.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SubjectModel : NSObject
///
@property(nonatomic,assign)NSInteger subjectId;
///
@property(nonatomic,copy)NSString *subjectImagePath;
///
@property(nonatomic,copy)NSString *subjectName;
///
@property(nonatomic,copy)NSString *subjectTopImagePath;
@end
