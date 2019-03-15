//
//  DNCommentExtsReplysModel.m
//  DnaerApp
//
//  Created by zhangshu on 2019/3/8.
//  Copyright © 2019 燕来秋. All rights reserved.
//

#import "DNCommentExtsReplysModel.h"

@implementation DNCommentExtsReplysModel

-(void)setCommentContent:(NSString *)commentContent{
    _commentContent = commentContent;
    UILabel *label = [[UILabel alloc]init];
    if (commentContent.length>0) {
        self.content_height = [label getHeightLineWithString:commentContent withWidth:SCREENWIDTH-116 withFont:[UIFont systemFontOfSize:13] lineSpacing:5];
    }else{
        self.content_height = 0;
    }
}

- (NSString *)cellClassNameInTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath {
    return @"DNFoundCommentCell";
}

-(CGFloat)cellHeighInTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath{
    DNCommentExtsReplysModel * commentDataModel = [tableView.tableViewAdapter cellDataWithIndexPath:indexPath tableView:tableView];
    return
    30
    +commentDataModel.content_height
    +41;
}



@end
