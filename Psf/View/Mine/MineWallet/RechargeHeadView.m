//
//  RechargeHeadView.m
//  Psf
//
//  Created by 燕来秋mac9 on 2018/7/3.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "RechargeHeadView.h"

@implementation RechargeHeadView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}
-(void)setDataArr:(NSMutableArray *)dataArr{
    for (int i = 0; i<dataArr.count; i++) {
        RechargeBtn *btn = [[RechargeBtn alloc]init];
        [btn addTarget:self action:@selector(pressChoose:) forControlEvents:UIControlEventTouchUpInside];
        btn.frame = CGRectMake(20+i%2*(SCREENWIDTH/2-25/2), i/2*105+20,SCREENWIDTH/2-55/2, 90);
        [self addSubview:btn];
    }
    
}
-(void)pressChoose:(RechargeBtn *)sender{
    sender.selected = !sender.selected;
    
    if (_tmpBtn == nil){
        sender.selected = YES;
        [sender.layer setBorderColor:DSColorFromHex(0xFF4C4D).CGColor];
        sender.numLabel.textColor = DSColorFromHex(0xFF4C4D);
        sender.detailLabel.textColor = DSColorFromHex(0xFF4C4D);
        sender.backgroundColor = DSColorFromHex(0xFAEFEC);
        _tmpBtn = sender;
    }else if (_tmpBtn !=nil && _tmpBtn == sender){
        sender.selected = YES;
        [sender.layer setBorderColor:DSColorFromHex(0xFF4C4D).CGColor];
        sender.numLabel.textColor = DSColorFromHex(0xFF4C4D);
        sender.detailLabel.textColor = DSColorFromHex(0xFF4C4D);
        sender.backgroundColor = DSColorFromHex(0xFAEFEC);
    }else if (_tmpBtn!= sender && _tmpBtn!=nil){
        _tmpBtn.selected = NO;
        [_tmpBtn.layer setBorderColor:DSColorFromHex(0xF0F0F0).CGColor];
        _tmpBtn.numLabel.textColor = DSColorFromHex(0x323232);
        _tmpBtn.detailLabel.textColor = DSColorFromHex(0x969696);
        _tmpBtn.backgroundColor = DSColorFromHex(0xF0F0F0);
        sender.selected = YES;
        [sender.layer setBorderColor:DSColorFromHex(0xFF4C4D).CGColor];
        sender.numLabel.textColor = DSColorFromHex(0xFF4C4D);
        sender.detailLabel.textColor = DSColorFromHex(0xFF4C4D);
        sender.backgroundColor = DSColorFromHex(0xFAEFEC);
        _tmpBtn = sender;
    }
    
    self.chooseBlock(sender.tag);
}
@end
