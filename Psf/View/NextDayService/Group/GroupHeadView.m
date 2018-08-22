//
//  GroupHeadView.m
//  Psf
//
//  Created by 燕来秋mac9 on 2018/7/3.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "GroupHeadView.h"

@implementation GroupHeadView

-(UIImageView *)headImage{
    if (!_headImage) {
        _headImage = [[UIImageView alloc]init];
        _headImage.image = [UIImage imageNamed:@""];
        [_headImage.layer setCornerRadius:20];
        [_headImage.layer setMasksToBounds:YES];
    }
    return _headImage;
}
-(UIView *)bgView{
    if (!_bgView) {
        _bgView = [[UIView alloc]init];
        _bgView.backgroundColor = [UIColor whiteColor];
    }
    return _bgView;
}
-(UIView *)headView{
    if (!_headView) {
        _headView = [[UIView alloc]init];
        _headView.backgroundColor = [UIColor whiteColor];
        [_headView.layer setBorderColor:DSColorFromHex(0xDCDCDC).CGColor];
        [_headView.layer setBorderWidth:1];
    }
    return _headView;
}
-(UILabel *)nextLabel{
    if(!_nextLabel){
        _nextLabel = [[UILabel alloc]init];
        _nextLabel.textAlignment = NSTextAlignmentCenter;
        _nextLabel.text = @"热门推荐";
        _nextLabel.font = [UIFont systemFontOfSize:18];
        _nextLabel.textColor = DSColorFromHex(0x656565);
        _nextLabel.backgroundColor = [UIColor whiteColor];
    }
    return _nextLabel;
}
-(UILabel *)nameLabel{
    if(!_nameLabel){
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        
        _nameLabel.font = [UIFont systemFontOfSize:14];
        _nameLabel.textColor = DSColorFromHex(0x646464);
    }
    return _nameLabel;
}
-(UILabel *)shortLabel{
    if(!_shortLabel){
        _shortLabel = [[UILabel alloc]init];
        _shortLabel.textAlignment = NSTextAlignmentLeft;
        
        _shortLabel.font = [UIFont systemFontOfSize:11];
        _shortLabel.textColor = DSColorFromHex(0xB5B5B5);
        _shortLabel.backgroundColor = [UIColor whiteColor];
    }
    return _shortLabel;
}
-(UILabel *)pinLabel{
    if(!_pinLabel){
        _pinLabel = [[UILabel alloc]init];
        _pinLabel.textAlignment = NSTextAlignmentLeft;
        
        _pinLabel.font = [UIFont systemFontOfSize:12];
        _pinLabel.textColor = DSColorFromHex(0x646464);
    }
    return _pinLabel;
}
-(UILabel *)danLabel{
    if(!_danLabel){
        _danLabel = [[UILabel alloc]init];
        _danLabel.textAlignment = NSTextAlignmentLeft;
        _danLabel.text = @"单买价";
        _danLabel.font = [UIFont systemFontOfSize:12];
        _danLabel.textColor = DSColorFromHex(0xB5B5B5);
        _danLabel.backgroundColor = [UIColor whiteColor];
    }
    return _danLabel;
}
- (UILabel *)priceLabel{
    if(!_priceLabel){
        _priceLabel = [[UILabel alloc]init];
        _priceLabel.textAlignment = NSTextAlignmentLeft;
        
        _priceLabel.font = [UIFont systemFontOfSize:12];
        _priceLabel.textColor = DSColorFromHex(0xB5B5B5);
        _priceLabel.backgroundColor = [UIColor whiteColor];
    }
    return _priceLabel;
}
-(UILabel *)dateLabel{
    if(!_dateLabel){
        _dateLabel = [[UILabel alloc]init];
        _dateLabel.textAlignment = NSTextAlignmentCenter;
        _dateLabel.font = [UIFont systemFontOfSize:12];
        _dateLabel.textColor = DSColorFromHex(0x646464);
    }
    return _dateLabel;
}
-(UILabel *)lineLabel{
    if (!_lineLabel) {
        _lineLabel = [[UILabel alloc]init];
        _lineLabel.backgroundColor = DSColorFromHex(0xB5B5B5);
    }
    return _lineLabel;
}
-(UILabel *)goodLabel{
    if(!_goodLabel){
        _goodLabel = [[UILabel alloc]init];
        _goodLabel.textAlignment = NSTextAlignmentLeft;
        
        _goodLabel.font = [UIFont systemFontOfSize:14];
        _goodLabel.textColor = DSColorFromHex(0x646464);
        _goodLabel.numberOfLines = 2;
    }
    return _goodLabel;
}
-(UIImageView *)goodImage{
    if (!_goodImage) {
        _goodImage = [[UIImageView alloc]init];
        _goodImage.image = [UIImage imageNamed:@""];
    }
    return _goodImage;
}
-(UIButton *)submitBtn{
    if (!_submitBtn) {
        _submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_submitBtn.layer setCornerRadius:2];
        [_submitBtn.layer setMasksToBounds:YES];
        _submitBtn.backgroundColor = DSColorFromHex(0xFF4C4D);
        [_submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_submitBtn setTitle:@"邀请好友" forState:UIControlStateNormal];
        [_submitBtn addTarget:self action:@selector(pressSubmit:) forControlEvents:UIControlEventTouchUpInside];
        _submitBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    }
    return _submitBtn;
}
-(UILabel *)tuanLabel{
    if (!_tuanLabel) {
        _tuanLabel = [[UILabel alloc]init];
        _tuanLabel.backgroundColor = DSColorFromHex(0xFF4C4D);
        _tuanLabel.textColor = [UIColor whiteColor];
        _tuanLabel.text = @"团长";
        _tuanLabel.font = [UIFont systemFontOfSize:9];
        _tuanLabel.textAlignment = NSTextAlignmentCenter;
        [_tuanLabel.layer setCornerRadius:7];
        [_tuanLabel.layer setMasksToBounds:YES];
    }
    return _tuanLabel;
}
-(UIScrollView *)bgscrollow{
    if (!_bgscrollow) {
        _bgscrollow = [[UIScrollView alloc]init];
        _bgscrollow.delegate = self;
        _bgscrollow.frame = CGRectMake(0, 223, SCREENWIDTH, 50);
        _bgscrollow.showsVerticalScrollIndicator = NO;
        _bgscrollow.showsHorizontalScrollIndicator = NO;
        _bgscrollow.bounces = NO;
    }
   return  _bgscrollow;
}
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = DSColorFromHex(0xF0F0F0);
        [self setcortentLayout];
    }
    return self;
}
-(void)setcortentLayout{
    [self addSubview:self.bgView];
    [self.bgView addSubview:self.bgscrollow];
    [self.bgView addSubview:self.headView];
    [self addSubview:self.nextLabel];
    [self.bgView addSubview:self.headImage];
    [self.bgView addSubview:self.nameLabel];
    [self.bgView addSubview:self.shortLabel];
    [self.headView addSubview:self.goodImage];
    [self.headView addSubview:self.goodLabel];
    [self.headView addSubview:self.pinLabel];
    [self.headView addSubview:self.priceLabel];
    [self.headView addSubview:self.danLabel];
    [self.headView addSubview:self.lineLabel];
    [self.bgView addSubview:self.dateLabel];

    [self.bgView addSubview:self.submitBtn];
    [self.bgView addSubview:self.tuanLabel];
    [self.nextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.height.mas_equalTo(59);
    }];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        make.bottom.equalTo(self.nextLabel.mas_top).offset(-5);
    }];
    
    [self.headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgView).offset(15);
        make.right.equalTo(self.bgView).offset(-15);
        make.top.equalTo(self.bgView).offset(65);
        make.height.mas_equalTo(95);
    }];
    [self.headImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.bgView).offset(15);
        make.width.height.mas_equalTo(40);
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headImage.mas_right).offset(6);
        make.top.equalTo(self.bgView).offset(20);
    }];
    [self.shortLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headImage.mas_right).offset(6);
        make.top.equalTo(self.nameLabel.mas_bottom).offset(4);
    }];
    [self.goodImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.headView).offset(10);
        make.width.height.mas_equalTo(75);
    }];
    [self.goodLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.goodImage.mas_right).offset(11);
        make.right.equalTo(self.headView).offset(-29);
        make.top.equalTo(self.headView).offset(14);
    }];
    [self.pinLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.goodImage.mas_right).offset(11);
        make.top.equalTo(self.goodLabel.mas_bottom).offset(5);
    }];
    [self.danLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.goodImage.mas_right).offset(11);
        make.top.equalTo(self.pinLabel.mas_bottom).offset(4);
    }];
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.danLabel.mas_right).offset(10);
        make.top.equalTo(self.pinLabel.mas_bottom).offset(4);
    }];
    [self.lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.danLabel.mas_right).offset(10);
        make.centerY.equalTo(self.priceLabel);
        make.width.mas_equalTo(self.priceLabel.mas_width);
        make.height.mas_equalTo(1);
    }];
    [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headView.mas_bottom).offset(21);
        make.left.equalTo(self.bgView).offset(15);
        make.right.equalTo(self.bgView).offset(-15);
    }];
    [self.submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgView).offset(15);
        make.right.equalTo(self.bgView).offset(-15);
        make.bottom.equalTo(self.bgView.mas_bottom).offset(-20);
        make.height.mas_equalTo(36);
    }];

    
}
-(void)pressSubmit:(UIButton*)sender{
    self.subnitBtn(sender.tag);
}
-(void)setModel:(SpellGroupModel *)model{
    _model = model;
    SpellGroupModel *spellmodel = [model.grouponActivityMemberList firstObject];
    [self.headImage sd_setImageWithURL:[NSURL URLWithString:spellmodel.memberAvatarPath]placeholderImage:[UIImage imageNamed:@"mine_avater_55"]];
    _shortLabel.text = [NSString stringWithFormat:@"发起了%ld人团",model.grouponActivityMemberLimit];
    _nameLabel.text = spellmodel.memberNickName;
    NSString *url = [NSString stringWithFormat:@"%@%@",IMAGEHOST,model.productImagePath];
    [self.goodImage sd_setImageWithURL:[NSURL URLWithString:url]placeholderImage:[UIImage imageNamed:@"mine_avater_55"]];
    _goodLabel.text = model.productName;
    _pinLabel.text = [NSString stringWithFormat:@"%ld人拼购价   ¥%@",model.grouponActivityMemberLimit,model.grouponActivityPrice];
    _priceLabel.text = [NSString stringWithFormat:@"¥%@",model.productPrice];
    NSInteger count = model.grouponActivityMemberLimit-1;
    NSString *date = [NSDate getCountDownStringWithEndTime:[NSDate cStringFromTimestamp:_model.grouponActivityExpireTime Formatter:@"yyyy-MM-dd HH:mm:ss.0"]];
    self.dateLabel.text = [NSString stringWithFormat:@"还差%ld人拼团成功，剩余时间%@",count,date];
    NSTimer *timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
    [timer setFireDate:[NSDate distantPast]];
    NSInteger limit =model.grouponActivityMemberLimit;
    
    for (int i = 0; i<limit; i++) {
      UIImageView*  tuanImage = [[UIImageView alloc]init];
        [self.bgscrollow addSubview:tuanImage];
        [tuanImage.layer setCornerRadius:20];
        [tuanImage.layer setMasksToBounds:YES];
        if (limit<8) {
            tuanImage.frame = CGRectMake((SCREENWIDTH/2-25*limit+5)+i*50, 0, 40, 40);
        }else{
            tuanImage.frame = CGRectMake(15+i*50, 0, 40, 40);
        }
        
        if (i<model.grouponActivityMemberList.count) {
            if (i ==0) {
                [tuanImage.layer setBorderColor:DSColorFromHex(0xFF4C4D).CGColor];
                [tuanImage.layer setBorderWidth:2];
                 [tuanImage  sd_setImageWithURL:[NSURL URLWithString:spellmodel.memberAvatarPath]];
                self.tuanLabel.frame = CGRectMake(tuanImage.ctLeft+5, tuanImage.ctBottom-10, 27, 13);
                [_bgscrollow addSubview:self.tuanLabel];
            }else{
                SpellGroupModel *canmodel = model.grouponActivityMemberList[i];
                [tuanImage  sd_setImageWithURL:[NSURL URLWithString:canmodel.memberAvatarPath]placeholderImage:[UIImage imageNamed:@"mine_avater_55"]];

            }
            
            
        }else{
            tuanImage.image = [UIImage imageNamed:@"can_group"];
        }
        
    }
    self.bgscrollow.contentSize = CGSizeMake(50*model.grouponActivityMemberLimit+150, 50);
}
-(void)timerAction{
    NSInteger count = _model.grouponActivityMemberLimit-1;
    NSString *date = [NSDate getCountDownStringWithEndTime:[NSDate cStringFromTimestamp:_model.grouponActivityExpireTime Formatter:@"yyyy-MM-dd HH:mm:ss.0"]];
    self.dateLabel.text = [NSString stringWithFormat:@"还差%ld人拼团成功，剩余时间%@",count,date];
}
@end
