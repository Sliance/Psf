//
//  NextSelectorView.m
//  Psf
//
//  Created by 燕来秋mac9 on 2018/7/2.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "NextSelectorView.h"

@implementation NextSelectorView

-(instancetype)init{
    self = [super init];
    if (self) {
        [self addSubview:self.titleLabel];
        [self addSubview:self.rightButton];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.text = @"全部分类";
        _titleLabel.frame = CGRectMake(15, 10, 100, 15);
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.font = [UIFont systemFontOfSize:15];
        _titleLabel.textColor = DSColorFromHex(0x464646);
    }
    return _titleLabel;
}
-(UIButton *)rightButton{
    if (!_rightButton) {
        _rightButton = [[UIButton alloc] initWithFrame:CGRectMake(SCREENWIDTH-50, 0, 50, 40)];
        [_rightButton addTarget:self action:@selector(subscribeAction:) forControlEvents:UIControlEventTouchUpInside];
        [_rightButton setImage:[UIImage imageNamed:@"down_icon"] forState:UIControlStateNormal];
        _rightButton.imageEdgeInsets = UIEdgeInsetsMake(0, -10, -5, 0);
    }
    return _rightButton;
}
-(void)subscribeAction:(UIButton*)sender{
    self.pressUpBlock(self.tag);
}
-(void)setDataArr:(NSMutableArray *)dataArr{
    _dataArr = dataArr;
    for (int i = 0; i<dataArr.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        StairCategoryRes *model = dataArr[i];
        [btn setTitle:model.productCategoryName forState:UIControlStateNormal];
        btn.frame = CGRectMake(30+i%4*SCREENWIDTH/4-75/4, i/4*35+40, SCREENWIDTH/4-75/4, 25);
        [btn setTitleColor:DSColorFromHex(0x464646) forState:UIControlStateNormal];
        [btn setTitleColor:DSColorFromHex(0xFF4C4D) forState:UIControlStateSelected];
        btn.titleLabel.font = [UIFont systemFontOfSize:12];
        [btn.layer setBorderWidth:0.5];
        btn.tag = i;
        if (i==0) {
            _tmpBtn = btn;
        }
        [btn addTarget:self action:@selector(pressChoose:) forControlEvents:UIControlEventTouchUpInside];
        [btn.layer setBorderColor:DSColorFromHex(0x474747).CGColor];
        [self addSubview:btn];
    }
}
-(void)pressChoose:(UIButton *)sender{
    sender.selected = !sender.selected;
    
    if (_tmpBtn == nil){
        sender.selected = YES;
        [sender.layer setBorderColor:DSColorFromHex(0xFF4C4D).CGColor];
        _tmpBtn = sender;
    }else if (_tmpBtn !=nil && _tmpBtn == sender){
        sender.selected = YES;
        [sender.layer setBorderColor:DSColorFromHex(0xFF4C4D).CGColor];
    }else if (_tmpBtn!= sender && _tmpBtn!=nil){
        _tmpBtn.selected = NO;
        [_tmpBtn.layer setBorderColor:DSColorFromHex(0x474747).CGColor];
        sender.selected = YES;
        [sender.layer setBorderColor:DSColorFromHex(0xFF4C4D).CGColor];
        _tmpBtn = sender;
    }

    self.chooseBlock(sender.tag);
}
@end
