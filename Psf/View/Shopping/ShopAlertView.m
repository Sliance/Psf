//
//  ShopAlertView.m
//  Psf
//
//  Created by 燕来秋mac9 on 2018/9/14.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "ShopAlertView.h"
#import "ShopAlertViewCell.h"
#import "CartProductModel.h"
@implementation ShopAlertView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self setLayout];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pressClose)];
        [self.yinBgview addGestureRecognizer:tap];
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

-(UILabel *)lineLabel{
    if (!_lineLabel) {
        _lineLabel = [[UILabel alloc]init];
        _lineLabel.backgroundColor = DSColorFromHex(0xF0F0F0);
    }
    return _lineLabel;
}
-(UITableView *)tableview{
    if (!_tableview) {
        _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 49, SCREENWIDTH, 447) style:UITableViewStylePlain];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.tableFooterView = [UIView new];
        _tableview.separatorColor = DSColorFromHex(0xF0F0F0);
    }
    return _tableview;
}
-(void)setLayout{
    [self addSubview:self.yinBgview];
    [self addSubview:self.bgView];
    [self.bgView addSubview:self.tableview];
    [self.bgView addSubview:self.titleLabel];
    [self.bgView addSubview:self.closeBtn];
    [self.bgView addSubview:self.lineLabel];
    
    self.titleLabel.frame = CGRectMake(15, 0, SCREENWIDTH-65, 48);
    self.closeBtn.frame = CGRectMake(SCREENWIDTH-48, 0, 48, 48);
    self.lineLabel.frame = CGRectMake(15, 48, SCREENWIDTH-15, 1);
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section ==0) {
        return 1;
    }else if (section ==1){
        return [self.model.preSaleProductList count];
    }
    return  1;
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
    
    [cell setProductType:indexPath.section];
    if (indexPath.section ==0) {
        
            [cell setDataArr:self.model.cartProductList];
        
    }else if(indexPath.section ==1){
        for (NSString *key in self.model.preSaleProductList) {
            NSArray *arr = [self.model.preSaleProductList objectForKey:key];
            [cell setTime:key];
            [cell setDataArr:arr];
        }
        
    }else if(indexPath.section ==2){
        [cell setDataArr:self.model.nextDayProductList];
    }
    __weak typeof(self)weakself = self;
    [cell setSubmitBlock:^(NSArray *arr) {
        weakself.submitBlock(arr);
    }];
    return cell;
}

-(void)setModel:(ShoppingListRes *)model{
    _model = model;
    [self.tableview reloadData];
}




-(void)pressClose{
    self.closeBlcok();
}
@end
