
//
//  MineTableViewCell.m
//  Psf
//
//  Created by 燕来秋mac9 on 2018/6/20.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "MineTableViewCell.h"
#import <Masonry.h>
@implementation MineTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(UIImageView *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UIImageView alloc]init];
    
    }
    return _titleLabel;
}
-(UILabel *)detailLabel{
    if (!_detailLabel) {
        _detailLabel = [[UILabel alloc]init];
        _detailLabel.font = [UIFont systemFontOfSize:15];
        _detailLabel.textColor = [UIColor colorWithRed:70.0001/255.0 green:70.0001/255.0 blue:70.0001/255.0 alpha:1];
        _detailLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _detailLabel;
}
-(UILabel *)lineLabel{
    if (!_lineLabel) {
        _lineLabel = [[UILabel alloc]init];
        _lineLabel.backgroundColor = [UIColor colorWithRed:120/255.0 green:120/255.0 blue:120/255.0 alpha:0.2];
    }
    return _lineLabel;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubview:self.titleLabel];
        [self addSubview:self.detailLabel];
        [self.detailLabel addSubview:self.lineLabel];
       
    }
    return self;
}
-(void)setSection:(NSInteger)section{
    _section = section;
    NSInteger offect;
    if (section ==0) {
        offect = 15;
    }else{
        offect = 40;
    }
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self).offset(15);
        make.centerY.equalTo(self);
        
    }];
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.left.equalTo(self).offset(offect);
        make.height.mas_equalTo(45);
    }];
    [self.lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.detailLabel.mas_bottom).offset(-1);
        make.left.equalTo(self).offset(offect);
        make.right.equalTo(self);
        make.height.mas_equalTo(0.5);
    }];
}
-(void)setIndex:(NSInteger)index{
    _index = index;
    
}
@end
