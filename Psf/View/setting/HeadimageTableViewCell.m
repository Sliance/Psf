//
//  HeadimageTableViewCell.m
//  Psf
//
//  Created by 燕来秋mac9 on 2018/6/26.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "HeadimageTableViewCell.h"

@implementation HeadimageTableViewCell

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
        [self addSubview:self.titleLabel];
        [self addSubview:self.headImage];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(15);
            make.top.bottom.equalTo(self);
        }];
        [self.headImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).offset(-15);
            make.centerY.equalTo(self);
            make.width.height.mas_equalTo(55);
        }];

    }
    return self;
}
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = [UIFont systemFontOfSize:13];
        _titleLabel.textColor = DSColorFromHex(0x454545);
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.text = @"头像";
    }
    return _titleLabel;
}
-(UIImageView *)headImage{
    if (!_headImage) {
        _headImage = [[UIImageView alloc]init];
        [_headImage.layer setMasksToBounds:YES];
        [_headImage.layer setCornerRadius:55/2];
        [_headImage setImage:[UIImage imageNamed:@"mine_avater_55"]];
    }
    return _headImage;
}

-(void)setResult:(MineInformationReq *)result{
    _result = result;
    
    [_headImage sd_setImageWithURL:[NSURL URLWithString:result.memberAvatarPath]placeholderImage:[UIImage imageNamed:@"mine_avater_55"]];
    
}
@end
