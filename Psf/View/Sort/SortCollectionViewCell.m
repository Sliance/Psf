//
//  SortCollectionViewCell.m
//  Psf
//
//  Created by 燕来秋mac9 on 2018/6/20.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "SortCollectionViewCell.h"
#import <Masonry.h>

@implementation SortCollectionViewCell
-(UIImageView *)headImage{
    if (!_headImage) {
        _headImage = [[UIImageView alloc]init];
        _headImage.image = [UIImage imageNamed:@"banana_sort"];

    }
    return _headImage;
}
-(UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        _nameLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:14];
        _nameLabel.textColor = [UIColor colorWithRed:70.0001/255.0 green:70.0001/255.0 blue:70.0001/255.0 alpha:1];
        _nameLabel.text = @"香蕉";
    }
    return _nameLabel;
}
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.headImage];
        [self addSubview:self.nameLabel];
    }
    return self;
}
-(void)setImageHeight:(NSInteger )imageHeight{
    _imageHeight = imageHeight;
    [self.headImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self);
        make.width.height.mas_equalTo(imageHeight);
        
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headImage.mas_left);
        make.top.equalTo(self.headImage.mas_bottom);
        make.width.mas_equalTo(imageHeight);
        
    }];
}

@end
