//
//  FeedbackTypeView.m
//  Psf
//
//  Created by 燕来秋mac9 on 2018/8/10.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "FeedbackTypeView.h"

@implementation FeedbackTypeView

-(UIView *)yinBGview{
    if (!_yinBGview) {
        _yinBGview = [[UIView alloc]init];
        _yinBGview.backgroundColor = DSColorAlphaFromHex(0x000000, 0.3);
    }
    return _yinBGview;
}
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setCortentLayout];
        _dataArr = @[@"售后",@"配送",@"服务态度",@"商品质量",@"界面设计"];
        
    }
    return self;
}
-(void)setCortentLayout{
    [self addSubview:self.yinBGview];
    [self addSubview:self.tableview];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(presstap)];
    [self.yinBGview addGestureRecognizer:tap];
}
-(void)presstap{
    self.yinBlock();
}
-(void)setHeight:(NSInteger)height{
    _height = height;
    self.yinBGview.frame = CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT-265-49+height);
    self.tableview.frame = CGRectMake(0, SCREENHEIGHT-265-49+height, SCREENHEIGHT, 265);
}
- (void)setIndex:(NSInteger)index{
    _index = index;
    [self.tableview reloadData];
}
-(UITableView *)tableview{
    if (!_tableview) {
        _tableview = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.backgroundColor = [UIColor whiteColor];
        _tableview.separatorColor = [UIColor clearColor];
        _tableview.tableFooterView = [[UIView alloc]init];
        _tableview.scrollEnabled = NO;
    }
    return _tableview;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identify = @"";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
        
    }
    if (indexPath.row ==self.index) {
        cell.textLabel.textColor = DSColorFromHex(0xFF4C4D);
    }else{
        cell.textLabel.textColor = DSColorFromHex(0x464646);
    }
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    cell.textLabel.text = _dataArr[indexPath.row];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 53;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.selectedBlock(indexPath.row,_dataArr[indexPath.row]);
}
@end
