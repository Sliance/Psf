//
//  FeedbackTypeView.h
//  Psf
//
//  Created by 燕来秋mac9 on 2018/8/10.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "BaseView.h"

@interface FeedbackTypeView : BaseView<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UIView *yinBGview;
@property(nonatomic,assign)NSInteger height;
@property(nonatomic,assign)NSInteger index;
@property(nonatomic,strong)UITableView *tableview;
@property(nonatomic,strong)NSArray *dataArr;

@property(nonatomic,copy)void (^selectedBlock)(NSInteger,NSString*);
@property(nonatomic,copy)void (^yinBlock)();

@end
