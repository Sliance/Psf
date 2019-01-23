//
//  RecipeBottomView.m
//  Psf
//
//  Created by zhangshu on 2019/1/21.
//  Copyright © 2019 zhangshu. All rights reserved.
//

#import "RecipeBottomView.h"

@implementation RecipeBottomView

-(UIButton *)collectBtn{
    if (!_collectBtn) {
        _collectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_collectBtn setImage:[UIImage imageNamed:@"collect_recipe"] forState:UIControlStateNormal];
        [_collectBtn setImage:[UIImage imageNamed:@"collect_recipe_selected"] forState:UIControlStateSelected];
        
        [_collectBtn setTitleColor:DSColorFromHex(0x707070) forState:UIControlStateNormal];
        [_collectBtn setTitleColor:DSColorFromHex(0xFF4C4D) forState:UIControlStateSelected];
        _collectBtn.titleLabel.font = [UIFont systemFontOfSize:10];
        _collectBtn.frame = CGRectMake(0, 0, SCREENWIDTH/4, 44);
        
    }
    return _collectBtn;
}
-(UIButton *)shareBtn{
    if (!_shareBtn) {
        _shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_shareBtn setImage:[UIImage imageNamed:@"share_recipe"] forState:UIControlStateNormal];
        [_shareBtn setImage:[UIImage imageNamed:@"share_recipe"] forState:UIControlStateSelected];
        
        [_shareBtn setTitleColor:DSColorFromHex(0x707070) forState:UIControlStateNormal];
        [_shareBtn setTitleColor:DSColorFromHex(0xFF4C4D) forState:UIControlStateSelected];
        _shareBtn.titleLabel.font = [UIFont systemFontOfSize:10];
        _shareBtn.frame = CGRectMake(SCREENWIDTH/4, 0, SCREENWIDTH/4, 44);
        
    }
    return _shareBtn;
}
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.collectBtn];
        [self addSubview:self.shareBtn];
    }
    return self;
}
@end
