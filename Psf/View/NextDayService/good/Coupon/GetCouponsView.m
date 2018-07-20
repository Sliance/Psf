//
//  GetCouponsView.m
//  Psf
//
//  Created by 燕来秋mac9 on 2018/6/29.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "GetCouponsView.h"

@implementation GetCouponsView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setCornerLayout];
    }
    return self;
}
-(void)setCornerLayout{
    self.backgroundColor = DSColorAlphaFromHex(0x000000, 0.3);
    [self addSubview:self.bgView];
    [self.bgView addSubview:self.titleLabel];
    [self.bgView addSubview:self.tableView];
    [self.bgView addSubview:self.finishBtn];
    [self addSubview:self.topView];
    self.topView.frame = CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT-64-361);
    self.bgView.frame = CGRectMake(0, SCREENHEIGHT-64-361, SCREENWIDTH, 361);
    self.titleLabel.frame = CGRectMake(0, 0, SCREENWIDTH, 49);
    self.finishBtn.frame = CGRectMake(15, 310, SCREENWIDTH-30, 36);
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pressFinishBtn)];
    [self.topView addGestureRecognizer:tap];
}
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.text = @"领取优惠券";
        _titleLabel.font = [UIFont systemFontOfSize:15];
        _titleLabel.textColor = DSColorFromHex(0x646464);
        
    }
    return _titleLabel;
}
-(UIButton *)finishBtn{
    if (!_finishBtn) {
        _finishBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _finishBtn.backgroundColor = DSColorFromHex(0xFF4C4D);
        [_finishBtn setTitle:@"完成" forState:UIControlStateNormal];
        [_finishBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _finishBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [_finishBtn.layer setCornerRadius:2];
        [_finishBtn.layer setMasksToBounds:YES];
        [_finishBtn addTarget:self action:@selector(pressFinishBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    return _finishBtn;
}
-(void)pressFinishBtn{
    if ([self.delegate respondsToSelector:@selector(finishCouponView)]) {
        [self.delegate finishCouponView];
    }
}
-(UIView *)bgView{
    if (!_bgView) {
        _bgView = [[UIView alloc]init];
        _bgView.backgroundColor = DSColorFromHex(0xF0F0F0);
    }
    return _bgView;
}
-(UIView *)topView{
    if (!_topView) {
        _topView = [[UIView alloc]init];
        _topView.backgroundColor = [UIColor clearColor];
        _topView.userInteractionEnabled = YES;
    }
    return _topView;
}
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 49, SCREENWIDTH, 200) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorColor = [UIColor whiteColor];
        _tableView.tableFooterView = [[UIView alloc]init];
        _tableView.backgroundColor = DSColorFromHex(0xF0F0F0);
    }
    return _tableView;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 5;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identify = @"identify";
    MyCouponCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell) {
        cell = [[MyCouponCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    cell.getBtn.hidden = NO;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    __weak typeof(self) _weakSelf = self;
    [cell setGetBlock:^(NSInteger index) {
        if ([_weakSelf.delegate respondsToSelector:@selector(getCouponViewWithIndex:)]) {
            [_weakSelf.delegate getCouponViewWithIndex:index];
        }
    }];
    return cell;
}
@end
