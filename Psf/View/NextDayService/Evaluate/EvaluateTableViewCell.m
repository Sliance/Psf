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
    _cardImgsView = [[UIView alloc] init];
    [self.contentView addSubview:_cardImgsView];
    
    self.headImage.frame = CGRectMake(15, 15, 40, 40);
 
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
        _nameLabel.text = @"";
    }
    return _nameLabel;
}
-(UILabel *)dateLabel{
    if (!_dateLabel) {
        _dateLabel = [[UILabel alloc]init];
        _dateLabel.textAlignment = NSTextAlignmentLeft;
        _dateLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:10];
        _dateLabel.textColor =DSColorFromHex(0x464646);
        _dateLabel.text = @"";
    }
    return _dateLabel;
}
-(UILabel *)contentsLabel{
    if (!_contentsLabel) {
        _contentsLabel = [[UILabel alloc]init];
        _contentsLabel.textAlignment = NSTextAlignmentLeft;
        _contentsLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:15];
        _contentsLabel.textColor = DSColorFromHex(0x464646);
        _contentsLabel.text = @"";
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
        // 默认5星
        self.ratingView.editable = YES;
        self.ratingView.delegate = self;
    }
    return _ratingView;
}
-(void)setModel:(EvaluateListModel *)model{
    _model = model;
    [self.headImage sd_setImageWithURL:[NSURL URLWithString:model.memberAvatarPath]placeholderImage:[UIImage imageNamed:@"mine_avater_55"]];
    self.nameLabel.text = model.memberNickName;
    self.dateLabel.text = [NSDate cStringFromTimestamp:model.systemCreateTime Formatter:@"yyyy.MM.dd HH:mm"];
    self.contentsLabel.text = model.saleOrderProductCommentContent;
    self.ratingView.rating = model.saleOrderProductCommentSatisfaction;
    self.nameLabel.frame = CGRectMake(15+self.headImage.ctRight, 24, [model.memberNickName widthForFont:[UIFont systemFontOfSize:14]], 11);
    self.dateLabel.frame = CGRectMake(self.headImage.ctRight+15, self.nameLabel.ctBottom+8, SCREENWIDTH-110, 8);
    
    self.ratingView.frame = CGRectMake(self.nameLabel.ctRight+10, 20, 113, 16);
     self.contentsLabel.frame = CGRectMake(15, 69, SCREENWIDTH-60, [model.saleOrderProductCommentContent heightForFont:[UIFont systemFontOfSize:15] width:SCREENWIDTH-30]);
    NSInteger rowNumber;
    
    if (model.saleOrderProductCommentImageList.count % 3 == 0) {
        rowNumber = model.saleOrderProductCommentImageList.count/3;
    }else{
        rowNumber = model.saleOrderProductCommentImageList.count/3 + 1;
    }
    self.cardImgsView.frame = CGRectMake(0, self.contentsLabel.ctBottom+10, SCREENWIDTH, rowNumber*105+15);
    NSInteger  count = model.saleOrderProductCommentImageList.count;
    
    for (int i =0; i<count; i++) {
        ImageModel *imagemodel = model.saleOrderProductCommentImageList[i];
        UIImageView *image = [[UIImageView alloc]init];
        image.frame = CGRectMake(15+i%3*105, i/3*105, 90, 90);
        [image sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEHOST,imagemodel.saleOrderProductCommentImagePath]]];
        [self.cardImgsView addSubview:image];
    }
    if (model.saleOrderProductCommentImageList.count ==0) {
        [self.cardImgsView removeAllSubView];
    }
}
+(CGFloat)getCellHeightWithData:(EvaluateListModel *)model{
    CGFloat height = 69;
    CGFloat width =  [UIScreen mainScreen].bounds.size.width;
    
    if (model.saleOrderProductCommentContent.length>0) {
        CGFloat height1 = [model.saleOrderProductCommentContent heightForFont:[UIFont systemFontOfSize:15] width:SCREENWIDTH-30];
        height += height1 + 5;
    }
    NSInteger rowNumber;
    
        if (model.saleOrderProductCommentImageList.count % 3 == 0) {
            rowNumber = model.saleOrderProductCommentImageList.count/3;
        }else{
            rowNumber = model.saleOrderProductCommentImageList.count/3 + 1;
        }
    
    height += rowNumber*105+15;
    
    return height;
}
@end
