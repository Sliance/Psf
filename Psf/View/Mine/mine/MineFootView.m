//
//  MineFootView.m
//  Psf
//
//  Created by 燕来秋mac9 on 2018/6/20.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "MineFootView.h"
#import "MineTypeBtn.h"

@implementation MineFootView

-(UIImageView *)headImage{
    if (!_headImage) {
        _headImage = [[UIImageView alloc]init];
        _headImage.image = [UIImage imageNamed:@"banner_mine"];
        
    }
    return _headImage;
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
        [self setcornerLayout];
    }
    return self;
}
-(void)setcornerLayout{
    [self addSubview:self.headImage];
    [self addSubview:self.lineLabel];
    [self.lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self.mas_bottom).offset(-5);
        make.height.mas_equalTo(5);
        
    }];
    [self.headImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.height.mas_equalTo(100);
        make.bottom.equalTo(self.mas_bottom).offset(-5);
    }];
    
}
-(void)setArr:(NSArray *)arr{
    NSArray *imageArr= @[@"\U0000e901",@"\U0000e900",@"\U0000e903",@"\U0000e902",@"\U0000e904"];
    NSArray *dataArr = @[@"待付款",@"待发货",@"待收货",@"待评价",@"退换/售后"];
    for (int i = 0; i<imageArr.count; i++) {
        MineTypeBtn *btn = [[MineTypeBtn alloc]initWithFrame:CGRectMake(SCREENWIDTH/5*i, 17, SCREENWIDTH/5, 53)]
        ;
        btn.imageLabel.textColor = DSColorFromHex(0x666666);
        btn.countLabel.backgroundColor = DSColorFromHex(0xFF4C4D);
        btn.typeLabel.textColor = DSColorFromHex(0x464646);
        btn.imageLabel.text = imageArr[i];
        btn.typeLabel.text = dataArr[i];
        btn.countLabel.text = arr[i];
        if ([arr[i] integerValue] ==0) {
            btn.countLabel.hidden = YES;
        }else{
            btn.countLabel.hidden = NO;
        }
        btn.tag = i+1;
        
        [btn addTarget:self action:@selector(pressBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
    }
}
-(void)pressBtn:(MineTypeBtn*)sender{
    self.skipMineBlock(sender.tag);
}
@end
