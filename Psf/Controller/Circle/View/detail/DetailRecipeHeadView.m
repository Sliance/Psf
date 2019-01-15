//
//  DetailRecipeHeadView.m
//  Psf
//
//  Created by zhangshu on 2019/1/15.
//  Copyright © 2019 zhangshu. All rights reserved.
//

#import "DetailRecipeHeadView.h"

@implementation DetailRecipeHeadView

-(UIImageView *)headImage{
    if (!_headImage) {
        _headImage = [[UIImageView alloc]init];
    }
    return _headImage;
}
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textColor = DSColorFromHex(0x464646);
        _titleLabel.font = [UIFont boldSystemFontOfSize:16];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}
-(instancetype)initWithFrame:(CGRect)frame{
    self= [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.headImage];
        [self addSubview:self.titleLabel];
        [self.headImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(self);
            make.width.height.mas_equalTo(SCREENWIDTH);
        }];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.left.equalTo(self);
            make.top.equalTo(self.headImage.mas_bottom).offset(20);
        }];
    }
    return self;
}
-(void)setModel:(DetailRecipeRes *)model{
    _model = model;
    self.titleLabel.text = model.epicureName;
    NSString*url = [NSString stringWithFormat:@"%@%@",IMAGEHOST,model.epicureImgPath];
    [self.headImage sd_setImageWithURL:[NSURL URLWithString:url]];
}


@end

