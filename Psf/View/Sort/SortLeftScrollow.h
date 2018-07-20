//
//  SortLeftScrollow.h
//  Psf
//
//  Created by 燕来秋mac9 on 2018/6/20.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StairCategoryRes.h"
#import "SortBtn.h"

@protocol SortLeftScrollowDelegate<NSObject>
-(void)selectedSortIndex:(NSInteger)index;

@end
@interface SortLeftScrollow : UIView

@property(nonatomic,strong)UIScrollView *bgScrollow;
@property(nonatomic,strong)NSMutableArray *dataArr;
@property(nonatomic,assign)id<SortLeftScrollowDelegate>delegate;
@property(nonatomic,strong)SortBtn *tmpBtn;

@end
