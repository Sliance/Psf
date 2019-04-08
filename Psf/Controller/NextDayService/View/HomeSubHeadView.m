//
//  HomeSubHeadView.m
//  Psf
//
//  Created by zhangshu on 2018/12/20.
//  Copyright © 2018 zhangshu. All rights reserved.
//

#import "HomeSubHeadView.h"

@implementation HomeSubHeadView

-(UIImageView *)headimage{
    if (!_headimage) {
        _headimage = [[UIImageView alloc]init];
        [_headimage.layer setCornerRadius:6];
        [_headimage.layer setMasksToBounds:YES];
    }
    return _headimage;
}
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = [UIFont boldSystemFontOfSize:18];
        _titleLabel.textColor = DSColorFromHex(0x464646);
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.headimage];
        [self addSubview:self.titleLabel];
        [self.headimage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(15);
            make.right.equalTo(self).offset(-15);
            make.top.equalTo(self).offset(0);
            make.height.mas_equalTo(120*SCREENWIDTH/375);
        }];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.top.equalTo(self.headimage.mas_bottom).offset(15);
        }];
    }
    return self;
}
-(void)setModel:(SubjectCategoryModel *)model{
    _model = model;
    NSString*url = [NSString stringWithFormat:@"%@%@",IMAGEHOST,model.subjectCategoryImagePath];
    [self.headimage sd_setImageWithURL:[NSURL URLWithString:url]];
    self.titleLabel.text = model.subjectCategoryName;
}

-(void)setTitle:(NSString *)title{
    _title = title;
    self.titleLabel.text = title;
    [self.headimage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15);
        make.right.equalTo(self).offset(-15);
        make.top.equalTo(self).offset(0);
        make.height.mas_equalTo(0);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self);
    }];
}
@end
