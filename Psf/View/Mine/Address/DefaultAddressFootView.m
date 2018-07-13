//
//  DefaultAddressFootView.m
//  Psf
//
//  Created by 燕来秋mac9 on 2018/6/26.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "DefaultAddressFootView.h"

@implementation DefaultAddressFootView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = DSColorFromHex(0xF0F0F0);
        self.userInteractionEnabled = YES;
        [self addSubview:self.morenBtn];
        [self.morenBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.top.equalTo(self).offset(10);
            make.bottom.equalTo(self);
        }];
    }
    return self;
}
-(UIButton *)morenBtn{
    if (!_morenBtn) {
        _morenBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_morenBtn setImage:[UIImage imageNamed:@"shopping_normal"] forState:UIControlStateNormal];
        [_morenBtn setImage:[UIImage imageNamed:@"shopping_selected"] forState:UIControlStateSelected];
        [_morenBtn setTitle:@"设为默认地址" forState:UIControlStateNormal];
        _morenBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        [_morenBtn setTitleColor:DSColorFromHex(0x454545) forState:UIControlStateNormal];
        _morenBtn.backgroundColor = [UIColor whiteColor];
        _morenBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -5, 0, 5);
        [_morenBtn addTarget:self action:@selector(pressMorenBtn:) forControlEvents:UIControlEventTouchUpInside];
       
    }
    return _morenBtn;
}
-(void)pressMorenBtn:(UIButton*)sender{
    sender.selected = !sender.selected;
    self.morenBlock(sender.selected);
}
@end
