//
//  TourDiyGooddetailCell.m
//  Psf
//
//  Created by 燕来秋mac9 on 2018/7/3.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "TourDiyGooddetailCell.h"

@implementation TourDiyGooddetailCell

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
        [self setCortnetLayout];
    }
    return self;
}
-(void)setCortnetLayout{
    [self addSubview:self.headImage];
    [self addSubview:self.groupName];
    [self addSubview:self.shortlabel];
    [self addSubview:self.dateLabel];
    [self addSubview:self.goBtn];
    [self.headImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15);
        make.width.height.mas_equalTo(40);
        make.centerY.equalTo(self);
    }];
    [self.groupName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headImage.mas_right).offset(10);
        make.height.mas_equalTo(71);
        make.centerY.equalTo(self);
    }];
    [self.goBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(25);
        make.right.equalTo(self).offset(-10);
        make.centerY.equalTo(self);
    }];
    [self.shortlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.goBtn.mas_left).offset(-10);
        make.top.equalTo(self).offset(20);
    }];
    [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.goBtn.mas_left).offset(-10);
        make.top.equalTo(self.shortlabel.mas_bottom).offset(4);
    }];
}
-(UIImageView *)headImage{
    if (!_headImage) {
        _headImage = [[UIImageView alloc]init];
        _headImage.image = [UIImage imageNamed:@""];
        [_headImage.layer setCornerRadius:20];
        [_headImage.layer setMasksToBounds:YES];
    }
    return _headImage;
}
-(UILabel *)groupName{
    if (!_groupName) {
        _groupName = [[UILabel alloc]init];
       
        _groupName.font = [UIFont systemFontOfSize:12];
        _groupName.textColor = DSColorFromHex(0x464646);
    }
    return _groupName;
}
-(UILabel *)shortlabel{
    if (!_shortlabel) {
        _shortlabel = [[UILabel alloc]init];
        
        _shortlabel.textAlignment = NSTextAlignmentRight;
        _shortlabel.font = [UIFont systemFontOfSize:12];
        _shortlabel.textColor = DSColorFromHex(0x646464);
    }
    return _shortlabel;
}
-(UILabel *)dateLabel{
    if (!_dateLabel) {
        _dateLabel = [[UILabel alloc]init];
        _dateLabel.textAlignment = NSTextAlignmentRight;
        _dateLabel.font = [UIFont systemFontOfSize:12];
        _dateLabel.textColor = DSColorFromHex(0xB4B4B4);
    }
    return _dateLabel;
}
-(UIButton *)goBtn{
    if (!_goBtn) {
        _goBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _goBtn.backgroundColor = DSColorFromHex(0xFF4C4D);
        [_goBtn setTitle:@"去参团" forState:UIControlStateNormal];
        [_goBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _goBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [_goBtn.layer setCornerRadius:1];
        [_goBtn.layer setMasksToBounds:YES];
        
    }
    return _goBtn;
}
-(void)setModel:(SpellGroupModel *)model{
    _model = model;
  
    [self.headImage sd_setImageWithURL:[NSURL URLWithString:model.memberAvatarPath]placeholderImage:[UIImage imageNamed:@"mine_avater_55"]];
     _groupName.text = [NSString stringWithFormat:@"%@的团",model.memberNickName];
    NSUInteger chacount = model.grouponActivityMemberLimit -model.grouponActivityMemberCount;
    _shortlabel.text = [NSString stringWithFormat:@"还差%ld人成团",chacount];

   NSString *date = [NSDate getCountDownStringWithEndTime:[NSDate cStringFromTimestamp:_model.grouponActivityExpireTime Formatter:@"yyyy-MM-dd HH:mm:ss.0"]];
    self.dateLabel.text = [NSString stringWithFormat:@"还剩 %@",date];
    NSTimer *timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
    
    [timer setFireDate:[NSDate distantPast]];
}
-(void)timerAction{
    NSString *date = [NSDate getCountDownStringWithEndTime:[NSDate cStringFromTimestamp:_model.grouponActivityExpireTime Formatter:@"yyyy-MM-dd HH:mm:ss.0"]];
    self.dateLabel.text = [NSString stringWithFormat:@"还剩 %@",date];
}
@end
