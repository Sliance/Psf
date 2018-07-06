//
//  LogisticsTableViewCell.m
//  Psf
//
//  Created by 燕来秋mac9 on 2018/7/4.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "LogisticsTableViewCell.h"

@implementation LogisticsTableViewCell

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
    self.backgroundColor = DSColorFromHex(0xF0F0F0);
    [self addSubview:self.bgView];
    [self addSubview:self.topLabel];
    [self.bgView addSubview:self.orderNumLabel];
    [self.bgView addSubview:self.topline];
    
    [self.bgView addSubview:self.headImage];
    [self.bgView addSubview:self.headImageTwo];
    [self.bgView addSubview:self.headImageThree];
    [self.bgView addSubview:self.nameLabel];
    [self.bgView addSubview:self.countLabel];
    [self.bgView addSubview:self.weightLabel];
  
   
    self.topLabel.frame = CGRectMake(0, 0, SCREENWIDTH, 40);
    self.bgView.frame = CGRectMake(15, 40, SCREENWIDTH-30, 150);
    self.orderNumLabel.frame = CGRectMake(15, 0, SCREENWIDTH-90, 44);
    self.topline.frame = CGRectMake(15, 44, SCREENWIDTH-60, 0.5);
    self.headImage.frame = CGRectMake(15, 60, 75, 75);
    self.headImageTwo.frame = CGRectMake(100, 60, 75, 75);
    self.headImageThree.frame = CGRectMake(190, 60, 75, 75);
    self.nameLabel.frame = CGRectMake(101, 79, SCREENWIDTH-202, 14);
    self.countLabel.frame = CGRectMake(SCREENWIDTH-60-30,79,45, 14);
    self.weightLabel.frame = CGRectMake(101, self.nameLabel.ctBottom+10, SCREENWIDTH-202, 12);
  
    
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
-(UILabel *)topLabel{
    if (!_topLabel) {
        _topLabel = [[UILabel alloc]init];
        _topLabel.textAlignment = NSTextAlignmentCenter;
        _topLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:10];
        _topLabel.textColor = DSColorFromHex(0xB5B5B5);
        _topLabel.text = @"昨天 12:00";
    }
    return _topLabel;
}
-(UIImageView *)headImageTwo{
    if (!_headImageTwo) {
        _headImageTwo = [[UIImageView alloc]init];
        _headImageTwo.image = [UIImage imageNamed:@"niu"];
        [_headImageTwo.layer setMasksToBounds:YES];
        [_headImageTwo.layer setCornerRadius:4];
        _headImageTwo.hidden = YES;
        _headImageTwo.layer.borderWidth = 0.5;
        _headImageTwo.layer.borderColor = [UIColor colorWithRed:127.5/255.0 green:127.5/255.0 blue:127.5/255.0 alpha:0.3].CGColor;
    }
    return _headImageTwo;
}
-(UIImageView *)headImageThree{
    if (!_headImageThree) {
        _headImageThree = [[UIImageView alloc]init];
        _headImageThree.image = [UIImage imageNamed:@"niu"];
        [_headImageThree.layer setMasksToBounds:YES];
        [_headImageThree.layer setCornerRadius:4];
        _headImageThree.layer.borderWidth = 0.5;
        _headImageThree.hidden = YES;
        _headImageThree.layer.borderColor = [UIColor colorWithRed:127.5/255.0 green:127.5/255.0 blue:127.5/255.0 alpha:0.3].CGColor;
    }
    return _headImageThree;
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
        _weightLabel.textColor = DSColorFromHex(0x787878);
        _weightLabel.text = @"6个  1.2kg";
    }
    return _weightLabel;
}

-(UILabel *)countLabel{
    if (!_countLabel) {
        _countLabel = [[UILabel alloc]init];
        _countLabel.textAlignment = NSTextAlignmentRight;
        _countLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:15];
        _countLabel.textColor = DSColorFromHex(0x464646);
        _countLabel.text = @"X2";
    }
    return _countLabel;
}
-(UILabel *)orderNumLabel{
    if (!_orderNumLabel) {
        _orderNumLabel = [[UILabel alloc]init];
        _orderNumLabel.textAlignment = NSTextAlignmentLeft;
        _orderNumLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:15];
        _orderNumLabel.textColor = DSColorFromHex(0x464646);
        _orderNumLabel.text = @"订单52341236已发货";
    }
    return _orderNumLabel;
}

-(UIView *)bgView{
    if (!_bgView) {
        _bgView = [[UIView alloc]init];
        _bgView.backgroundColor = [UIColor whiteColor];
    }
    return _bgView;
}
-(UILabel *)topline{
    if (!_topline) {
        _topline = [[UILabel alloc]init];
        _topline.backgroundColor = DSColorFromHex(0xF0F0F0);
    }
    return _topline;
}


@end
