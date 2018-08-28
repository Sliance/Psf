//
//  HomeTableViewCell.m
//  Psf
//
//  Created by 燕来秋mac9 on 2018/8/27.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "HomeTableViewCell.h"

@implementation HomeTableViewCell

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
        [self setlayout];
        [self.contentView addSubview:self.headimage];
    }
    return self;
}
-(void)setlayout{
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.headimage];
    [self.contentView addSubview:self.leftlLabel];
    [self.contentView addSubview:self.rightLabel];
    self.titleLabel.frame = CGRectMake(SCREENWIDTH/2-50, 0, 100, 50);
    self.leftlLabel.frame = CGRectMake(0, 0, SCREENWIDTH/2-50, 50);
    self.rightLabel.frame = CGRectMake(SCREENWIDTH/2+50, 0, SCREENWIDTH/2-50, 50);
    self.headimage.frame = CGRectMake(0, 50, SCREENWIDTH, 277*SCREENWIDTH/375);
    
}
-(UIImageView *)headimage{
    if (!_headimage) {
        _headimage = [[UIImageView alloc]init];
        
    }
    return _headimage;
}
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:16];
        _titleLabel.textColor = DSColorFromHex(0x474747);
        _titleLabel.text = @"////// 预售商品 \\\\\\";
    }
    return _titleLabel;
}
-(UILabel *)leftlLabel{
    if (!_leftlLabel) {
        _leftlLabel = [[UILabel alloc]init];
        _leftlLabel.textAlignment = NSTextAlignmentRight;
        _leftlLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:9];
        _leftlLabel.textColor = DSColorFromHex(0xCECECE);
        _leftlLabel.text = @"///////";
    }
    return _leftlLabel;
}
-(UILabel *)rightLabel{
    if (!_rightLabel) {
        _rightLabel = [[UILabel alloc]init];
        _rightLabel.textAlignment = NSTextAlignmentLeft;
        _rightLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:9];
        _rightLabel.textColor = DSColorFromHex(0xCECECE);
        _rightLabel.text = @"\\\\\\\\\\\\\\";
    }
    return _rightLabel;
}
-(void)setModel:(GroupBannerModel *)model{
    _model = model;
    NSString *url = [NSString stringWithFormat:@"%@%@",IMAGEHOST,model.productBannerImagePath];
    [self.headimage sd_setImageWithURL:[NSURL URLWithString:url]];
    self.titleLabel.text = model.productBannerTitle;
}
@end
