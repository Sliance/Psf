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
        [self addSubview:self.headLabel];
        [self addSubview:self.allLabel];
        [self addSubview:self.allBtn];
        
    }
    return self;
}
-(UILabel *)headLabel{
    if (!_headLabel) {
        _headLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 5, SCREENWIDTH, 45)];
        _headLabel.backgroundColor = DSColorFromHex(0xFFEDC5);
        _headLabel.textColor = DSColorFromHex(0xF9AD34);
        _headLabel.font = [UIFont systemFontOfSize:12];
        
    }
    return _headLabel;
}
-(UILabel *)allLabel{
    if (!_allLabel) {
        _allLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 50, SCREENWIDTH, 30)];
        _allLabel.backgroundColor = [UIColor whiteColor];
        _allLabel.textColor = DSColorFromHex(0x464646);
        _allLabel.text = @"   已成团";
        _allLabel.font = [UIFont systemFontOfSize:12];
    }
    return _allLabel;
}
-(UIButton *)allBtn{
    if (!_allBtn) {
        _allBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _allBtn.frame = CGRectMake(SCREENWIDTH-100, 50, 85, 30);
        [_allBtn setTitle:@"查看全部>" forState:UIControlStateNormal];
        _allBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [_allBtn setTitleColor:DSColorFromHex(0x464646) forState:UIControlStateNormal];
        [_allBtn addTarget:self action:@selector(pressAllBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    return _allBtn;
}
-(UITableView *)tableview{
    if (!_tableview) {
        _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 50, SCREENWIDTH, 187) style:UITableViewStylePlain];
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
        _tableview.frame =   CGRectMake(0, 81, SCREENWIDTH, 71*dataArr.count);
    }else if(dataArr.count>3){
        _tableview.frame =   CGRectMake(0, 81, SCREENWIDTH, 71*3);
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
-(void)pressAllBtn{
    self.pressAllBlock(1);
    
}
@end
