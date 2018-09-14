//
//  ShopAlertView.m
//  Psf
//
//  Created by 燕来秋mac9 on 2018/9/14.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "ShopAlertView.h"
#import "ShopAlertViewCell.h"

@implementation ShopAlertView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self setLayout];
    }
    return self;
}
-(UIView *)yinBgview{
    if (!_yinBgview) {
        _yinBgview = [[UIView alloc]init];
        _yinBgview.frame = CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT);
        _yinBgview.backgroundColor = DSColorAlphaFromHex(0x000000, 0.3);
    }
    return _yinBgview;
}
-(UIView *)bgView{
    if (!_bgView) {
        _bgView = [[UIView alloc]init];
        _bgView.frame = CGRectMake(0, SCREENHEIGHT-497, SCREENWIDTH, 497);
        _bgView.backgroundColor = [UIColor whiteColor];
    }
    return _bgView;
}
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = [UIFont systemFontOfSize:15];
        _titleLabel.textColor = DSColorFromHex(0x464646);
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.text = @"请分开结算以下商品";
    }
    return _titleLabel;
}
-(UIButton *)closeBtn{
    if (!_closeBtn) {
        _closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_closeBtn  setImage:[UIImage imageNamed:@"date_dismiss"] forState:UIControlStateNormal];
        [_closeBtn addTarget:self action:@selector(pressClose) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _closeBtn;
}
-(UITableView *)tableview{
    if (!_tableview) {
        _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 49, SCREENWIDTH, 447) style:UITableViewStylePlain];
        _tableview.delegate = self;
        _tableview.dataSource = self;
    }
    return _tableview;
}
-(void)setLayout{
    [self addSubview:self.yinBgview];
    [self addSubview:self.bgView];
    [self.bgView addSubview:self.tableview];
    
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  4;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 180;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identify = @"ShopAlertViewCell";
    ShopAlertViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell) {
        cell =  [[ShopAlertViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    return cell;
}






-(void)pressClose{
    self.closeBlcok();
}
@end
