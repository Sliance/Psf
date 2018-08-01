//
//  PointAmountCell.m
//  Psf
//
//  Created by 燕来秋mac9 on 2018/7/20.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "PointAmountCell.h"

@implementation PointAmountCell

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
        [self addSubview:self.nameLabel];
        [self addSubview:self.yuEswitch];
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(15);
            make.top.bottom.equalTo(self);
        }];
        [self.yuEswitch mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).offset(-15);
            make.top.equalTo(self).offset(12);
            make.width.mas_equalTo(20);
            make.height.mas_equalTo(20);
        }];
    }
    return self;
}
-(void)setIndex:(NSInteger)index{
    _index = index;
    _yuEswitch.tag = _index;
}
-(UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.textColor = DSColorFromHex(0x464646);
        _nameLabel.font = [UIFont systemFontOfSize:15];
    }
    return _nameLabel;
}
-(UIButton *)yuEswitch{
    if (!_yuEswitch) {
        
        _yuEswitch = [UIButton buttonWithType:UIButtonTypeCustom];
        [_yuEswitch setImage:[UIImage imageNamed:@"shopping_normal"] forState:UIControlStateNormal];
        [_yuEswitch setImage:[UIImage imageNamed:@"shopping_selected"] forState:UIControlStateSelected];
        _yuEswitch.selected = YES;
        [_yuEswitch addTarget:self action:@selector(pressSwitch:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _yuEswitch;
}
-(void)pressSwitch:(UIButton*)sender{
    self.yuEBlock(sender.tag);
}
@end
