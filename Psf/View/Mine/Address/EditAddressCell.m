//
//  EditAddressCell.m
//  Psf
//
//  Created by 燕来秋mac9 on 2018/6/26.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "EditAddressCell.h"

@implementation EditAddressCell

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
        
        [self addSubview:self.contentField];
        [self.contentField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(15);
            make.right.equalTo(self).offset(-15);
            make.centerY.equalTo(self);
        }];
        
    }
    return self;
}
-(UITextField *)contentField{
    if (!_contentField) {
        _contentField = [[UITextField alloc]init];
        _contentField.font = [UIFont systemFontOfSize:13];
        _contentField.textColor = DSColorFromHex(0x454545);
    }
    return _contentField;
}
@end
