//
//  FilePathManager.m
//  StudyForStudent
//
//  Created by yons on 14-9-2.
//  Copyright (c) 2014年 yons. All rights reserved.
//

#import "FilePathManager.h"

@implementation FilePathManager
+ (NSString *)getDocumentPath:(NSString *)path{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *document = [paths objectAtIndex:0];
    if (path.length == 0) {
        return document;
    }else{
        return [document stringByAppendingPathComponent:path];
    }
}

+ (NSString *)genUUID
{
    CFUUIDRef uuidRef = CFUUIDCreate(NULL);
    CFStringRef str = CFUUIDCreateString(NULL, uuidRef);
    NSString *tmp = (NSString *)CFBridgingRelease(str);
    CFRelease(uuidRef);
    return tmp;
}

+ (NSString *)saveImageFile:(UIImage *)image toFolder:(NSString *)folder
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSString *fileDocument = [self getDocumentPath:nil];
    NSString *userFolder = [fileDocument stringByAppendingPathComponent:folder];
    if (![fileManager fileExistsAtPath:userFolder]) {
        [fileManager createDirectoryAtPath:userFolder withIntermediateDirectories:NO attributes:nil error:nil];
    }
    NSString *uuidStr = [self genUUID];
    NSString *fileName = [folder stringByAppendingPathComponent:[uuidStr stringByAppendingPathExtension:@"jpg"]];
    
    NSString *imageFilePath = [fileDocument stringByAppendingPathComponent:fileName]; //得到当前照片的路径
    
    if ([UIImageJPEGRepresentation(image, 0.96) writeToFile:imageFilePath atomically:YES]) {
        //        NSLog(@"save bigImage yes");
    }else{
        //        NSLog(@"save bigImage wrong");
    }
    return fileName;
}

@end
