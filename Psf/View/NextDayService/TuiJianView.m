//
//  TuiJianView.m
//  Psf
//
//  Created by 燕来秋mac9 on 2018/7/17.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "TuiJianView.h"

@implementation TuiJianView

-(instancetype)init{
    self = [super init];
    if (self) {
        [self addSubview:self.leftImage];
        [self addSubview:self.topImage];
        [self addSubview:self.bottomImage];
    }
    return self;
}

-(UIImageView *)leftImage{
    if (!_leftImage) {
        _leftImage = [[UIImageView alloc]init];
    }
    return _leftImage;
}
-(UIImageView *)topImage{
    if (!_topImage) {
        _topImage = [[UIImageView alloc]init];
    }
    return _topImage;
}
-(UIImageView *)bottomImage{
    if (!_bottomImage) {
        _bottomImage = [[UIImageView alloc]init];
    }
    return _bottomImage;
}
@end
