//
//  FillOrderTableViewCell.m
//  Psf
//
//  Created by 燕来秋mac9 on 2018/6/29.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "FillOrderTableViewCell.h"

@implementation FillOrderTableViewCell

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
-(void)updatePayBtn{
    [_payBtn setTitleColor:DSColorFromHex(0x464646) forState:UIControlStateNormal];
    [_payBtn.layer setBorderColor:DSColorFromHex(0x464646).CGColor];
    [_payBtn.layer setBorderWidth:0.5];
    [_payBtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
}

-(void)setcornetLayout{
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.bgView];
    [self.bgView addSubview:self.orderNumLabel];
    [self.bgView addSubview:self.topline];
    [self.bgView addSubview:self.headImage];
    [self.bgView addSubview:self.headImageTwo];
    [self.bgView addSubview:self.headImageThree];
    [self.bgView addSubview:self.nameLabel];
    [self.bgView addSubview:self.countLabel];
    [self.bgView addSubview:self.weightLabel];
    [self.bgView addSubview:self.payableLabel];

    
    self.bgView.frame = CGRectMake(0, 0, SCREENWIDTH, self.viewSize.height);

    self.topline.frame = CGRectMake(15, 0, SCREENWIDTH-15, 0.5);
    self.headImage.frame = CGRectMake(15, 15, 90, 90);
    self.nameLabel.frame = CGRectMake(self.headImage.ctRight+10, 20, 160, 14);
    self.countLabel.frame = CGRectMake(SCREENWIDTH-60,20,45, 14);
    self.weightLabel.frame = CGRectMake(self.headImage.ctRight+10, self.nameLabel.ctBottom+10, 160, 12);
    self.payableLabel.frame = CGRectMake(self.headImage.ctRight+10, self.weightLabel.ctBottom+33, 120, 12);
   
}
-(UIImageView *)headImage{
    if (!_headImage) {
        _headImage = [[UIImageView alloc]init];
        _headImage.image = [UIImage imageNamed:@""];
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
        _nameLabel.text = @"";
    }
    return _nameLabel;
}

-(UILabel *)weightLabel{
    if (!_weightLabel) {
        _weightLabel = [[UILabel alloc]init];
        _weightLabel.textAlignment = NSTextAlignmentLeft;
        _weightLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:12];
        _weightLabel.textColor = DSColorFromHex(0x787878);
        _weightLabel.text = @"";
    }
    return _weightLabel;
}

-(UILabel *)countLabel{
    if (!_countLabel) {
        _countLabel = [[UILabel alloc]init];
        _countLabel.textAlignment = NSTextAlignmentRight;
        _countLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:15];
        _countLabel.textColor = DSColorFromHex(0x464646);
        _countLabel.text = @"";
    }
    return _countLabel;
}
-(UILabel *)orderNumLabel{
    if (!_orderNumLabel) {
        _orderNumLabel = [[UILabel alloc]init];
        _orderNumLabel.textAlignment = NSTextAlignmentLeft;
        _orderNumLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:15];
        _orderNumLabel.textColor = DSColorFromHex(0x464646);
        _orderNumLabel.text = @"订单编号:";
    }
    return _orderNumLabel;
}
-(UILabel *)payableLabel{
    if (!_payableLabel) {
        _payableLabel = [[UILabel alloc]init];
        _payableLabel.textAlignment = NSTextAlignmentLeft;
        _payableLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:15];
        _payableLabel.textColor = DSColorFromHex(0x464646);
        _payableLabel.text = @"";
    }
    return _payableLabel;
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

-(void)setModel:(CartProductModel *)model{
    _model = model;
    NSString *url = [NSString stringWithFormat:@"%@%@",IMAGEHOST,model.productImagePath];
    [self.headImage sd_setImageWithURL:[NSURL URLWithString:url]];
    self.nameLabel.text = model.productName;
    self.payableLabel.text = [NSString stringWithFormat:@"￥%@",model.productStorePrice];
    self.weightLabel.text = model.productUnit;
    self.countLabel.text = [NSString stringWithFormat:@"X%@",model.productQuantity];
}
-(void)setRes:(GoodDetailRes *)res{
    _res = res;
    NSString *url = [NSString stringWithFormat:@"%@%@",IMAGEHOST,res.productImagePath];
    [self.headImage sd_setImageWithURL:[NSURL URLWithString:url]];
    self.nameLabel.text = res.productName;
    self.payableLabel.text = [NSString stringWithFormat:@"￥%@",res.productPrice];
    self.weightLabel.text = res.productUnit;
    self.countLabel.text = [NSString stringWithFormat:@"X%ld",(long)res.saleOrderProductQty];
}
@end
