//
//  EvaluateListHeadView.m
//  Psf
//
//  Created by 燕来秋mac9 on 2018/6/29.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "EvaluateListHeadView.h"

@implementation EvaluateListHeadView
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setCornerLayout];
    }
    return self;
}
-(void)setCornerLayout{
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.allBtn];
    [self addSubview:self.photoBtn];
    [self addSubview:self.contentBtn];
    [self addSubview:self.lineLabel];
    [self addSubview:self.ratingView];
    [self addSubview:self.titleLabel];
    self.lineLabel.frame = CGRectMake(0, 90, SCREENWIDTH, 0.5);
    self.allBtn.frame = CGRectMake(15, 46, 85, 30);
    self.photoBtn.frame = CGRectMake(15+self.allBtn.ctRight, 46, 85, 30);
    self.contentBtn.frame = CGRectMake(15+self.photoBtn.ctRight, 46, 85, 30);
    self.titleLabel.frame = CGRectMake(self.ratingView.ctRight+10, 16, 100, 14);
}

-(UILabel *)lineLabel{
    if (!_lineLabel) {
        _lineLabel = [[UILabel alloc]init];
        _lineLabel.backgroundColor = DSColorFromHex(0xDCDCDC);
    }
    return _lineLabel;
}
-(UIButton *)allBtn{
    if (!_allBtn) {
        _allBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _allBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [_allBtn setTitle:@"全部(999+)" forState:UIControlStateNormal];
        [_allBtn.layer setCornerRadius:4];
        [_allBtn.layer setMasksToBounds:YES];
        _allBtn.selected = YES;
        [_allBtn setTitleColor:DSColorFromHex(0x464646) forState:UIControlStateNormal];
        [_allBtn setTitleColor:DSColorFromHex(0xFF4C4D) forState:UIControlStateSelected];
        [_allBtn addTarget:self action:@selector(pressBtn:) forControlEvents:UIControlEventTouchUpInside];
        [_allBtn.layer setBorderWidth:0.5];
        [_allBtn.layer setBorderColor:DSColorFromHex(0xFF4C4D).CGColor];
    }
    return _allBtn;
}
-(UIButton *)photoBtn{
    if (!_photoBtn) {
        _photoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _photoBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [_photoBtn setTitle:@"有图(231)" forState:UIControlStateNormal];
        [_photoBtn.layer setCornerRadius:4];
        [_photoBtn.layer setMasksToBounds:YES];
        [_photoBtn setTitleColor:DSColorFromHex(0x464646) forState:UIControlStateNormal];
        [_photoBtn setTitleColor:DSColorFromHex(0xFF4C4D) forState:UIControlStateSelected];
         [_photoBtn addTarget:self action:@selector(pressBtn:) forControlEvents:UIControlEventTouchUpInside];
        [_photoBtn.layer setBorderWidth:0.5];
        [_photoBtn.layer setBorderColor:DSColorFromHex(0x464646).CGColor];
    }
    return _photoBtn;
}
-(UIButton *)contentBtn{
    if (!_contentBtn) {
        _contentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _contentBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [_contentBtn setTitle:@"有内容(126)" forState:UIControlStateNormal];
        [_contentBtn.layer setCornerRadius:4];
        [_contentBtn.layer setMasksToBounds:YES];
        [_contentBtn setTitleColor:DSColorFromHex(0x464646) forState:UIControlStateNormal];
        [_contentBtn setTitleColor:DSColorFromHex(0xFF4C4D) forState:UIControlStateSelected];
        [_contentBtn addTarget:self action:@selector(pressBtn:) forControlEvents:UIControlEventTouchUpInside];
        [_contentBtn.layer setBorderWidth:0.5];
        [_contentBtn.layer setBorderColor:DSColorFromHex(0x464646).CGColor];
    }
    return _contentBtn;
}
-(RatingView *)ratingView{
    if (!_ratingView) {
      _ratingView = [[RatingView alloc] initWithFrame:CGRectMake(15, 15, 113, 16)];
        self.ratingView.minRating = 0;
        self.ratingView.maxRating = 5;
        self.ratingView.emptySelectedImage = [UIImage imageNamed:@"evalustel_empty"];
        self.ratingView.fullSelectedImage = [UIImage imageNamed:@"evalustel_full"];
        self.ratingView.rating = 4; // 默认5星
        self.ratingView.editable = YES;
        self.ratingView.delegate = self;
    }
    return _ratingView;
}
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:15];
        _titleLabel.textColor =DSColorFromHex(0x474747);
        _titleLabel.text = @"92.5%好评";
    }
    return _titleLabel;
}
-(void)pressBtn:(UIButton*)sender{
    
}
@end
