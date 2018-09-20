//
//  CardHeadView.m
//  Psf
//
//  Created by 燕来秋mac9 on 2018/9/20.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "CardHeadView.h"
#import "CreatQRCodeAndBarCodeFromLeon.h"

@implementation CardHeadView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.headImge];
        [self.headImge mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(self);
        }];
    }
    return self;
}
-(UIImageView *)headImge{
    if (!_headImge) {
        _headImge = [[UIImageView alloc]init];
        _headImge.image = [UIImage imageNamed:@"huiyuan_bg_mine"];
    }
    return _headImge;
}











@end
