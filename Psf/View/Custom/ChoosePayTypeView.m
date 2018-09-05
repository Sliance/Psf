//
//  ChoosePayTypeView.m
//  Psf
//
//  Created by 燕来秋mac9 on 2018/9/5.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "ChoosePayTypeView.h"

@implementation ChoosePayTypeView


-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.yinView];
        [self addSubview:self.bgview];
        [self.bgview addSubview:self.wechartimage];
        [self.bgview addSubview:self.alipayimage];
        [self.bgview addSubview:self.titleLabel];
        [self.bgview addSubview:self.linelabel];
        [self.bgview addSubview:self.closeBtn];
        [self.bgview addSubview:self.sureBtn];
        [self.bgview addSubview:self.weixinLabel];
        [self.bgview addSubview:self.alipayLabel];
        [self.bgview addSubview:self.wxBtn];
        [self.bgview addSubview:self.alipayBtn];
        [self.yinView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.equalTo(self);
        }];
        [self.bgview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(300);
            make.height.mas_equalTo(300);
            make.centerX.equalTo(self);
            make.centerY.equalTo(self);
        }];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(self.bgview);
            make.height.mas_equalTo(40);
        }];
        [self.wechartimage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.bgview).offset(30);
            make.top.equalTo(self.bgview).offset(80);
            make.width.height.mas_equalTo(30);
        }];
        [self.alipayimage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.bgview).offset(30);
            make.top.equalTo(self.wechartimage.mas_bottom).offset(30);
            make.width.height.mas_equalTo(30);
        }];
        [self.weixinLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.wechartimage.mas_right).offset(20);
            make.centerY.equalTo(self.wechartimage);
        }];
        [self.alipayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.alipayimage.mas_right).offset(20);
            make.centerY.equalTo(self.alipayimage);
        }];
        [self.wxBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.bgview).offset(-20);
            make.centerY.equalTo(self.wechartimage);
            make.width.height.mas_equalTo(30);
        }];
        [self.alipayBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.bgview).offset(-20);
            make.centerY.equalTo(self.alipayimage);
            make.width.height.mas_equalTo(30);
        }];
        [self.linelabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.bgview);
            make.bottom.equalTo(self.bgview.mas_bottom).offset(-40);
            make.height.mas_equalTo(1);
        }];
        [self.sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.bgview);
            make.bottom.equalTo(self.bgview.mas_bottom);
            make.height.mas_equalTo(40);
        }];
        [self.closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.equalTo(self.bgview);
            make.width.height.mas_equalTo(40);
        }];
        
        
    }
    return self;
}
-(UIView *)yinView{
    if (!_yinView) {
        _yinView = [[UIView alloc]init];
        _yinView.backgroundColor = DSColorAlphaFromHex(0x000000, 0.3);
    }
    return _yinView;
}
-(UIView *)bgview{
    if (!_bgview) {
        _bgview = [[UIView alloc]init];
        _bgview.backgroundColor = [UIColor whiteColor];
        [_bgview.layer setCornerRadius:8];
        [_bgview.layer setMasksToBounds:YES];
    }
    return _bgview;
}
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.text = @"请选择付款方式";
        _titleLabel.font = [UIFont systemFontOfSize:15];
        _titleLabel.textColor = DSColorFromHex(0x464646);
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}
-(UILabel *)linelabel{
    if (!_linelabel) {
        _linelabel = [[UILabel alloc]init];
        _linelabel.backgroundColor = DSColorFromHex(0xF0F0F0);
    }
    return _linelabel;
}
-(UIButton *)closeBtn{
    if (!_closeBtn) {
        _closeBtn   = [UIButton buttonWithType:UIButtonTypeCustom];
        [_closeBtn setImage:[UIImage imageNamed:@"date_dismiss"] forState:UIControlStateNormal];
        _closeBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_closeBtn addTarget:self action:@selector(pressClose) forControlEvents:UIControlEventTouchUpInside];
        [_closeBtn setTitleColor:DSColorFromHex(0x464646) forState:UIControlStateNormal];
    }
    return _closeBtn;
}
-(UIButton *)sureBtn{
    if (!_sureBtn) {
        _sureBtn   = [UIButton buttonWithType:UIButtonTypeCustom];
        [_sureBtn setTitle:@"确定" forState:UIControlStateNormal];
        _sureBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_sureBtn addTarget:self action:@selector(pressSure) forControlEvents:UIControlEventTouchUpInside];
        [_sureBtn setTitleColor:DSColorFromHex(0x464646) forState:UIControlStateNormal];
    }
    return _sureBtn;
}
-(UIImageView *)wechartimage{
    if (!_wechartimage) {
        _wechartimage = [[UIImageView alloc]init];
        _wechartimage.image = [UIImage imageNamed:@"wechat_icon"];
    }
    return _wechartimage;
}
-(UIImageView *)alipayimage{
    if (!_alipayimage) {
        _alipayimage = [[UIImageView alloc]init];
        _alipayimage.image = [UIImage imageNamed:@"aiplay"];
    }
    return _alipayimage;
}
-(UILabel *)weixinLabel{
    if (!_weixinLabel) {
        _weixinLabel = [[UILabel alloc]init];
        _weixinLabel.text = @"微信支付";
        _weixinLabel.font = [UIFont systemFontOfSize:15];
        _weixinLabel.textColor = DSColorFromHex(0x464646);
        _weixinLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _weixinLabel;
}
-(UILabel *)alipayLabel{
    if (!_alipayLabel) {
        _alipayLabel = [[UILabel alloc]init];
        _alipayLabel.text = @"支付宝支付";
        _alipayLabel.font = [UIFont systemFontOfSize:15];
        _alipayLabel.textColor = DSColorFromHex(0x464646);
        _alipayLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _alipayLabel;
}
-(UIButton *)wxBtn{
    if (!_wxBtn) {
        _wxBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_wxBtn setImage:[UIImage imageNamed:@"shopping_normal"] forState:UIControlStateNormal];
        [_wxBtn setImage:[UIImage imageNamed:@"shopping_selected"] forState:UIControlStateSelected];
        _wxBtn.selected = YES;
        _tmpBtn = _wxBtn;
        [_wxBtn addTarget:self action:@selector(pressBtn:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _wxBtn;
}
-(UIButton *)alipayBtn{
    if (!_alipayBtn) {
        _alipayBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_alipayBtn setImage:[UIImage imageNamed:@"shopping_normal"] forState:UIControlStateNormal];
        [_alipayBtn setImage:[UIImage imageNamed:@"shopping_selected"] forState:UIControlStateSelected];
         [_alipayBtn addTarget:self action:@selector(pressBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _alipayBtn;
}
-(void)pressSure{
    if (_tmpBtn ==_wxBtn) {
        self.sureBlock(@"2");
    }else if (_tmpBtn ==_alipayBtn){
        self.sureBlock(@"3");
    }
}
-(void)pressClose{
    self.closeBlock();
}
-(void)pressBtn:(UIButton*)sender{
    _wxBtn.selected = NO;
    if (_tmpBtn == nil){
        sender.selected = YES;
        _tmpBtn = sender;
    }else if (_tmpBtn !=nil && _tmpBtn == sender){
        sender.selected = YES;
        
    }else if (_tmpBtn!= sender && _tmpBtn!=nil){
        _tmpBtn.selected = NO;
        sender.selected = YES;
        _tmpBtn = sender;
    }
   
}
@end
