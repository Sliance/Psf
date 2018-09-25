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
        [self addSubview:self.bgScrollow];
    }
    return self;
}
-(UIScrollView *)bgScrollow{
    if (!_bgScrollow) {
        _bgScrollow = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0,75, self.frame.size.height)];
        _bgScrollow.delegate = self;
        _bgScrollow.showsHorizontalScrollIndicator = NO;
        _bgScrollow.showsVerticalScrollIndicator = NO;
        _bgScrollow.backgroundColor = [UIColor colorWithRed:250/255.0 green:250/255.0 blue:250/255.0 alpha:1];
        
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
            _tmpBtn = btn;
        }else{
            btn.sortLabel.textColor = [UIColor colorWithRed:70.0001/255.0 green:70.0001/255.0 blue:70.0001/255.0 alpha:1];
            btn.backgroundColor = [UIColor colorWithRed:250/255.0 green:250/255.0 blue:250/255.0 alpha:1];
            btn.selectedLabel.hidden = YES;
            
        }
        [btn addTarget:self action:@selector(pressBtn:) forControlEvents:UIControlEventTouchUpInside];
//        StairCategoryRes*model =dataArr[i];
        btn.sortLabel.text = dataArr[i];
        btn.tag = i+100;
        [self.bgScrollow addSubview:btn];
        _bgScrollow.contentSize = CGSizeMake(0, 52*dataArr.count+10);
    }
}

-(void)pressBtn:(SortBtn*)sender{
//    for (int i = 0; i < _dataArr.count; i++) {
//        SortBtn *btn = (SortBtn *)[[sender superview]viewWithTag:100 + i];
//        btn.selectedLabel.hidden = YES;
//        btn.backgroundColor = [UIColor colorWithRed:250/255.0 green:250/255.0 blue:250/255.0 alpha:1];
//        btn.sortLabel.textColor = [UIColor colorWithRed:70.0001/255.0 green:70.0001/255.0 blue:70.0001/255.0 alpha:1];
//        [btn setSelected:NO];
//    }
    
    if (_tmpBtn == nil){
        sender.selected = YES;
        sender.selectedLabel.hidden = NO;
        sender.backgroundColor = [UIColor whiteColor];
        sender.sortLabel.textColor = [UIColor colorWithRed:235/255.0 green:90/255.0 blue:85/255.0 alpha:1];
        _tmpBtn = sender;
    }else if (_tmpBtn !=nil && _tmpBtn == sender){
        sender.selected = YES;
        sender.selectedLabel.hidden = NO;
        sender.backgroundColor = [UIColor whiteColor];
        sender.sortLabel.textColor = [UIColor colorWithRed:235/255.0 green:90/255.0 blue:85/255.0 alpha:1];
    }else if (_tmpBtn!= sender && _tmpBtn!=nil){
        _tmpBtn.selected = NO;
        _tmpBtn.selectedLabel.hidden = YES;
        _tmpBtn.sortLabel.textColor = [UIColor colorWithRed:70.0001/255.0 green:70.0001/255.0 blue:70.0001/255.0 alpha:1];
        _tmpBtn.backgroundColor = [UIColor colorWithRed:250/255.0 green:250/255.0 blue:250/255.0 alpha:1];
        sender.selected = YES;
        sender.selectedLabel.hidden = NO;
        sender.backgroundColor = [UIColor whiteColor];
        sender.sortLabel.textColor = [UIColor colorWithRed:235/255.0 green:90/255.0 blue:85/255.0 alpha:1];
        _tmpBtn = sender;
    }
    if ([self.delegate respondsToSelector:@selector(selectedSortIndex:)]) {
        [self.delegate selectedSortIndex:sender.tag-100];
    }
}
@end
