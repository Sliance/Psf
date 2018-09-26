//
//  MineHeadView.m
//  Psf
//
//  Created by 燕来秋mac9 on 2018/6/20.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "MineHeadView.h"

@implementation MineHeadView

-(UIButton *)headbtn{
    if (!_headbtn) {
        _headbtn = [[UIButton alloc]init];
        [_headbtn.layer setMasksToBounds:YES];
        [_headbtn.layer setCornerRadius:35];
        [_headbtn addTarget:self action:@selector(pressBtn:) forControlEvents:UIControlEventTouchUpInside];
        [_headbtn setBackgroundImage:[UIImage imageNamed:@"mine_avater_75"] forState:UIControlStateNormal];
    }
    return _headbtn;
}
-(UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        _nameLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:18];
        _nameLabel.textColor = [UIColor colorWithRed:70.0001/255.0 green:70.0001/255.0 blue:70.0001/255.0 alpha:1];
        _nameLabel.text = @"";
    }
    return _nameLabel;
}
-(UILabel *)lineLabel{
    if (!_lineLabel) {
        _lineLabel = [[UILabel alloc]init];
        _lineLabel.backgroundColor = [UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1];
    }
    return _lineLabel;
}
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self setcornerLayout];
    }
    return self;
}
-(void)setcornerLayout{
    [self addSubview:self.headbtn];
    [self addSubview:self.nameLabel];
    [self addSubview:self.lineLabel];
    [self.headbtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self).offset(31);
        make.width.height.mas_equalTo(70);
        
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self.headbtn.mas_bottom).offset(15);
       
    }];
    [self.lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.bottom.equalTo(self);
        make.height.mas_equalTo(5);
        
    }];
}
-(void)pressBtn:(UIButton*)sender{
    self.skipBlock(sender.tag);
}

-(void)setResult:(MineInformationReq *)result{
    _result = result;
    UIImageView *image = [[UIImageView alloc]init];
    if (result.memberAvatarPath.length>0) {
        [self.headbtn setBackgroundImageWithURL:[NSURL URLWithString:result.memberAvatarPath] forState:UIControlStateNormal options:YYWebImageOptionAllowBackgroundTask];
    }else{
         [_headbtn setBackgroundImage:[UIImage imageNamed:@"mine_avater_70"] forState:UIControlStateNormal];
    }
    [image sd_setImageWithURL:[NSURL URLWithString:result.memberAvatarPath]];
    
    if([UserCacheBean share].userInfo.token.length<1){
        self.nameLabel.text = @"登录/注册";
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tologin)];
        self.nameLabel.userInteractionEnabled = YES;
        [self.nameLabel addGestureRecognizer:tap];
    }else{
       self.nameLabel.text = result.memberNickName;
    }
}
-(void)tologin{
    self.tologinBlock();
}
@end
