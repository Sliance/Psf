//
//  TradingDetailCell.m
//  Psf
//
//  Created by 燕来秋mac9 on 2018/7/2.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "TradingDetailCell.h"

@implementation TradingDetailCell

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
        [self setcornerLayout];
    }
    return self;
}
-(void)setcornerLayout{
    [self addSubview:self.priceLabel];
    [self addSubview:self.titleLabel];
    [self addSubview:self.contentLabel];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15);
        make.top.equalTo(self).offset(20);
    }];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(10);
    }];
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-16);
        make.centerY.equalTo(self);
    }];
    
}
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = [UIFont systemFontOfSize:15];
        _titleLabel.textColor = DSColorFromHex(0x323232);
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.text = @"充值余额";
    }
    return _titleLabel;
}
-(UILabel *)contentLabel{
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc]init];
        _contentLabel.font = [UIFont systemFontOfSize:12];
        _contentLabel.textColor = DSColorFromHex(0x979797);
        _contentLabel.textAlignment = NSTextAlignmentLeft;
        _contentLabel.text = @"2018-05-23";
    }
    return _contentLabel;
}
-(UILabel *)priceLabel{
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc]init];
        _priceLabel.font = [UIFont systemFontOfSize:18];
        _priceLabel.textAlignment = NSTextAlignmentLeft;
        _priceLabel.text = @"+1000.0";
    }
    return _priceLabel;
}
-(void)setType:(NSInteger)type{
    _type = type;
}
-(void)setModel:(IntegralRecord *)model{
    _model = model;
    if(_type ==1){
        if (model.memberTradeType ==0) {
            self.titleLabel.text = @"充值";
            self.priceLabel.text = [NSString stringWithFormat:@"-%@",model.payAmount];
            self.priceLabel.textColor = DSColorFromHex(0x72BF34);
        }else if (model.memberTradeType == 1){
            self.titleLabel.text = @"消费";
            self.priceLabel.text = [NSString stringWithFormat:@"-%@",model.payAmount];
            self.priceLabel.textColor = DSColorFromHex(0x72BF34);
        }else if (model.memberTradeType ==2){
            self.titleLabel.text = @"退款";
            self.priceLabel.text = [NSString stringWithFormat:@"+%@",model.payAmount];
            self.priceLabel.textColor = DSColorFromHex(0xea6d6b);
        }
    }else if (_type ==2){
        if (model.memberPointRecordType ==0) {
            self.titleLabel.text = @"充值";
            self.priceLabel.text = [NSString stringWithFormat:@"+%@",model.memberPointChangePoint];
            self.priceLabel.textColor = DSColorFromHex(0xea6d6b);
        }else if (model.memberPointRecordType == 1){
            self.titleLabel.text = @"消费";
            self.priceLabel.text = [NSString stringWithFormat:@"-%@",model.memberPointChangePoint];
            self.priceLabel.textColor = DSColorFromHex(0x72BF34);
        }else if (model.memberPointRecordType ==2){
            self.titleLabel.text = @"退款";
            self.priceLabel.text = [NSString stringWithFormat:@"+%@",model.memberPointChangePoint];
            self.priceLabel.textColor = DSColorFromHex(0xea6d6b);
        }
    }
    self.contentLabel.text = [NSDate cStringFromTimestamp:model.systemCreateTime Formatter:@"yyyy.MM.dd HH:mm"];
}
@end
