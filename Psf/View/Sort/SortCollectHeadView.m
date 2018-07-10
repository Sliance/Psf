//
//  SortCollectHeadView.m
//  Psf
//
//  Created by 燕来秋mac9 on 2018/6/20.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "SortCollectHeadView.h"

@implementation SortCollectHeadView
-(UIImageView *)headImage{
if (!_headImage) {
    _headImage = [[UIImageView alloc]init];
    _headImage.image = [UIImage imageNamed:@"banner_sort"];
    [_headImage.layer setMasksToBounds:YES];
    [_headImage.layer setCornerRadius:4];
    
}
return _headImage;
}
-(UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        _nameLabel.font = [UIFont systemFontOfSize:12];
        _nameLabel.textColor = [UIColor colorWithRed:70.0001/255.0 green:70.0001/255.0 blue:70.0001/255.0 alpha:1];
    }
    return _nameLabel;
}
-(UILabel *)lineLabel{
    if (!_lineLabel) {
        _lineLabel = [[UILabel alloc]init];
        _lineLabel.backgroundColor =  [UIColor colorWithRed:110/255.0 green:110/255.0 blue:110/255.0 alpha:0.3];
    }
    return _lineLabel;
}
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setCornerLayout];
    }
    return self;
}
-(void)setCornerLayout{
    [self addSubview:self.headImage];
    [self addSubview:self.nameLabel];
    [self addSubview:self.lineLabel];
    [self.headImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(270);
        make.height.mas_equalTo(90);
        make.top.equalTo(self).offset(16);
        make.centerX.equalTo(self);
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
      make.top.equalTo(self.headImage.mas_bottom).offset(20);
    }];
    [self.lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameLabel.mas_bottom).offset(10);
        make.width.mas_equalTo(150);
        make.height.mas_equalTo(0.5);
        make.centerX.equalTo(self.nameLabel);
    }];
}
@end
