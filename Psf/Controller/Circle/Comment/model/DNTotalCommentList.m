//
//  DNTotalCommentList.m
//  DnaerApp
//
//  Created by zhangshu on 2019/3/12.
//  Copyright © 2019 燕来秋. All rights reserved.
//

#import "DNTotalCommentList.h"
#import "DNCommentList.h"

@implementation DNTotalCommentList
+ (NSDictionary *)objectClassInArray {
    return @{@"list":[DNCommentList class],
             };
}
@end
