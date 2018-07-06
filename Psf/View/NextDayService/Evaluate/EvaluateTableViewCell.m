//
//  EvaluateTableViewCell.m
//  Psf
//
//  Created by 燕来秋mac9 on 2018/6/26.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "EvaluateTableViewCell.h"

@implementation EvaluateTableViewCell

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
        [self setcornetLayout];
    }
    return self;
}
-(void)setcornetLayout{
    [self addSubview:self.headImage];
    [self addSubview:self.nameLabel];
    [self addSubview:self.dateLabel];
    [self addSubview:self.contentsLabel];
    [self addSubview:self.ratingView];
    self.headImage.frame = CGRectMake(15, 15, 40, 40);
    self.nameLabel.frame = CGRectMake(15+self.headImage.ctRight, 24, 82, 11);
    self.dateLabel.frame = CGRectMake(self.headImage.ctRight+15, self.nameLabel.ctBottom+8, SCREENWIDTH-110, 8);
    self.contentsLabel.frame = CGRectMake(15, 69, SCREENWIDTH-60, 85);
    self.ratingView.frame = CGRectMake(self.nameLabel.ctRight+10, 20, 113, 16);
}
-(UIImageView *)headImage{
    if (!_headImage) {
        _headImage = [[UIImageView alloc]init];
        _headImage.image = [UIImage imageNamed:@"banana_sort"];
        [_headImage.layer setMasksToBounds:YES];
        [_headImage.layer setCornerRadius:20];
    }
    return _headImage;
}
-(UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        _nameLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:14];
        _nameLabel.textColor =DSColorFromHex(0x454545);
        _nameLabel.text = @"139****5431";
    }
    return _nameLabel;
}
-(UILabel *)dateLabel{
    if (!_dateLabel) {
        _dateLabel = [[UILabel alloc]init];
        _dateLabel.textAlignment = NSTextAlignmentLeft;
        _dateLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:10];
        _dateLabel.textColor =DSColorFromHex(0x464646);
        _dateLabel.text = @"2017.12.16  19 : 43";
    }
    return _dateLabel;
}
-(UILabel *)contentsLabel{
    if (!_contentsLabel) {
        _contentsLabel = [[UILabel alloc]init];
        _contentsLabel.textAlignment = NSTextAlignmentLeft;
        _contentsLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:15];
        _contentsLabel.textColor = DSColorFromHex(0x464646);
        _contentsLabel.text = @"这个进口的奇异果非常的新鲜和大，大小均匀，非常香甜的，超值，本人非常喜欢。一直买的这个来吃，发货好快，昨天买的今天就到了，这次的不用放太久，都有一点熟了，一箱有25个。";
        _contentsLabel.numberOfLines = 0;
    }
    return _contentsLabel;
}
-(RatingView *)ratingView{
    if (!_ratingView) {
        _ratingView = [[RatingView alloc] init];
        self.ratingView.minRating = 0;
        self.ratingView.maxRating = 5;
        self.ratingView.emptySelectedImage = [UIImage imageNamed:@"evalustel_empty"];
        self.ratingView.fullSelectedImage = [UIImage imageNamed:@"evalustel_full"];
        self.ratingView.rating = 5; // 默认5星
        self.ratingView.editable = YES;
        self.ratingView.delegate = self;
    }
    return _ratingView;
}
@end
