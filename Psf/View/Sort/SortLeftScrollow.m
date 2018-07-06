//
//  SortLeftScrollow.m
//  Psf
//
//  Created by 燕来秋mac9 on 2018/6/20.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "SortLeftScrollow.h"
#import "SortBtn.h"
@interface SortLeftScrollow()<UIScrollViewDelegate>

@end
@implementation SortLeftScrollow

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:_bgScrollow];
    }
    return self;
}
-(UIScrollView *)bgScrollow{
    if (!_bgScrollow) {
        _bgScrollow = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0,75, self.frame.size.height)];
        _bgScrollow.delegate = self;
        
        
    }
    return _bgScrollow;
}
-(void)setDataArr:(NSMutableArray *)dataArr{
    _dataArr = dataArr;
    for (int i = 0; i < dataArr.count; i++) {
       SortBtn* btn = [[SortBtn alloc]initWithFrame:CGRectMake( 0, 52*i, 75, 52)];
        if (i ==0) {
            btn.selectedLabel.hidden = NO;
            btn.backgroundColor = [UIColor whiteColor];
            btn.sortLabel.textColor = [UIColor colorWithRed:235/255.0 green:90/255.0 blue:85/255.0 alpha:1];
            [btn setSelected:YES];
        }else{
            btn.sortLabel.textColor = [UIColor colorWithRed:70.0001/255.0 green:70.0001/255.0 blue:70.0001/255.0 alpha:1];
            btn.backgroundColor = [UIColor colorWithRed:250/255.0 green:250/255.0 blue:250/255.0 alpha:1];
            btn.selected = NO;
        }
        [btn addTarget:self action:@selector(pressBtn:) forControlEvents:UIControlEventTouchUpInside];
        StairCategoryRes*model =dataArr[i];
        btn.sortLabel.text = model.productCategoryName;
        btn.tag = i+100;
        [self addSubview:btn];
    }
}
-(void)pressBtn:(SortBtn*)sender{
    for (int i = 0; i < _dataArr.count; i++) {
        SortBtn *btn = (SortBtn *)[[sender superview]viewWithTag:100 + i];
        btn.selectedLabel.hidden = YES;
        btn.backgroundColor = [UIColor colorWithRed:250/255.0 green:250/255.0 blue:250/255.0 alpha:1];
        btn.sortLabel.textColor = [UIColor colorWithRed:70.0001/255.0 green:70.0001/255.0 blue:70.0001/255.0 alpha:1];
        [btn setSelected:NO];
    }
    SortBtn *button = (SortBtn *)sender;
    button.selectedLabel.hidden = NO;
    button.backgroundColor = [UIColor whiteColor];
    
    button.sortLabel.textColor = [UIColor colorWithRed:235/255.0 green:90/255.0 blue:85/255.0 alpha:1];
    [button setSelected:YES];
    if ([self.delegate respondsToSelector:@selector(selectedSortIndex:)]) {
        [self.delegate selectedSortIndex:sender.tag-100];
    }
}
@end
