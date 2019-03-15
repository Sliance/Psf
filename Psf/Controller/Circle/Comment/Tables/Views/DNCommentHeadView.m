//
//  DNCommentHeadView.m
//  DnaerApp
//
//  Created by 燕来秋 on 2018/11/5.
//  Copyright © 2018 燕来秋. All rights reserved.
//

#import "DNCommentHeadView.h"
#import "DNCommentList.h"
#import "ZSConfig.h"
@interface DNCommentHeadView ()

@property (nonatomic, strong) UIImageView *headView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UIButton *replyBtn;
@property (nonatomic, strong) UIButton *likeBtn;
@property (nonatomic, strong) UILabel *favourLabel;
@property (nonatomic, strong) UIImageView *contentImage;
//@property (nonatomic, strong) DNCustomRecordProgressView *recordView;
@property (nonatomic, strong) DNCommentList *model;

@end

@implementation DNCommentHeadView



- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        [self setup];
    }
    return self;
}

- (void)setup {
    [self addSubview:self.headView];
    [self addSubview:self.nameLabel];
    [self addSubview:self.timeLabel];
    [self addSubview:self.replyBtn];
    [self addSubview:self.favourLabel];
    [self addSubview:self.contentImage];
    [self addSubview:self.replyBtn];
    [self addSubview:self.likeBtn];
//    [self addSubview:self.recordView];
    self.nameLabel.frame = CGRectMake(self.headView.ctRight+10, 23, SCREENWIDTH-116, 12);
    self.likeBtn.frame = CGRectMake(SCREENWIDTH-60, 23, 60, 40);
}

- (void)layoutSubviews {
    [super layoutSubviews];
    // 头像
    [self.headView addMaskLayer];
}


#pragma mark - 懒方法
- (UIImageView *)headView {
    if (!_headView) {
        _headView = [[UIImageView alloc] initWithFrame:CGRectMake(13, 20, 40, 40)];
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
        _nameLabel = [UILabel createFont:[UIFont boldSystemFontOfSize:13] color:DSColorFromHex(0x454545)];
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
-(UIButton *)replyBtn{
    if (!_replyBtn) {
        _replyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_replyBtn setTitle:@"回复" forState:UIControlStateNormal];
        [_replyBtn setTitleColor:DSColorFromHex(0x18609C) forState:UIControlStateNormal];
        _replyBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [_replyBtn addTarget:self action:@selector(pressReplay) forControlEvents:UIControlEventTouchUpInside];
    }
    return _replyBtn;
}
-(UIButton *)likeBtn{
    if (!_likeBtn) {
        _likeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_likeBtn setImage:[UIImage imageNamed:@"zan_recipe"] forState:UIControlStateNormal];
        [_likeBtn setImage:[UIImage imageNamed:@"zan_recipe_selected"] forState:UIControlStateSelected];
        [_likeBtn setTitleColor:DSColorFromHex(0x454545) forState:UIControlStateNormal];
        _likeBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [_likeBtn addTarget:self action:@selector(pressLike:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _likeBtn;
}

- (UILabel *)favourLabel {
    if (!_favourLabel) {
        _favourLabel = [UILabel createFont:[UIFont systemFontOfSize:12] color:DSColorFromHex(0x454545) alignment:NSTextAlignmentLeft];
        _favourLabel.numberOfLines = 0;
        _favourLabel.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pressReplay)];
        [_favourLabel addGestureRecognizer:tap];
    }
    return _favourLabel;
}


- (void)headerFooterForSection:(NSInteger)section inTableView:(UITableView *)tableView withData:(id)data type:(CHGTableViewHeaderFooterViewType)type {
    [super headerFooterForSection:section inTableView:tableView withData:data type:type];
    if ([data isMemberOfClass:[DNCommentList class]]) {
        DNCommentList * model = data;
        [_headView sd_setImageWithURL:[NSURL URLWithString:model.memberAvatarPath]];
        _nameLabel.text = model.memberNickname;
        [_favourLabel setText:model.commentContent lineSpacing:5];
        self.model = model;
        [self setLauout:model];
    }
}
-(void)setLauout:(DNCommentList *)model{
    self.timeLabel.frame = CGRectMake(63, self.nameLabel.ctBottom+5, SCREENWIDTH-153, 31);
    if (model.commentContent.length>0) {
        self.favourLabel.frame = CGRectMake(63, self.timeLabel.ctBottom+5, SCREENWIDTH-116, [self.favourLabel getHeightLineWithString:model.commentContent withWidth:SCREENWIDTH-116 withFont:[UIFont systemFontOfSize:13] lineSpacing:5]);
    }else{
        self.favourLabel.frame = CGRectMake(63, self.timeLabel.ctBottom+5, SCREENWIDTH-116, 0);
    }
    
    [self.likeBtn setTitle:[NSString stringWithFormat:@"%ld",(long)model.commentLikeCount] forState:UIControlStateNormal];
    [self.likeBtn setIconInTopWithSpacing:5];
    self.likeBtn.selected = model.wasLiked;
    self.timeLabel.text = [NSDate cStringFromTimestamp:model.systemCreateTime Formatter:@"MM月dd日 HH:mm"];
}

-(void)pressReplay{
    self.eventTransmissionBlock(self, self.model, 0, nil);
}
-(void)pressLike:(UIButton*)sender{
   
    self.eventTransmissionBlock(self, self.model, 1, nil);
}


@end
