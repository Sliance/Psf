//
//  ShopAlertView.h
//  Psf
//
//  Created by 燕来秋mac9 on 2018/9/14.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "BaseView.h"
#import "ShoppingListRes.h"
@interface ShopAlertView : BaseView<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UIView *yinBgview;
@property(nonatomic,strong)UIView *bgView;
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UIButton *closeBtn;
@property(nonatomic,strong)UILabel *lineLabel;


@property(nonatomic,strong)UITableView *tableview;
@property(nonatomic,strong)ShoppingListRes *model;
@property(nonatomic,copy)void (^submitBlock)(NSArray*,NSString*);





@property(nonatomic,copy)void (^closeBlcok)(void);

@end
