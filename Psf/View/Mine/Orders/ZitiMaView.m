//
//  ZitiMaView.m
//  Psf
//
//  Created by 燕来秋mac9 on 2018/8/20.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "ZitiMaView.h"

@implementation ZitiMaView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.yinView];
        [self addSubview:self.bgview];
        [self.bgview addSubview:self.codeimage];
        [self.bgview addSubview:self.titleLabel];
        [self.bgview addSubview:self.linelabel];
        [self.bgview addSubview:self.closeBtn];
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
        [self.linelabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.bgview);
            make.bottom.equalTo(self.bgview.mas_bottom).offset(-40);
            make.height.mas_equalTo(1);
        }];
        [self.closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.bgview);
            make.bottom.equalTo(self.bgview.mas_bottom);
            make.height.mas_equalTo(40);
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
        _titleLabel.text = @"扫描提货码";
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
        [_closeBtn setTitle:@"关闭" forState:UIControlStateNormal];
        _closeBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_closeBtn addTarget:self action:@selector(pressClose) forControlEvents:UIControlEventTouchUpInside];
        [_closeBtn setTitleColor:DSColorFromHex(0x464646) forState:UIControlStateNormal];
    }
    return _closeBtn;
}
-(UIImageView *)codeimage{
    if (!_codeimage) {
        _codeimage = [[UIImageView alloc]initWithFrame:CGRectMake(50, 50, 200, 200)];
        
    }
    return _codeimage;
}

-(void)setSaleOrderId:(NSString *)saleOrderId{
    _saleOrderId = saleOrderId;
    [self requestData];
}
-(void)requestData{
    UnifiedOrderReq *req = [[UnifiedOrderReq alloc]init];
    req.appId = @"993335466657415169";
    req.timestamp = @"529675086";
    req.token = [UserCacheBean share].userInfo.token;
    req.platform = @"ios";
    req.saleOrderId = _saleOrderId;
    [[OrderServiceApi share]getZiTiWithParam:req response:^(id response) {
        if (response) {
            NSString *url = [NSString stringWithFormat:@"%@%@",DPHOST,response[@"filePath"]];
            [self.codeimage sd_setImageWithURL:[NSURL URLWithString:url]];
        }
    }];
}

-(void)pressClose{
    self.closeBlock();
}

@end
