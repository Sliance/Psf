//
//  ZSSortSelectorView.h
//  ZSSortSelectorView
//
//  Created by 燕来秋mac9 on 2018/6/15.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZSSortSelectorView;

@protocol ZSSortSelectorViewDelegate <NSObject>
- (void)chooseButtonType:(NSInteger )type;
@end
@interface ZSSortSelectorView : UIView

@property (nonatomic, assign) id<ZSSortSelectorViewDelegate> delegate;
@property (nonatomic , strong) NSArray *dataArr;//数据源
@property(nonatomic,copy)void(^selectedBlock)(BOOL);

@property (nonatomic , strong) UIButton *rightBtn;
@property (nonatomic , assign) NSInteger currentPage;
@end
