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
    self.nameLabel.frame = CGRectMake(15+self.headImage.ctRight, 24, 82, 11);
    self.dateLabel.frame = CGRectMake(self.headImage.ctRight+15, self.nameLabel.ctBottom+8, SCREENWIDTH-110, 8);
    
    self.ratingView.frame = CGRectMake(self.nameLabel.ctRight+10, 20, 113, 16);
    self.contentsLabel.frame = CGRectMake(15, 69, SCREENWIDTH-60, 85);
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
-(void)setModel:(EvaluateListModel *)model{
    _model = model;
    [self.headImage sd_setImageWithURL:[NSURL URLWithString:model.memberAvatarPath]];
    self.nameLabel.text = model.memberNickName;
    self.dateLabel.text = [NSDate cStringFromTimestamp:model.systemCreateTime];
    self.contentsLabel.text = model.saleOrderProductCommentContent;
     self.contentsLabel.frame = CGRectMake(15, 69, SCREENWIDTH-60, [model.saleOrderProductCommentContent heightForFont:[UIFont systemFontOfSize:15] width:SCREENWIDTH-30]);
    self.cardImgsView.frame = CGRectMake(0, self.contentsLabel.ctBottom+10, SCREENWIDTH, (model.saleOrderProductCommentImageList.count/3+1)*120);
    NSInteger  count = model.saleOrderProductCommentImageList.count;
    for (int i =0; i<count; i++) {
        ImageModel *imagemodel = model.saleOrderProductCommentImageList[i];
        UIImageView *image = [[UIImageView alloc]init];
        image.frame = CGRectMake(15+i%3*105, i/3*105, 90, 90);
        [image sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEHOST,imagemodel.saleOrderProductCommentImagePath]]];
        [self.cardImgsView addSubview:image];
    }
}
+(CGFloat)getCellHeightWithData:(EvaluateListModel *)model{
    CGFloat height = 69;
    CGFloat width =  [UIScreen mainScreen].bounds.size.width;
    
    if (model.saleOrderProductCommentContent.length>0) {
        CGFloat height1 = [model.saleOrderProductCommentContent heightForFont:[UIFont systemFontOfSize:15] width:SCREENWIDTH-30];
        height += height1 + 5;
    }

    if (model.saleOrderProductCommentImageList.count) {
        CGFloat imgWidth = 90;
        CGFloat imgHeight = 0;
        int screenWidth = [UIScreen mainScreen].bounds.size.width * 2;
        
        for (int i = 0; i < model.saleOrderProductCommentImageList.count; i ++) {
            ImageModel *imagemodel = model.saleOrderProductCommentImageList[i];
            NSString *imgUrl = [NSString stringWithFormat:@"%@@%dw",imagemodel.saleOrderProductCommentImagePath,screenWidth];
            if ([[SDImageCache sharedImageCache] diskImageDataExistsWithKey:imgUrl]) {
                UIImage *cacheImg = [[SDImageCache sharedImageCache] imageFromMemoryCacheForKey:imgUrl];
                if (!cacheImg) {
                    cacheImg = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:imgUrl];
                }
                imgHeight += ((imgWidth /cacheImg.size.width) * cacheImg.size.height + 10);
            }else
            {
                imgHeight += 35;
            }
        }
        height += (imgHeight + 10);
    }
    
    return height;
}
@end
