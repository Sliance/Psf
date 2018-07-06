//
//  MessageTableViewCell.m
//  Psf
//
//  Created by 燕来秋mac9 on 2018/6/25.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "MessageTableViewCell.h"

@implementation MessageTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(UIImageView *)headImage{
    if (!_headImage) {
        _headImage = [[UIImageView alloc]init];
        _headImage.image = [UIImage imageNamed:@"service_mine"];
        [_headImage.layer setMasksToBounds:YES];
        [_headImage.layer setCornerRadius:2];
        _headImage.layer.borderWidth = 0.5;
        _headImage.layer.borderColor = [UIColor colorWithRed:127.5/255.0 green:127.5/255.0 blue:127.5/255.0 alpha:0.3].CGColor;
    }
    return _headImage;
}
-(UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        _nameLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:15];
        _nameLabel.textColor = [UIColor colorWithRed:70.0001/255.0 green:70.0001/255.0 blue:70.0001/255.0 alpha:1];
        _nameLabel.text = @"我的客服";
    }
    return _nameLabel;
}
-(UILabel *)contentLabel{
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc]init];
        _contentLabel.textAlignment = NSTextAlignmentLeft;
        _contentLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:12];
        _contentLabel.textColor = [UIColor colorWithRed:119.001/255.0 green:119.001/255.0 blue:119.001/255.0 alpha:1];
        _contentLabel.text = @"查看我与客服的沟通记录";
    }
    return _contentLabel;
}
-(UILabel *)countLabel{
    if (!_countLabel) {
        _countLabel = [[UILabel alloc]init];
        _countLabel.textAlignment = NSTextAlignmentCenter;
        _countLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:12];
        _countLabel.textColor = [UIColor whiteColor];
        [_countLabel.layer setCornerRadius:8];
        [_countLabel.layer setMasksToBounds:YES];
        _countLabel.text = @"1";
    }
    return _countLabel;
}
-(UILabel *)rightLabel{
    if (!_rightLabel) {
        _rightLabel = [[UILabel alloc]init];
        _rightLabel.textAlignment = NSTextAlignmentCenter;
        _rightLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:12];
        _rightLabel.text = @"";
    }
    return _rightLabel;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = DSColorFromHex(0xF0F0F0);
        [self setcornerLayout];
    }
    return self;
}
-(UIView *)bgView{
    if (!_bgView) {
        _bgView = [[UIView alloc]init];
        _bgView.backgroundColor = [UIColor whiteColor];
    }
    return _bgView;
}
-(void)setcornerLayout{
    [self addSubview:self.bgView];
    [self.bgView addSubview:self.headImage];
    [self.bgView addSubview:self.nameLabel];
    [self.bgView addSubview:self.contentLabel];
    [self.bgView addSubview:self.countLabel];
    [self.bgView addSubview:self.rightLabel];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self).offset(5);
        make.bottom.equalTo(self);
    }];
    [self.headImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgView).offset(15);
        make.width.height.mas_equalTo(40);
        make.centerY.equalTo(self.bgView);
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headImage.mas_right).offset(15);
        make.top.equalTo(self.bgView).offset(16);
       
    }];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headImage.mas_right).offset(15);
        make.top.equalTo(self.nameLabel.mas_bottom).offset(5);
    }];
    [self.rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.bgView).offset(-15);
        make.centerY.equalTo(self.bgView);
        make.width.mas_equalTo(7);
        make.height.mas_equalTo(12);
    }];
    [self.countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.rightLabel.mas_left).offset(-15);
        make.centerY.equalTo(self.bgView);
        make.width.height.mas_equalTo(16);
    }];
}
@end
