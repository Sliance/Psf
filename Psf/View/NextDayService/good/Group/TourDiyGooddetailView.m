//
//  TourDiyGooddetailView.m
//  Psf
//
//  Created by 燕来秋mac9 on 2018/7/3.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "TourDiyGooddetailView.h"
#import "TourDiyGooddetailCell.h"

@implementation TourDiyGooddetailView
-(instancetype)init{
    self = [super init];
    if (self) {
       
        [self addSubview:self.tableview];
        self.tableview.tableHeaderView = self.headLabel;
    }
    return self;
}
-(UILabel *)headLabel{
    if (!_headLabel) {
        _headLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 45)];
        _headLabel.backgroundColor = DSColorFromHex(0xFFEDC5);
        _headLabel.textColor = DSColorFromHex(0xF9AD34);
        _headLabel.font = [UIFont systemFontOfSize:12];
        
        
    }
    return _headLabel;
}
-(UITableView *)tableview{
    if (!_tableview) {
        _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 5, SCREENWIDTH, 187) style:UITableViewStylePlain];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.scrollEnabled = NO;
    }
    return _tableview;
}
-(void)setDataArr:(NSMutableArray *)dataArr{
    _dataArr = dataArr;
    _headLabel.text = [NSString stringWithFormat:@"     已有%ld人拼团",dataArr.count];
    if (dataArr.count<4&&dataArr.count>0) {
        _tableview.frame =   CGRectMake(0, 5, SCREENWIDTH, 45+71*dataArr.count);
    }else if(dataArr.count>3){
        _tableview.frame =   CGRectMake(0, 5, SCREENWIDTH, 45+71*3);
    }
    [_tableview reloadData];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArr.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 71;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identify = @"TourDiyGooddetailCell";
    TourDiyGooddetailCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell) {
        cell = [[TourDiyGooddetailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    [cell setModel:self.dataArr[indexPath.row]];
    [cell.goBtn addTarget:self action:@selector(pressAddBtn:) forControlEvents:UIControlEventTouchUpInside];
    cell.goBtn.tag = indexPath.row;
    return cell;
}
-(void)pressAddBtn:(UIButton*)sender{
    self.pressGoBlock(sender.tag);
}
@end
