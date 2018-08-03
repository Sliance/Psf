//
//  TourDiyGooddetailView.h
//  Psf
//
//  Created by 燕来秋mac9 on 2018/7/3.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "BaseView.h"
#import "SpellGroupModel.h"

@interface TourDiyGooddetailView : BaseView<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UILabel *headLabel;
@property(nonatomic,strong)UITableView *tableview;
@property(nonatomic,copy)void (^pressGoBlock)(NSInteger);

@property(nonatomic,strong)NSMutableArray *dataArr;

@end
