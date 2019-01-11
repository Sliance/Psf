//
//  CircleNavView.m
//  Ypc
//
//  Created by zhangshu on 2019/1/8.
//  Copyright © 2019 zhangshu. All rights reserved.
//

#import "CircleNavView.h"

@implementation CircleNavView

-(ZSSortSelectorView *)selectorView{
    if (!_selectorView) {
        _selectorView = [[ZSSortSelectorView alloc]initWithFrame:CGRectMake(0,  NavitionbarHeight-44, SCREENWIDTH, 40)];
        _selectorView.backgroundColor = [UIColor whiteColor];
        _selectorView.rightBtn.hidden = YES;
        [_selectorView setIsShow:YES];
        [_selectorView setCurrentPage:0];
    }
    return _selectorView;
}
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.selectorView];
    }
    return self;
}

@end
