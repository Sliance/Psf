//
//  GetCouponsView.h
//  Psf
//
//  Created by 燕来秋mac9 on 2018/6/29.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "BaseView.h"
#import "MyCouponCell.h"
@protocol GetCouponsViewDelegate<NSObject>
-(void)finishCouponView;

-(void)getCouponViewWithIndex:(NSInteger)index;
@end
@interface GetCouponsView : BaseView<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UIView* topView;
@property(nonatomic,strong)UIView* bgView;
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)UIButton *finishBtn;
@property(nonatomic,weak)id<GetCouponsViewDelegate>delegate;
@property(nonatomic,strong)NSMutableArray *dataArr;

@end
