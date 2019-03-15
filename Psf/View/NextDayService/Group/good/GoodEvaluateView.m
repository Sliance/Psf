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
    [self.lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15);
        make.right.equalTo(self).offset(-15);
        make.top.equalTo(self).offset(50);
        make.height.mas_equalTo(0.5);
    }];
    [self addSubview:self.headImage];
    [self addSubview:self.nameLabel];
    [self addSubview:self.dateLabel];
    [self addSubview:self.contentsLabel];
    [self addSubview:self.ratingView];
    _cardImgsView = [[UIView alloc] init];
    [self addSubview:_cardImgsView];
    self.headImage.frame = CGRectMake(15,65, 40, 40);
}
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.font = [UIFont systemFontOfSize:14];
        _titleLabel.textColor = DSColorFromHex(0x464646);
    }
    return _titleLabel;
}
-(UILabel *)detailLabel{
    if (!_detailLabel) {
        _detailLabel = [[UILabel alloc]init];
        
        _detailLabel.textAlignment = NSTextAlignmentRight;
        _detailLabel.font = [UIFont systemFontOfSize:14];
        _detailLabel.textColor = DSColorFromHex(0x787878);
    }
    return _detailLabel;
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
        self.ratingView.rating = 5; // 默认5星
        self.ratingView.editable = YES;
        self.ratingView.delegate = self;
    }
    return _ratingView;
}
-(UILabel *)lineLabel{
    if (!_lineLabel) {
        _lineLabel = [[UILabel alloc]init];
        _lineLabel.backgroundColor =  DSColorFromHex(0xF0F0F0);
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
-(void)setModels:(EvaluateListRes *)models{
    _models = models;
    _titleLabel.text = [NSString stringWithFormat:@"评价(%ld)",models.total];
    _detailLabel.text = [NSString stringWithFormat:@"%.1f%% 好评",models.rate.floatValue*100];
    
    EvaluateListModel *model = [models.saleOrderProductCommentList firstObject];
    [self.headImage sd_setImageWithURL:[NSURL URLWithString:model.memberAvatarPath]placeholderImage:[UIImage imageNamed:@"mine_avater_55"]];
    self.nameLabel.text = model.memberNickName;
    self.dateLabel.text = [NSDate cStringFromTimestamp:model.systemCreateTime Formatter:@"yyyy.MM.dd HH:mm"];
    self.contentsLabel.text = model.saleOrderProductCommentContent;
    self.ratingView.rating = model.saleOrderProductCommentSatisfaction;
    self.nameLabel.frame = CGRectMake(15+self.headImage.ctRight, 24+self.lineLabel.ctBottom, [model.memberNickName widthForFont:[UIFont systemFontOfSize:14]], 11);
    self.dateLabel.frame = CGRectMake(self.headImage.ctRight+15, self.nameLabel.ctBottom+8, SCREENWIDTH-110, 8);
    
    self.ratingView.frame = CGRectMake(self.nameLabel.ctRight+10, 20+self.lineLabel.ctBottom, 113, 16);
    self.contentsLabel.frame = CGRectMake(15, 69+self.lineLabel.ctBottom, SCREENWIDTH-60, [model.saleOrderProductCommentContent heightForFont:[UIFont systemFontOfSize:15] width:SCREENWIDTH-30]);
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
}
+(CGFloat)getCellHeightWithData:(EvaluateListRes *)models{
    
    EvaluateListModel *model = [models.saleOrderProductCommentList firstObject];
    CGFloat height = 69;
  
    
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
