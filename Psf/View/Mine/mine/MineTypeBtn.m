//
//  MineTypeBtn.m
//  Psf
//
//  Created by 燕来秋mac9 on 2018/6/20.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "MineTypeBtn.h"
#import <Masonry.h>
@implementation MineTypeBtn

-(UILabel *)imageLabel{
    if (!_imageLabel) {
        _imageLabel = [[UILabel alloc]init];
        _imageLabel.font = [UIFont fontWithName:@"icomoon"size:32];
        
    }
    return _imageLabel;
}
-(UILabel *)typeLabel{
    if (!_typeLabel) {
        _typeLabel = [[UILabel alloc]init];
        _typeLabel.font = [UIFont systemFontOfSize:12];
        _typeLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _typeLabel;
}
-(UILabel *)countLabel{
    if (!_countLabel) {
        _countLabel = [[UILabel alloc]init];
        _countLabel.textColor = [UIColor whiteColor];
        _countLabel.font = [UIFont systemFontOfSize:12];
        [_countLabel.layer setMasksToBounds:YES];
        [_countLabel.layer setCornerRadius:8];
        _countLabel.textAlignment = NSTextAlignmentCenter;
        _countLabel.hidden = YES;
    }
    return _countLabel;
}
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setcornerLayout];
    }
    return self;
}
-(void)setcornerLayout{
    [self addSubview:self.imageLabel];
    [self.imageLabel addSubview:self.countLabel];
    [self addSubview:self.typeLabel];
    [self.imageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.centerX.equalTo(self);
        make.width.height.mas_equalTo(32);
    }];
    [self.typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imageLabel.mas_bottom).offset(3);
        make.left.right.equalTo(self);
    }];
    [self.countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(16);
        make.left.equalTo(self.imageLabel.mas_right).offset(-13);
        make.top.equalTo(self.imageLabel.mas_top).offset(-1);
    }];
}
@end
