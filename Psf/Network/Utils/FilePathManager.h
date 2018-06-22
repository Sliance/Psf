//
//  FilePathManager.h
//  StudyForStudent
//
//  Created by yons on 14-9-2.
//  Copyright (c) 2014年 yons. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface FilePathManager : NSObject
+ (NSString *)saveImageFile:(UIImage *)image toFolder:(NSString *)folder; //保存图片并得到图片路径
+ (NSString *)getDocumentPath:(NSString *)path; //得到图片文件路径
@end
