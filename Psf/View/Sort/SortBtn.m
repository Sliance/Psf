//
//  SortBtn.m
//  Psf
//
//  Created by 燕来秋mac9 on 2018/6/20.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "SortBtn.h"
#import <Masonry.h>
@implementation SortBtn
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.selectedLabel];
        [self addSubview:self.sortLabel];
        
        [self.selectedLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self);
            make.width.mas_equalTo(2);
            make.height.mas_equalTo(24);
            make.centerY.equalTo(self);
        }];
        [self.sortLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.equalTo(self);
        }];
        
    }
    return self;
}
-(UILabel *)selectedLabel{
    if (!_selectedLabel) {
        _selectedLabel = [[UILabel alloc]init];
        _selectedLabel.backgroundColor =  [UIColor colorWithRed:235/255.0 green:90/255.0 blue:85/255.0 alpha:1];
        _selectedLabel.hidden = YES;
    }
    return _selectedLabel;
}
-(UILabel *)sortLabel{
    if (!_sortLabel) {
        _sortLabel = [[UILabel alloc]init];
        _sortLabel.text = @"水果";
        _sortLabel.textAlignment = NSTextAlignmentCenter;
        _sortLabel.font = [UIFont systemFontOfSize:14];
        _sortLabel.textColor = [UIColor colorWithRed:70.0001/255.0 green:70.0001/255.0 blue:70.0001/255.0 alpha:1];
    }
    return _sortLabel;
}

@end
