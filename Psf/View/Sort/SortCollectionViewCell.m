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
    }
    return _headImage;
}
-(UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        _nameLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:12];
        _nameLabel.textColor = DSColorFromHex(0x474747);
        _nameLabel.text = @"";
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
//        make.width.height.mas_equalTo(imageHeight);
        
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.headImage);
        make.top.equalTo(self.headImage.mas_bottom).mas_equalTo(14);
        make.width.mas_equalTo(imageHeight);
        
    }];
}
-(void)setModel:(StairCategoryRes *)model{
    _model = model;
    self.nameLabel.text = model.productCategoryName;
    NSString *url = [NSString stringWithFormat:@"%@%@",IMAGEHOST,model.productCategoryImagePath];
    [self.headImage sd_setImageWithURL:[NSURL URLWithString:url]];
    
}
-(void)setHomeBannermodel:(SubjectModel *)homeBannermodel{
    _homeBannermodel = homeBannermodel;
    self.nameLabel.text = homeBannermodel.subjectName;
    NSString *url = [NSString stringWithFormat:@"%@%@",IMAGEHOST,homeBannermodel.subjectTopImagePath];
    [self.headImage sd_setImageWithURL:[NSURL URLWithString:url]];
}
@end
