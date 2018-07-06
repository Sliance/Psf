//
//  BottomView.m
//  Psf
//
//  Created by 燕来秋mac9 on 2018/6/25.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "BottomView.h"

@implementation BottomView

-(instancetype)init{
    if (self = [super init]) {
        self.backgroundColor = [UIColor whiteColor];
      
        [self addSubview:self.bottomBtn];
    }
    return self;
}

-(UIButton *)bottomBtn{
    if (!_bottomBtn) {
        _bottomBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_bottomBtn setBackgroundImage:[UIImage imageNamed:@"shopping_submit"] forState:UIControlStateNormal];
        _bottomBtn.frame = CGRectMake(15, 0, SCREENWIDTH-30, 39);
        [_bottomBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    return _bottomBtn;
}
@end
