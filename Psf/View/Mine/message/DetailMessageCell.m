//
//  DetailMessageCell.m
//  Psf
//
//  Created by 燕来秋mac9 on 2018/7/4.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "DetailMessageCell.h"

@implementation DetailMessageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = DSColorFromHex(0xF0F0F0);
        [self addSubview:self.topLabel];
        [self addSubview:self.bgview];
        [self.bgview addSubview:self.titleLabel];
        [self.bgview addSubview:self.contentLabel];
        [self.bgview addSubview:self.rightImage];
        [self.topLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.equalTo(self);
            make.height.mas_equalTo(40);
        }];
        [self.bgview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.topLabel.mas_bottom);
            make.bottom.equalTo(self);
            make.left.equalTo(self).offset(15);
            make.right.equalTo(self).offset(-15);
        }];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.bgview).offset(14);
            make.left.equalTo(self.bgview).offset(15);
            make.right.equalTo(self.bgview).offset(-15);
        }];
        [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.titleLabel.mas_bottom).offset(10);
            make.left.equalTo(self.bgview).offset(15);
            make.right.equalTo(self.bgview).offset(-43);
        }];
        [self.rightImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.bgview);
            make.right.equalTo(self.bgview).offset(-15);
            make.width.mas_equalTo(7);
            make.height.mas_equalTo(12);
        }];
    }
    return self;
}
-(UIImageView *)rightImage{
    if (!_rightImage) {
        _rightImage = [[UIImageView alloc]init];
        _rightImage.image = [UIImage imageNamed:@"icon_right"];
    }
    return _rightImage;
}
-(UILabel *)topLabel{
    if (!_topLabel) {
        _topLabel = [[UILabel alloc]init];
        _topLabel.textAlignment = NSTextAlignmentCenter;
        _topLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:10];
        _topLabel.textColor = DSColorFromHex(0xB5B5B5);
        _topLabel.text = @"昨天 12:00";
    }
    return _topLabel;
}
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:18];
        _titleLabel.textColor = DSColorFromHex(0x454545);
        _titleLabel.text = @"【有奖调研】您对犁小农还满意吗？";
    }
    return _titleLabel;
}
-(UILabel *)contentLabel{
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc]init];
        _contentLabel.textAlignment = NSTextAlignmentLeft;
        _contentLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:15];
        _contentLabel.textColor = DSColorFromHex(0x787878);
        _contentLabel.text = @"最近您对犁小农的印象如何？参与调研可获得奖励";
        _contentLabel.numberOfLines = 2;
    }
    return _contentLabel;
}
-(UIView *)bgview{
    if (!_bgview) {
        _bgview = [[UIView alloc]init];
        _bgview.backgroundColor = [UIColor whiteColor];
        [_bgview.layer setMasksToBounds:YES];
        [_bgview.layer setCornerRadius:2];
    }
    return _bgview;
}
@end
