//
//  WaitPaymentCell.m
//  Psf
//
//  Created by 燕来秋mac9 on 2018/6/27.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "WaitPaymentCell.h"

@implementation WaitPaymentCell

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
    [_payBtn.layer setBorderColor:DSColorMake(180, 180, 180).CGColor];
    [_payBtn.layer setBorderWidth:0.5];
    [_payBtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
}
-(void)setOrdertype:(ORDERSTYPE)ordertype{
    _ordertype = ordertype;
    switch (ordertype) {
        case ORDERSTYPEWaitPayment:
            {
                [_payBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                [_payBtn setBackgroundImage:[UIImage imageNamed:@"shopping_submit"] forState:UIControlStateNormal];
                _sendBtn.hidden = YES;
            }
            break;
        case ORDERSTYPEWaitDeliver:
        {
            [self updatePayBtn];
            [_payBtn setTitle:@"提醒发货" forState:UIControlStateNormal];
            _sendBtn.hidden = YES;
        }
            break;
        case ORDERSTYPEWaitReceive:
        {
            [self updatePayBtn];
            [_payBtn setTitle:@"送达日历" forState:UIControlStateNormal];
            _sendBtn.hidden = NO;
        }
            break;
        case ORDERSTYPEWaitEvaluate:
        {
            _sendBtn.hidden = NO;
            [self updatePayBtn];
            [_payBtn setTitleColor:DSColorFromHex(0xFF4C4D) forState:UIControlStateNormal];
            [_payBtn.layer setBorderColor:DSColorFromHex(0xFF4C4D).CGColor];
            [_payBtn setTitle:@"评价" forState:UIControlStateNormal];
            [_sendBtn setTitle:@"再次购买" forState:UIControlStateNormal];
        }
            break;
        default:
            break;
    }
}
-(void)setIsMultiSelect:(BOOL)isMultiSelect{
    _isMultiSelect = isMultiSelect;
    if (isMultiSelect ==YES) {
        _headImageTwo.hidden = NO;
        _headImageThree.hidden = NO;
        _nameLabel.hidden = YES;
        _weightLabel.hidden = YES;
    }else{
        _headImageTwo.hidden = YES;
        _headImageThree.hidden = YES;
        _nameLabel.hidden = NO;
        _weightLabel.hidden = NO;
    }
}
-(void)setcornetLayout{
    self.backgroundColor = DSColorFromHex(0xF0F0F0);
    [self addSubview:self.bgView];
    [self.bgView addSubview:self.orderNumLabel];
    [self.bgView addSubview:self.topline];
    [self.bgView addSubview:self.bottomline];
    [self.bgView addSubview:self.headImage];
    [self.bgView addSubview:self.headImageTwo];
    [self.bgView addSubview:self.headImageThree];
    [self.bgView addSubview:self.nameLabel];
    [self.bgView addSubview:self.countLabel];
    [self.bgView addSubview:self.weightLabel];
    [self.bgView addSubview:self.payableLabel];
    [self.bgView addSubview:self.statusLabel];
    [self.bgView addSubview:self.payBtn];
    [self.bgView addSubview:self.sendBtn];
    
    self.bgView.frame = CGRectMake(0, 5, SCREENWIDTH, 197);
    self.orderNumLabel.frame = CGRectMake(15, 0, SCREENWIDTH-90, 44);
    self.topline.frame = CGRectMake(15, 44, SCREENWIDTH-15, 0.5);
    self.bottomline.frame = CGRectMake(15, 150, SCREENWIDTH-15, 0.5);
    self.headImage.frame = CGRectMake(15, 60, 75, 75);
    self.headImageTwo.frame = CGRectMake(100, 60, 75, 75);
    self.headImageThree.frame = CGRectMake(190, 60, 75, 75);
    self.nameLabel.frame = CGRectMake(101, 79, 160, 14);
    self.countLabel.frame = CGRectMake(SCREENWIDTH-60,79,45, 14);
    self.weightLabel.frame = CGRectMake(101, self.nameLabel.ctBottom+10, 160, 12);
    self.payableLabel.frame = CGRectMake(15, 151, 120, 44);
    self.statusLabel.frame = CGRectMake(SCREENWIDTH-85,self.nameLabel.ctBottom+10,70, 12);
    self.payBtn.frame = CGRectMake(SCREENWIDTH-105,156,90, 34);
    self.sendBtn.frame = CGRectMake(SCREENWIDTH-205,156,90, 34);
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
-(UIImageView *)headImageTwo{
    if (!_headImageTwo) {
        _headImageTwo = [[UIImageView alloc]init];
        _headImageTwo.image = [UIImage imageNamed:@""];
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
        _headImageThree.image = [UIImage imageNamed:@""];
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
-(UILabel *)statusLabel{
    if (!_statusLabel) {
        _statusLabel = [[UILabel alloc]init];
        _statusLabel.textAlignment = NSTextAlignmentRight;
        _statusLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:12];
        _statusLabel.textColor = DSColorFromHex(0xFF4C4D);
//        _statusLabel.text = @"待付款";
    }
    return _statusLabel;
}
-(UILabel *)countLabel{
    if (!_countLabel) {
        _countLabel = [[UILabel alloc]init];
        _countLabel.textAlignment = NSTextAlignmentRight;
        _countLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:15];
        _countLabel.textColor = DSColorFromHex(0x464646);
//        _countLabel.text = @"X2";
    }
    return _countLabel;
}
-(UILabel *)orderNumLabel{
    if (!_orderNumLabel) {
        _orderNumLabel = [[UILabel alloc]init];
        _orderNumLabel.textAlignment = NSTextAlignmentLeft;
        _orderNumLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:15];
        _orderNumLabel.textColor = DSColorFromHex(0x464646);
//        _orderNumLabel.text = @"订单编号：41235323";
    }
    return _orderNumLabel;
}
-(UILabel *)payableLabel{
    if (!_payableLabel) {
        _payableLabel = [[UILabel alloc]init];
        _payableLabel.textAlignment = NSTextAlignmentLeft;
        _payableLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:15];
        _payableLabel.textColor = DSColorFromHex(0x464646);
       
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
-(UILabel *)bottomline{
    if (!_bottomline) {
        _bottomline = [[UILabel alloc]init];
        _bottomline.backgroundColor = DSColorFromHex(0xF0F0F0);
    }
    return _bottomline;
}
-(UIButton *)payBtn{
    if (!_payBtn) {
        _payBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _payBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_payBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_payBtn setBackgroundImage:[UIImage imageNamed:@"shopping_submit"] forState:UIControlStateNormal];
        [_payBtn setTitle:@"" forState:UIControlStateNormal];
        [_payBtn.layer setCornerRadius:2];
        [_payBtn addTarget:self action:@selector(pressPay) forControlEvents:UIControlEventTouchUpInside];
        [_payBtn.layer setMasksToBounds:YES];
    }
    return _payBtn;
}
-(UIButton *)sendBtn{
    if (!_sendBtn) {
        _sendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _sendBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_sendBtn setTitle:@"查看物流" forState:UIControlStateNormal];
        [_sendBtn.layer setCornerRadius:2];
        _sendBtn.hidden = YES;
        [_sendBtn.layer setMasksToBounds:YES];
        [_sendBtn setTitleColor:DSColorFromHex(0x464646) forState:UIControlStateNormal];
        [_sendBtn.layer setBorderWidth:0.5];
        [_sendBtn addTarget:self action:@selector(pressSend) forControlEvents:UIControlEventTouchUpInside];
        [_sendBtn.layer setBorderColor:DSColorMake(180, 180, 180).CGColor];
    }
    return _sendBtn;
}
-(void)pressPay{
    switch (_model.saleOrderStatus) {
        case 0:
        {
            
            self.payBlock(_model);
        }
            break;
        case 1:
        {
            self.remindBlock(_model);
        }
            break;
        case 2:
        {
             if (_model.saleOrderReceiveType ==0) {
               self.zitiBlock(_model);
             }else if (_model.saleOrderReceiveType ==1) {
                 self.sureBlock(_model);
             }
        }
            break;
        case 3:
        {
            self.evaBlock(_model);
        }
            break;
        case 4:
        {
            self.remindBlock(_model);
        }
            break;
        case 5:
        {
             self.buyBlock(_model);
        }
            break;
        case 6:
        {
            self.deleteBlock(_model);
        }
            break;
        case 7:
        {
           
        }
            break;
        default:
            break;
    }
}
-(void)pressSend{
    switch (_model.saleOrderStatus) {
        case 0:
        {
            
            
        }
            break;
        case 1:
        {
            if ([_model.saleOrderType isEqualToString:@"groupon"]) {
                self.groupBlock(_model);
            }
        }
            break;
        case 2:
        {
            self.logisticsBlock(_model);
        }
            break;
        case 3:
        {
            self.buyBlock(_model);
        }
            break;
        case 4:
        {
            
        }
            break;
        case 5:
        {
            
        }
            break;
        case 6:
        {
            
        }
            break;
        case 7:
        {
            
        }
            break;
        default:
            break;
    }
}
-(void)setModel:(OrderListRes *)model{
    _model = model;
    
    if (model.saleOrderReceiveType ==0) {
         _orderNumLabel.text = [NSString stringWithFormat:@"订单编号：%@(自提)",model.saleOrderId];
    }else if(model.saleOrderReceiveType ==1){
         _orderNumLabel.text = [NSString stringWithFormat:@"订单编号：%@",model.saleOrderId];
    }
    if (model.saleOrderProductList.count==1 ) {
        _headImageTwo.hidden = YES;
        _headImageThree.hidden = YES;
        _nameLabel.hidden = NO;
        _weightLabel.hidden = NO;
        CartProductModel *carmodel = [model.saleOrderProductList firstObject];
        NSString *url = [NSString stringWithFormat:@"%@%@",IMAGEHOST,carmodel.productImagePath];
        [self.headImage sd_setImageWithURL:[NSURL URLWithString:url]];
        self.nameLabel.text = carmodel.productName;
        self.weightLabel.text = carmodel.productUnit;
        self.countLabel.text = [NSString stringWithFormat:@"X%@",model.saleOrderTotalQuantity];
    }else if (model.saleOrderProductList.count ==2){
        _headImageTwo.hidden = NO;
        _headImageThree.hidden = YES;
        _nameLabel.hidden = YES;
        _weightLabel.hidden = YES;
        CartProductModel *carmodel = [model.saleOrderProductList firstObject];
        NSString *url = [NSString stringWithFormat:@"%@%@",IMAGEHOST,carmodel.productImagePath];
        [self.headImage sd_setImageWithURL:[NSURL URLWithString:url]];
        CartProductModel *carmodel2 = model.saleOrderProductList[1];
        NSString *url2 = [NSString stringWithFormat:@"%@%@",IMAGEHOST,carmodel2.productImagePath];
        [self.headImageTwo sd_setImageWithURL:[NSURL URLWithString:url2]];
        _countLabel.text = [NSString stringWithFormat:@"共%@件",model.saleOrderTotalQuantity];
    }else if(model.saleOrderProductList.count>2){
        _headImageTwo.hidden = NO;
        _headImageThree.hidden = NO;
        _nameLabel.hidden = YES;
        _weightLabel.hidden = YES;
        CartProductModel *carmodel = [model.saleOrderProductList firstObject];
        NSString *url = [NSString stringWithFormat:@"%@%@",IMAGEHOST,carmodel.productImagePath];
        [self.headImage sd_setImageWithURL:[NSURL URLWithString:url]];
        CartProductModel *carmodel2 = model.saleOrderProductList[1];
        NSString *url2 = [NSString stringWithFormat:@"%@%@",IMAGEHOST,carmodel2.productImagePath];
        [self.headImageTwo sd_setImageWithURL:[NSURL URLWithString:url2]];
        CartProductModel *carmodel3 = model.saleOrderProductList[2];
        NSString *url3 = [NSString stringWithFormat:@"%@%@",IMAGEHOST,carmodel3.productImagePath];
        [self.headImageThree sd_setImageWithURL:[NSURL URLWithString:url3]];
        _countLabel.text = [NSString stringWithFormat:@"共%@件",model.saleOrderTotalQuantity];
        
    }
    _payableLabel.text = [NSString stringWithFormat:@"应付:￥%@",model.saleOrderPayAmount];
    switch (model.saleOrderStatus) {
        case 0:
            {
             _statusLabel.text = @"待付款";
                 [_payBtn.layer setBorderColor:[UIColor clearColor].CGColor];
                [_payBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                [_payBtn setBackgroundImage:[UIImage imageNamed:@"shopping_submit"] forState:UIControlStateNormal];
                 [_payBtn setTitle:@"付款" forState:UIControlStateNormal];
                
                
                _sendBtn.hidden = YES;
                _payBtn.hidden = NO;
            }
            break;
        case 1:
        {
          _statusLabel.text = @"待发货";
            [self updatePayBtn];
            [_payBtn setTitle:@"提醒发货" forState:UIControlStateNormal];
            if ([model.saleOrderType isEqualToString:@"groupon"]) {
                _sendBtn.hidden = NO;
                [_sendBtn setTitle:@"拼团详情" forState:UIControlStateNormal];
            }else{
                _sendBtn.hidden = YES;
            }
            _payBtn.hidden = NO;
            
        }
            break;
        case 2:
        {
          _statusLabel.text = @"待收货";
            if (model.saleOrderReceiveType ==0) {
                [_payBtn setTitle:@"自提码" forState:UIControlStateNormal];
            }else if (model.saleOrderReceiveType ==1){
                [_payBtn setTitle:@"确认收货" forState:UIControlStateNormal];
            }
            _sendBtn.hidden = YES;
            _payBtn.hidden = NO;
            
        }
            break;
        case 3:
        {
           _statusLabel.text = @"交易成功";
            _sendBtn.hidden = NO;
            [self updatePayBtn];
            [_payBtn setTitleColor:DSColorFromHex(0xFF4C4D) forState:UIControlStateNormal];
            [_payBtn.layer setBorderColor:DSColorFromHex(0xFF4C4D).CGColor];
            [_payBtn setTitle:@"评价" forState:UIControlStateNormal];
            [_sendBtn setTitle:@"再次购买" forState:UIControlStateNormal];
            _payBtn.hidden = NO;
            
        }
            break;
        case 4:
        {
            _statusLabel.text = @"退款/售后";
            
            _sendBtn.hidden = YES;
            _payBtn.hidden = YES;
        }
            break;
        case 5:
        {
            _statusLabel.text = @"已取消";
            [self updatePayBtn];
            [_payBtn setTitle:@"再次购买" forState:UIControlStateNormal];
            _sendBtn.hidden = YES;
            _payBtn.hidden = NO;
        }
            break;
        case 6:
        {
            _statusLabel.text = @"已完成";
            _sendBtn.hidden = YES;
            [self updatePayBtn];
            [_payBtn setTitle:@"删除订单" forState:UIControlStateNormal];
            _payBtn.hidden = NO;
        }
            break;
        case 7:
        {
            _statusLabel.text = @"门店已收货";
            _sendBtn.hidden = YES;
            _payBtn.hidden = YES;
        }
            break;
        default:
            break;
    }
   
    
}
@end
