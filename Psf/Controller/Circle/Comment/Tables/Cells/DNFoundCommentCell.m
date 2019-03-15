//
//  DNFoundCommentCell.m
//  DnaerApp
//
//  Created by 燕来秋 on 2018/11/5.
//  Copyright © 2018 燕来秋. All rights reserved.
//

#import "DNFoundCommentCell.h"
#import "DNCommentHeadView.h"
#import "DNCommentExtsReplysModel.h"

@interface DNFoundCommentCell ()

@property (nonatomic, strong) UIImageView *headView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *favourLabel;
@property (nonatomic, strong) UIImageView *contentImage;
@property (nonatomic, strong) DNCommentExtsReplysModel *model;

@end

@implementation DNFoundCommentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
       [self setup];
    }
    return self;
}

- (void)setup {
    [self addSubview:self.headView];
    [self addSubview:self.nameLabel];
    [self addSubview:self.timeLabel];
    [self addSubview:self.favourLabel];
    [self addSubview:self.contentImage];
    self.nameLabel.frame = CGRectMake(97, 23, SCREENWIDTH-153, 12);
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    // 头像
    [self.headView addMaskLayer];
}


#pragma mark - 懒方法
- (UIImageView *)headView {
    if (!_headView) {
        _headView = [[UIImageView alloc] initWithFrame:CGRectMake(63, 20, 24, 24)];
        [_headView setBackgroundColor:[UIColor redColor]];
    }
    return _headView;
}
-(UIImageView *)contentImage{
    if (!_contentImage) {
        _contentImage = [[UIImageView alloc]init];
        [_contentImage.layer setCornerRadius:3];
        [_contentImage.layer setMasksToBounds:YES];
    }
    return _contentImage;
}
- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [UILabel createFont:[UIFont systemFontOfSize:13] color:DSColorFromHex(0x454545)];
    }
    return _nameLabel;
}

- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [UILabel createFont:[UIFont systemFontOfSize:12] color:DSColorFromHex(0x979797)];
        _timeLabel.text = @"3小时前";
    }
    return _timeLabel;
}


- (UILabel *)favourLabel {
    if (!_favourLabel) {
        _favourLabel = [UILabel createFont:[UIFont systemFontOfSize:13] color:DSColorFromHex(0x454545) alignment:NSTextAlignmentLeft];
        _favourLabel.numberOfLines = 0;
        _favourLabel.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pressReplay)];
        [_favourLabel addGestureRecognizer:tap];
    }
    return _favourLabel;
}

-(void)setLauout:(DNCommentExtsReplysModel *)model{
    self.model = model;
    self.timeLabel.frame = CGRectMake(97, self.nameLabel.ctBottom+5, SCREENWIDTH-153, 25);
    if (model.commentContent.length>0) {
        self.favourLabel.frame = CGRectMake(97, self.timeLabel.ctBottom+8, SCREENWIDTH-153, [self.favourLabel getHeightLineWithString:model.commentContent withWidth:SCREENWIDTH-153 withFont:[UIFont systemFontOfSize:13] lineSpacing:5]);
    }else{
        self.favourLabel.frame = CGRectMake(97, self.timeLabel.ctBottom+8, SCREENWIDTH-116, 0);
    }

    self.timeLabel.text = [NSDate cStringFromTimestamp:model.systemCreateTime Formatter:@"MM月dd日 HH:mm"];
}

-(void)pressReplay{
  self.eventTransmissionBlock(self, self.model, 0, nil);
}


- (void)cellForRowAtIndexPath:(NSIndexPath *)indexPath tableView:(UITableView *)tableView withData:(id)data {
    [super cellForRowAtIndexPath:indexPath tableView:tableView withData:data];
   
}
- (void)cellWillAppear {
    [super cellWillAppear];
    DNCommentExtsReplysModel * commentDataModel = self.cellData;
    [_headView sd_setImageWithURL:[NSURL URLWithString:commentDataModel.memberAvatarPath]];
    _nameLabel.text =commentDataModel.memberNickname;
    [_favourLabel setText:commentDataModel.commentContent lineSpacing:5];
    [self setLauout:commentDataModel];
    
}

- (void)setEventTransmissionBlock:(CHGEventTransmissionBlock)eventTransmissionBlock {
    [super setEventTransmissionBlock:eventTransmissionBlock];
    
}



@end
