//
//  DNCommentList.m
//  DnaerApp
//
//  Created by zhangshu on 2019/3/8.
//  Copyright © 2019 燕来秋. All rights reserved.
//

#import "DNCommentList.h"

@implementation DNCommentList
+ (NSDictionary *)objectClassInArray {
    return @{@"childComment":[DNCommentExtsReplysModel class],
             };
}
-(void)setCommentContent:(NSString *)commentContent{
    _commentContent = commentContent;
    UILabel *label = [[UILabel alloc]init];
    if (commentContent.length>0) {
        self.content_height = [label getHeightLineWithString:commentContent withWidth:SCREENWIDTH-116 withFont:[UIFont systemFontOfSize:13] lineSpacing:5];
    }else{
        self.content_height = 0;
    }
}

- (NSString *)headerFooterClassInTableViw:(UITableView *)tableView section:(NSInteger)section type:(CHGTableViewHeaderFooterViewType)type {

    return @"DNCommentHeadView";
}

- (CGFloat)headerFooterHeighInTableViw:(UITableView *)tableView section:(NSInteger)section type:(CHGTableViewHeaderFooterViewType)type {
    
    CGFloat headHeight = 30;
    headHeight += self.content_height;
    headHeight += 41;
    return headHeight;
}
- (NSString *)subDataKeyPathWithIndexPath:(NSIndexPath *)indexPath tableView:(UITableView *)tableView {
    return @"childComment";
}

@end
