//
//  ChooseAddressTableViewCell.m
//  Psf
//
//  Created by 燕来秋mac9 on 2018/6/26.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "ChooseAddressTableViewCell.h"

@implementation ChooseAddressTableViewCell

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
        
        [self setCornentLayout];
        
    }
    return self;
}
-(void)setCornentLayout{
    [self addSubview:self.titleLabel];
    [self addSubview:self.detailLabel];
    [self addSubview:self.phoneLabel];
    [self addSubview:self.morenLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15);
        make.top.equalTo(self).offset(15);
    }];
    [self.phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel.mas_right).offset(11);
        make.top.equalTo(self).offset(15);
    }];
    [self.morenLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.phoneLabel.mas_right).offset(10);
        make.top.equalTo(self).offset(15);
    }];
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(10);
    }];
    
}
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = [UIFont systemFontOfSize:14];
        _titleLabel.textColor = DSColorFromHex(0x474747);
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.text = @"张某某";
    }
    return _titleLabel;
}
-(UILabel *)detailLabel{
    if (!_detailLabel) {
        _detailLabel = [[UILabel alloc]init];
        _detailLabel.font = [UIFont systemFontOfSize:14];
        _detailLabel.textColor = DSColorFromHex(0x969696);
        _detailLabel.textAlignment = NSTextAlignmentLeft;
        _detailLabel.text = @"闵行区旭辉·浦江国际 37号";
    }
    return _detailLabel;
}
-(UILabel *)phoneLabel{
    if (!_phoneLabel) {
        _phoneLabel = [[UILabel alloc]init];
        _phoneLabel.font = [UIFont systemFontOfSize:14];
        _phoneLabel.textColor = DSColorFromHex(0x474747);
        _phoneLabel.textAlignment = NSTextAlignmentLeft;
        _phoneLabel.text = @"135****4347";
    }
    return _phoneLabel;
}
-(UILabel *)morenLabel{
    if (!_morenLabel) {
        _morenLabel = [[UILabel alloc]init];
        _morenLabel.font = [UIFont systemFontOfSize:11];
        _morenLabel.textColor = [UIColor whiteColor];
        _morenLabel.backgroundColor = DSColorFromHex(0xFF4C4D);
        _morenLabel.textAlignment = NSTextAlignmentCenter;
        _morenLabel.text = @"默认";
    }
    return _morenLabel;
}
@end
