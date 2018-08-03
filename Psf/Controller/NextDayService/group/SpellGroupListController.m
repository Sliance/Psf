//
//  SpellGroupListController.m
//  Psf
//
//  Created by 燕来秋mac9 on 2018/8/3.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "SpellGroupListController.h"
#import "TourDiyGooddetailCell.h"

@interface SpellGroupListController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableview;
@property(nonatomic,strong)NSMutableArray *dataArr;

@end

@implementation SpellGroupListController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableview];
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
