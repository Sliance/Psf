//
//  GoodEvaluateView.m
//  Psf
//
//  Created by 燕来秋mac9 on 2018/6/29.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "GoodEvaluateView.h"

@implementation GoodEvaluateView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setCornerLayout];
    }
    return self;
}
-(void)setCornerLayout{
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.headImage];
    [self addSubview:self.nameLabel];
    [self addSubview:self.lineLabel];
    [self addSubview:self.titleLabel];
    [self addSubview:self.detailLabel];
    [self addSubview:self.rightImage];
    [self addSubview:self.topLine];
    [self addSubview:self.topBtn];
    self.topLine.frame = CGRectMake(0, 0, SCREENWIDTH, 5);
    self.titleLabel.frame = CGRectMake(15, 5, 100, 45);
    self.detailLabel.frame = CGRectMake(130, 5, SCREENWIDTH-169, 45);
    self.rightImage.frame = CGRectMake(SCREENWIDTH-28, 20, 8, 14);
    self.topBtn.frame = CGRectMake(0, 0, SCREENWIDTH, 45);
    self.lineLabel.frame = CGRectMake(15, 50, SCREENWIDTH-15, 0.5);
}
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.text = @"评价(468)";
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.font = [UIFont systemFontOfSize:14];
        _titleLabel.textColor = DSColorFromHex(0x464646);
    }
    return _titleLabel;
}
-(UILabel *)detailLabel{
    if (!_detailLabel) {
        _detailLabel = [[UILabel alloc]init];
        _detailLabel.text = @"96.5% 好评";
        _detailLabel.textAlignment = NSTextAlignmentRight;
        _detailLabel.font = [UIFont systemFontOfSize:14];
        _detailLabel.textColor = DSColorFromHex(0x787878);
    }
    return _detailLabel;
}
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
        _nameLabel.text = @"139****5431";
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        _nameLabel.font = [UIFont systemFontOfSize:14];
        _nameLabel.textColor = DSColorFromHex(0x454545);
    }
    return _nameLabel;
}
-(UILabel *)dateLabel{
    if (!_dateLabel) {
        _dateLabel = [[UILabel alloc]init];
        _dateLabel.text = @"2017.12.16  19 : 43";
        _dateLabel.textAlignment = NSTextAlignmentLeft;
        _dateLabel.font = [UIFont systemFontOfSize:10];
        _dateLabel.textColor = DSColorFromHex(0x464646);
    }
    return _dateLabel;
}
-(UILabel *)lineLabel{
    if (!_lineLabel) {
        _lineLabel = [[UILabel alloc]init];
        _lineLabel.backgroundColor =  DSColorFromHex(0xDCDCDC);
    }
    return _lineLabel;
}
-(UIImageView *)rightImage{
    if (!_rightImage) {
        _rightImage = [[UIImageView alloc]init];
        _rightImage.image = [UIImage imageNamed:@"icon_right"];
    }
    return _rightImage;
}
-(UIButton *)topBtn{
    if (!_topBtn) {
        _topBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_topBtn addTarget:self action:@selector(pressTopBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _topBtn;
}
-(UILabel *)topLine{
    if (!_topLine) {
        _topLine = [[UILabel alloc]init];
        _topLine.backgroundColor =  DSColorFromHex(0xF0F0F0);
    }
    return _topLine;
}
-(void)pressTopBtn:(UIButton*)sender{
    self.skipBlock(sender.tag);
}
@end
