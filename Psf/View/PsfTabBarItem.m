//
//  PsfTabBarItem.m
//  Psf
//
//  Created by 燕来秋mac9 on 2018/6/14.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "PsfTabBarItem.h"

@implementation PsfTabBarItem

- (UIImage *)unselectedImage{
    return self.image;
}

//半透白框撑满，如不需请隐藏该方法
- (UIEdgeInsets)imageInsets{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}
@end
