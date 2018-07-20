//
//  DetailSortHeadView.m
//  Psf
//
//  Created by 燕来秋mac9 on 2018/7/16.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "DetailSortHeadView.h"

@implementation DetailSortHeadView
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.titleLabel];
        [self addSubview:self.searchBtn];
    }
    
    return self;
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
        _searchBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, SCREENWIDTH/2+15);
        _searchBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, SCREENWIDTH/2);
        [_searchBtn.layer setCornerRadius:4];
        [_searchBtn.layer setMasksToBounds:YES];
        _searchBtn.frame = CGRectMake(15, 15, SCREENWIDTH-30, 36);
        [_searchBtn addTarget:self action:@selector(pressSearch) forControlEvents:UIControlEventTouchUpInside];
    }
    return _searchBtn;
}
-(UILabel *)titleLabel{
    if (!_titleLabel) {
       _titleLabel =  [[UILabel alloc]initWithFrame:CGRectMake(0, 51, SCREENWIDTH, 55)];
        _titleLabel.text = @"冷链配送，新鲜直达";
        _titleLabel.font = [UIFont systemFontOfSize:15];
        _titleLabel.textColor = DSColorFromHex(0x464646);
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}
-(void)pressSearch{
    self.searchBlock();
}
@end
