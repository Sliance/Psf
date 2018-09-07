//
//  NextReceiveDateView.m
//  Psf
//
//  Created by 燕来秋mac9 on 2018/7/6.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "NextReceiveDateView.h"

@implementation NextReceiveDateView

-(instancetype)init{
    self = [super init];
    if (self) {
        [self setCortnetLayout];
    }
    return self;
}
-(void)setCortnetLayout{
    _datearr = @[@"09:00-12:00",@"12:00-15:00",@"15:00-18:00",@"18:00-21:00"];
    [self addSubview:self.bgview];
    [self addSubview:self.yinview];
    [self.bgview addSubview:self.leftview];
    [self.bgview addSubview:self.titleLabel];
    [self.bgview addSubview:self.lineLabel];
    [self.leftview addSubview:self.nowBtn];
    [self.leftview addSubview:self.nextBtn];
    [self.bgview addSubview:self.cancleBtn];
    self.yinview.frame = CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT-280);
    self.bgview.frame = CGRectMake(0, SCREENHEIGHT-280, SCREENWIDTH, 280);
    self.titleLabel.frame = CGRectMake(15, 0, SCREENWIDTH-45, 45);
    self.lineLabel.frame = CGRectMake(15, 45, SCREENWIDTH-15, 0.5);
    self.leftview.frame = CGRectMake(0, self.lineLabel.ctBottom, 125, self.bgview.ctHeight);
    self.nowBtn.frame = CGRectMake(0, 0, 125, 45);
    self.nextBtn.frame = CGRectMake(0, 45, 125, 45);
    self.cancleBtn.frame = CGRectMake(SCREENWIDTH-45, 0, 45, 45);
    for (int i = 0; i<_datearr.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(125, i*40+self.lineLabel.bottom, 160, 40);
        [btn setTitle:_datearr[i] forState:UIControlStateNormal];
        [btn setTitleColor:DSColorFromHex(0x474747) forState:UIControlStateNormal];
        [btn setTitleColor:DSColorFromHex(0xFF4C4D) forState:UIControlStateSelected];
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        [btn setImage:nil forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"shopping_selected"] forState:UIControlStateSelected];
        btn.tag = i;
        [btn addTarget:self action:@selector(pressBtn:) forControlEvents:UIControlEventTouchUpInside];
        btn.imageEdgeInsets = UIEdgeInsetsMake(0, 130, 0, 0);
        btn.titleEdgeInsets =UIEdgeInsetsMake(0, 0, 0, 30);
        if (i ==0) {
            btn.selected = YES;
             btn.titleEdgeInsets =UIEdgeInsetsMake(0, 0, 0, 50);
            _tmpBtn = btn;
        }
        [self.bgview addSubview:btn];
    }
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pressTap)];
    [self.yinview addGestureRecognizer:tap];
    [self setDate];
    
}
-(void)setDate{
    NSDate *now = [[[NSDate alloc]init] dateByAddingDays:1];
    NSDate *yesterday = [now dateByAddingDays:1];
    NSInteger nowmonth = [now month];
    NSInteger nowday = [now  day];
    NSInteger nowweek = [now weekday];
    NSString* nowweekstr = [self changeWeek:nowweek];
    
    NSInteger yesmonth = [yesterday month];
    NSInteger yesday = [yesterday  day];
    NSInteger yesweek = [yesterday weekday];
    NSString* yesweekstr = [self changeWeek:yesweek];
    
    NSString *nowstr = [NSString stringWithFormat:@"%ld月%ld日|%@",nowmonth,nowday,nowweekstr];
    NSString *yesstr = [NSString stringWithFormat:@"%ld月%ld日|%@",yesmonth,yesday,yesweekstr];
    [_nowBtn setTitle:nowstr forState:UIControlStateNormal];
    [_nextBtn setTitle:yesstr forState:UIControlStateNormal];
}
-(NSString *)changeWeek:(NSInteger)date{
    if (date==1) {
        return  @"周日";
    }else if (date ==2){
        return @"周一";
    }else if (date ==3){
        return @"周二";
    }else if (date ==4){
        return @"周三";
    }else if (date ==5){
        return @"周四";
    }else if (date ==6){
        return @"周五";
    }else if (date ==7){
        return @"周六";
    }
    return @"";
    
}
-(UIView *)yinview{
    if (!_yinview) {
        _yinview = [[UIView alloc]init];
        _yinview.backgroundColor = DSColorAlphaFromHex(0x000000, 0.3);
    }
    return _yinview;
}
-(UIView *)bgview{
    if (!_bgview) {
        _bgview = [[UIView alloc]init];
        _bgview.backgroundColor = [UIColor whiteColor];
    }
    return _bgview;
}
-(UIView *)leftview{
    if (!_leftview) {
        _leftview = [[UIView alloc]init];
        _leftview.backgroundColor = DSColorAlphaFromHex(0xF0F0F0, 1);
    }
    return _leftview;
}
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.text = @"次日达配送时间";
        _titleLabel.textColor = DSColorFromHex(0x474747);
        _titleLabel.font = [UIFont systemFontOfSize:15];
    }
    return _titleLabel;
}
-(UILabel *)lineLabel{
    if(!_lineLabel){
        _lineLabel = [[UILabel alloc]init];
        _lineLabel.backgroundColor = DSColorFromHex(0xF0F0F0);
    }
    return _lineLabel;
        
}
-(UIButton *)nowBtn{
    if (!_nowBtn) {
        _nowBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_nowBtn setBackgroundColor:[UIColor whiteColor]];
        _nowBtn.selected = YES;
        _leftBtn = _nowBtn;
        [_nowBtn setTitle:@"" forState:UIControlStateNormal];
        [_nowBtn setTitleColor:DSColorFromHex(0x474747) forState:UIControlStateNormal];
        _nowBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_nowBtn addTarget:self action:@selector(pressLeft:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _nowBtn;
}
-(UIButton *)nextBtn{
    if (!_nextBtn) {
        _nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_nextBtn setBackgroundColor:DSColorFromHex(0xF0F0F0)];
        [_nextBtn setTitle:@"3月11日|周五" forState:UIControlStateNormal];
        [_nextBtn setTitleColor:DSColorFromHex(0x474747) forState:UIControlStateNormal];
        _nextBtn.titleLabel.font = [UIFont systemFontOfSize:15];
         [_nextBtn addTarget:self action:@selector(pressLeft:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _nextBtn;
}
-(UIButton *)cancleBtn{
    if (!_cancleBtn) {
        _cancleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancleBtn setImage:[UIImage imageNamed:@"date_dismiss"] forState:UIControlStateNormal];
        [_cancleBtn addTarget:self action:@selector(pressCancle:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancleBtn;
}
-(void)pressTap{
     self.cancleBlock(@"",@"",@"");
}
-(void)pressCancle:(UIButton*)sender{
    self.cancleBlock(@"",@"",@"");
}
-(void)pressLeft:(UIButton*)sender{
    sender.selected = !sender.selected;
    
    if (_leftBtn == nil){
        sender.selected = YES;
        [sender setBackgroundColor:[UIColor whiteColor]];
        _leftBtn = sender;
    }else if (_leftBtn !=nil && _leftBtn == sender){
        sender.selected = YES;
        [sender setBackgroundColor:[UIColor whiteColor]];
    }else if (_leftBtn!= sender && _leftBtn!=nil){
        _leftBtn.selected = NO;
        [_leftBtn setBackgroundColor:DSColorFromHex(0xF0F0F0)];
        sender.selected = YES;
        [sender setBackgroundColor:[UIColor whiteColor]];
        _leftBtn = sender;
    }
    
//    NSString *date = [NSString stringWithFormat:@"%@ %@",_leftBtn.titleLabel.text,_tmpBtn.titleLabel.text];
    NSDate *now;
    NSString *start;
    NSString *end;
    NSArray *all = [_tmpBtn.titleLabel.text componentsSeparatedByString:@"-"];
    if (_leftBtn ==_nowBtn) {
        now = [[[NSDate alloc]init]dateByAddingDays:1];
        start = [now stringWithFormat:@"yyyy-MM-dd"];
        end= [NSString stringWithFormat:@"%@ %@:00",start,[all lastObject]];
        start = [NSString stringWithFormat:@"%@ %@:00",start,[all firstObject]];
    }
    if (_leftBtn ==_nextBtn) {
        now = [[[NSDate alloc]init]dateByAddingDays:2];
        start = [now stringWithFormat:@"yyyy-MM-dd"];
        end= [NSString stringWithFormat:@"%@ %@:00",start,[all lastObject]];
        start = [NSString stringWithFormat:@"%@ %@:00",start,[all firstObject]];
    }
//    self.cancleBlock(date,start,end);
}
-(void)pressBtn:(UIButton*)sender{
    sender.selected = !sender.selected;
    
    if (_tmpBtn == nil){
        sender.selected = YES;
        sender.titleEdgeInsets =UIEdgeInsetsMake(0, 0, 0, 40);
        _tmpBtn = sender;
    }else if (_tmpBtn !=nil && _tmpBtn == sender){
        sender.selected = YES;
        sender.titleEdgeInsets =UIEdgeInsetsMake(0, 0, 0, 50);
        
    }else if (_tmpBtn!= sender && _tmpBtn!=nil){
        _tmpBtn.selected = NO;
        _tmpBtn.titleEdgeInsets =UIEdgeInsetsMake(0, 0, 0, 30);
        sender.selected = YES;
        sender.titleEdgeInsets =UIEdgeInsetsMake(0, 0, 0, 50);
        _tmpBtn = sender;
    }
    NSString *date = [NSString stringWithFormat:@"%@ %@",_leftBtn.titleLabel.text,_datearr[sender.tag]];
    NSDate *now;
    NSString *start;
    NSString *end;
    NSArray *all = [_tmpBtn.titleLabel.text componentsSeparatedByString:@"-"];
    if (_leftBtn ==_nowBtn) {
        now = [[[NSDate alloc]init]dateByAddingDays:1];
        start = [now stringWithFormat:@"yyyy-MM-dd"];
        end= [NSString stringWithFormat:@"%@ %@:00",start,[all lastObject]];
        start = [NSString stringWithFormat:@"%@ %@:00",start,[all firstObject]];
    }
    if (_leftBtn ==_nextBtn) {
        now = [[[NSDate alloc]init]dateByAddingDays:2];
        start = [now stringWithFormat:@"yyyy-MM-dd"];
        end= [NSString stringWithFormat:@"%@ %@:00",start,[all lastObject]];
        start = [NSString stringWithFormat:@"%@ %@:00",start,[all firstObject]];
    }
    self.cancleBlock(date,start,end);
}
@end
