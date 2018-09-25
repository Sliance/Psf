//
//  HomeLocationView.m
//  Psf
//
//  Created by 燕来秋mac9 on 2018/6/19.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "HomeLocationView.h"

@implementation HomeLocationView

-(instancetype)init{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.locImg];
        [self addSubview:self.locBtn];
        [self addSubview:self.searchBtn];
        [self addSubview:self.lineLabel];
    }
    
    return self;
}
-(UIImageView *)locImg{
    if (!_locImg) {
        _locImg = [[UIImageView alloc]init];
        _locImg.image = [UIImage imageNamed:@"address_icon"];
        _locImg.frame = CGRectMake(10, 15, 13, 16);
    }
    return _locImg;
}
-(UIButton *)locBtn{
    if (!_locBtn) {
        _locBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _locBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_locBtn setTitleColor:DSColorFromHex(0x464646) forState:UIControlStateNormal];
        _locBtn.frame = CGRectMake(28, 0, 72, 45);
    }
    return _locBtn;
}
-(UIButton *)searchBtn{
    if (!_searchBtn) {
        _searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_searchBtn setImage:[UIImage imageNamed:@"search_icon"] forState:UIControlStateNormal];
        [_searchBtn setTitle:@"请输入商品名称" forState:UIControlStateNormal];
        _searchBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [_searchBtn setTitleColor:DSColorFromHex(0x787878) forState:UIControlStateNormal];
        _searchBtn.frame = CGRectMake(108, 5, SCREENWIDTH-119, 36);
        _searchBtn.backgroundColor = DSColorFromHex(0xF0F0F0);
        _searchBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, SCREENWIDTH/2-119/2);
        _searchBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, SCREENWIDTH/2-119/2-20);
        [_searchBtn.layer setCornerRadius:4];
        [_searchBtn.layer setMasksToBounds:YES];
    }
    return _searchBtn;
}
-(UILabel *)lineLabel{
    if (!_lineLabel ) {
        _lineLabel = [[UILabel alloc]init];
        _lineLabel.backgroundColor = DSColorFromHex(0xF0F0F0);
        _lineLabel.frame = CGRectMake(0, 44, SCREENWIDTH, 0.5);
    }
    return _lineLabel;
}

-(void)setStore:(NSString *)store{
    _store = store;
    if (store.length>0) {
        _locImg.hidden = YES;
        _searchBtn.frame = CGRectMake(15, 5, SCREENWIDTH-30, 36);
        _searchBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, SCREENWIDTH/2);
        _searchBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, SCREENWIDTH/2-20);
    }
}
@end
