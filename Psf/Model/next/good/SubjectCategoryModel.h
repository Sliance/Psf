//
//  SubjectCategoryModel.h
//  Psf
//
//  Created by 燕来秋mac9 on 2018/7/18.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SubjectCategoryModel : NSObject
///
@property(nonatomic,copy)NSNumber *subjectCategoryImageId;
///
@property(nonatomic,copy)NSString *subjectCategoryImagePath;
///
@property(nonatomic,copy)NSString *subjectCategoryName;
///
@property(nonatomic,copy)NSArray *subjectCategoryProductList;

@end
