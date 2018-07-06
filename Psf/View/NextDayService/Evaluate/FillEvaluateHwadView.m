//
//  FillEvaluateHwadView.m
//  Psf
//
//  Created by 燕来秋mac9 on 2018/7/5.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "FillEvaluateHwadView.h"

@implementation FillEvaluateHwadView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.headImage];
        [self addSubview:self.nameLabel];
        [self addSubview:self.countLabel];
        [self addSubview:self.weightLabel];
        [self addSubview:self.pingLabel];
        [self addSubview:self.ratingView];
        [self addSubview:self.gradeLabel];
        [self.headImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo(75);
            make.top.equalTo(self).offset(17);
            make.left.equalTo(self).offset(15);
        }];
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.headImage.mas_top);
            make.left.equalTo(self.headImage.mas_right).offset(11);
            make.right.equalTo(self).offset(-15);
        }];
        [self.countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.nameLabel.mas_bottom).offset(10);
            make.left.equalTo(self.headImage.mas_right).offset(11);
        }];
        [self.weightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.nameLabel.mas_bottom).offset(10);
            make.left.equalTo(self.countLabel.mas_right).offset(5);
        }];
        [self.pingLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.headImage.mas_bottom).offset(17);
            make.left.equalTo(self).offset(15);
        }];
        [self.ratingView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.pingLabel);
            make.left.equalTo(self.pingLabel.mas_right).offset(10);
            make.width.mas_equalTo(113);
            make.height.mas_equalTo(16);
        }];
        [self.gradeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.headImage.mas_bottom).offset(17);
            make.left.equalTo(self.ratingView.mas_right).offset(10);
        }];
    }
    return self;
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
-(UIImageView *)headImage{
    if (!_headImage) {
        _headImage = [[UIImageView alloc]init];
        _headImage.image = [UIImage imageNamed:@"niu"];
        [_headImage.layer setMasksToBounds:YES];
        [_headImage.layer setCornerRadius:4];
        _headImage.layer.borderWidth = 0.5;
        _headImage.layer.borderColor = [UIColor colorWithRed:127.5/255.0 green:127.5/255.0 blue:127.5/255.0 alpha:0.3].CGColor;
    }
    return _headImage;
}
-(UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        _nameLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:15];
        _nameLabel.textColor = [UIColor colorWithRed:70/255.0 green:70/255.0 blue:70/255.0 alpha:1];
        _nameLabel.text = @"澳洲牛腱子";
    }
    return _nameLabel;
}

-(UILabel *)weightLabel{
    if (!_weightLabel) {
        _weightLabel = [[UILabel alloc]init];
        _weightLabel.textAlignment = NSTextAlignmentLeft;
        _weightLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:12];
        _weightLabel.textColor = [UIColor colorWithRed:120/255.0 green:120/255.0 blue:120/255.0 alpha:1];
        _weightLabel.text = @"1.2kg";
    }
    return _weightLabel;
}
-(UILabel *)countLabel{
    if (!_countLabel) {
        _countLabel = [[UILabel alloc]init];
        _countLabel.textAlignment = NSTextAlignmentLeft;
        _countLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:12];
        _countLabel.textColor = [UIColor colorWithRed:120/255.0 green:120/255.0 blue:120/255.0 alpha:1];
        _countLabel.text = @"6个";
    }
    return _countLabel;
}
-(UILabel *)pingLabel{
    if (!_pingLabel) {
        _pingLabel = [[UILabel alloc]init];
        _pingLabel.textAlignment = NSTextAlignmentLeft;
        _pingLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:15];
        _pingLabel.textColor = DSColorFromHex(0x474747);
        _pingLabel.text = @"评分";
    }
    return _pingLabel;
}
-(UILabel *)gradeLabel{
    if (!_gradeLabel) {
        _gradeLabel = [[UILabel alloc]init];
        _gradeLabel.textAlignment = NSTextAlignmentLeft;
        _gradeLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:15];
        _gradeLabel.textColor = DSColorFromHex(0x474747);
        _gradeLabel.text = @"满意";
    }
    return _gradeLabel;
}
@end
