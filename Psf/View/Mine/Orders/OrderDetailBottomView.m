//
//  OrderDetailBottomView.m
//  Psf
//
//  Created by 燕来秋mac9 on 2018/6/28.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "OrderDetailBottomView.h"

@implementation OrderDetailBottomView

-(UIButton *)remindBtn{
    if (!_remindBtn) {
        _remindBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _remindBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_remindBtn addTarget:self action:@selector(pressPay) forControlEvents:UIControlEventTouchUpInside];
        [_remindBtn.layer setCornerRadius:2];
        [_remindBtn.layer setMasksToBounds:YES];
        [_remindBtn setTitleColor:DSColorFromHex(0x464646) forState:UIControlStateNormal];
        [_remindBtn.layer setBorderWidth:0.5];
        [_remindBtn.layer setBorderColor:DSColorFromHex(0x464646).CGColor];
    }
    return _remindBtn;
}
-(UIButton *)sendBtn{
    if (!_sendBtn) {
        _sendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _sendBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_sendBtn.layer setCornerRadius:2];
        [_sendBtn addTarget:self action:@selector(pressSend) forControlEvents:UIControlEventTouchUpInside];
        [_sendBtn.layer setMasksToBounds:YES];
        [_sendBtn setTitleColor:DSColorFromHex(0x464646) forState:UIControlStateNormal];
        [_sendBtn.layer setBorderWidth:0.5];
        [_sendBtn.layer setBorderColor:DSColorFromHex(0x464646).CGColor];
    }
    return _sendBtn;
}
-(UILabel *)payableLabel{
    if (!_payableLabel) {
        _payableLabel = [[UILabel alloc]init];
        _payableLabel.textAlignment = NSTextAlignmentLeft;
        _payableLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:15];
        _payableLabel.textColor = DSColorFromHex(0xFF4C4D);
        _payableLabel.text = @"";
    }
    return _payableLabel;
}
-(UILabel *)lineLabel{
    if (!_lineLabel) {
        _lineLabel = [[UILabel alloc]init];
        _lineLabel.backgroundColor = DSColorFromHex(0xDCDCDC);
    }
    return _lineLabel;
}
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setcornerLayout];
        self.backgroundColor = DSColorFromHex(0xFAFAFA);
    }
    return self;
}
-(void)setcornerLayout{
    [self addSubview:self.remindBtn];
    [self addSubview:self.lineLabel];
    [self addSubview:self.sendBtn];
    [self addSubview:self.payableLabel];
    [self.lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        make.height.mas_equalTo(0.5);
    }];
    [self.payableLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.left.equalTo(self).offset(15);
        make.height.mas_equalTo(49);
    }];
    [self.remindBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(39);
        make.right.equalTo(self).offset(-10);
        make.centerY.equalTo(self);
    }];
    [self.sendBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(39);
        make.right.equalTo(self.remindBtn.mas_left).offset(-10);
        make.centerY.equalTo(self);
    }];
}
-(void)setType:(NSInteger)type{
    _type = type;
}
-(void)setMemberId:(NSString *)memberId{
    _memberId = memberId;
}
-(void)setStatus:(OrderDetailRes*)status{
    _status = status;
    if (_type ==2) {
    switch (status.saleOrderStatus) {
        case 0:
        {
            
            [_remindBtn.layer setBorderColor:[UIColor clearColor].CGColor];
            [_remindBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [_remindBtn setBackgroundImage:[UIImage imageNamed:@"shopping_submit"] forState:UIControlStateNormal];
            [_remindBtn setTitle:@"付款" forState:UIControlStateNormal];
            [_sendBtn setTitle:@"取消订单" forState:UIControlStateNormal];
            _payableLabel.text = [NSString stringWithFormat:@"应付:￥%@",status.saleOrderPayAmount];
            
        }
            break;
        case 1:
        {
           
            
            [_remindBtn setTitle:@"提醒发货" forState:UIControlStateNormal];
            _sendBtn.hidden = YES;
            
        }
            break;
        case 2:
        {
            
           
                [_remindBtn setTitle:@"自提码" forState:UIControlStateNormal];
           
           
            _sendBtn.hidden = YES;
          
        }
            break;
        case 3:
        {
            
            _sendBtn.hidden = YES;
            [_remindBtn setTitle:@"评价" forState:UIControlStateNormal];
            
           
        }
            break;
        case 4:
        {
           
            
            
            _sendBtn.hidden = YES;
        }
            break;
        case 5:
        {
            
            [_remindBtn setTitle:@"再次购买" forState:UIControlStateNormal];
            _sendBtn.hidden = YES;
        }
            break;
        case 6:
        {
          
            _sendBtn.hidden = YES;
            [_remindBtn setTitle:@"删除订单" forState:UIControlStateNormal];
        }
            break;
        case 7:
        {
            
            _sendBtn.hidden = YES;
            _remindBtn.hidden = YES;
        }
            break;
        default:
            break;
      }
    }else{
        _sendBtn.hidden = YES;
        _remindBtn.hidden = NO;
        if ([[UserCacheBean share].userInfo.roleId integerValue] ==1) {
             [_remindBtn setTitle:@"发货" forState:UIControlStateNormal];
        }else if([[UserCacheBean share].userInfo.roleId integerValue] ==0&&self.memberId.length>0){
             [_remindBtn setTitle:@"用户自提" forState:UIControlStateNormal];
        }else if([[UserCacheBean share].userInfo.roleId integerValue] ==0&&self.memberId.length==0){
            [_remindBtn setTitle:@"门店收货" forState:UIControlStateNormal];
        }
    }
}
-(void)pressPay{
  if (_type ==2) {
    switch (_status.saleOrderStatus) {
        case 0:
        {
            
            self.payBlock(_status);
            
        }
            break;
        case 1:
        {
            
            
            self.remindBlock(_status);
            
        }
            break;
        case 2:
        {
            self.zitiBlock(_status);
            
        }
            break;
        case 3:
        {
            
            self.evaBlock(_status);
            
            
        }
            break;
        case 4:
        {
    
            _sendBtn.hidden = YES;
        }
            break;
        case 5:
        {
            self.buyBlock(_status);
        }
            break;
        case 6:
        {
            
            self.deleteBlock(_status);
        }
            break;
        case 7:
        {
            
            _sendBtn.hidden = YES;
            _remindBtn.hidden = YES;
        }
            break;
        default:
            break;
      }
    }else{
        self.sureBlock(_status);
    }
}
-(void)pressSend{
    if (_status.saleOrderStatus ==0) {
        self.cancleBlock(_status);
    }
}
@end
