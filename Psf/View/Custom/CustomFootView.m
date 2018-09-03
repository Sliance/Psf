//
//  CustomFootView.m
//  Psf
//
//  Created by 燕来秋mac9 on 2018/9/3.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "CustomFootView.h"

@implementation CustomFootView

-(UIImageView *)headimage{
    if (!_headimage) {
        _headimage = [[UIImageView alloc]init];
        _headimage.image = [UIImage imageNamed:@"banquan_icon"];
    }
    return _headimage;
}
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = DSColorFromHex(0xF0F0F0);
        [self addSubview:self.headimage];
        [self.headimage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.centerY.equalTo(self);
        }];
    }
    return self;
}

@end
