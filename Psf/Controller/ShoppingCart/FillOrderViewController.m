//
//  FillOrderViewController.m
//  Psf
//
//  Created by 燕来秋mac9 on 2018/6/29.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "FillOrderViewController.h"
#import "FillOrderTableViewCell.h"
#import "OrderDetailHeadView.h"
#import "FillOrderBottomView.h"
#import "FillOrderTypeView.h"
#import "MyReceiveAddressController.h"
#import "UseCouponController.h"
#import "NextReceiveDateView.h"

@interface FillOrderViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableview;
@property(nonatomic,strong)NSArray *dataArr;
@property(nonatomic,strong)OrderDetailHeadView *headView;
@property(nonatomic,strong)FillOrderBottomView *bottomView;
@property(nonatomic,strong)FillOrderTypeView *typeView;
@property(nonatomic,strong)NextReceiveDateView *dateView;

@property(nonatomic,assign)NSInteger type;
@end

@implementation FillOrderViewController
-(NextReceiveDateView *)dateView{
    if (!_dateView) {
        _dateView = [[NextReceiveDateView alloc]init];
        _dateView.frame = CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT);
        
        _dateView.hidden = YES;
    }
    return _dateView;
}
-(UITableView *)tableview{
    if (!_tableview) {
        _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0,46+[self navHeightWithHeight], SCREENWIDTH, SCREENHEIGHT-[self tabBarHeight]-46-[self navHeightWithHeight]) style:UITableViewStylePlain];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.tableFooterView = [[UIView alloc]init];
        _tableview.separatorColor = DSColorFromHex(0xF0F0F0);
        _tableview.backgroundColor = DSColorFromHex(0xF0F0F0);
    }
    return _tableview;
}
-(FillOrderBottomView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[FillOrderBottomView alloc]init];
        _bottomView.frame = CGRectMake(0, SCREENHEIGHT-[self tabBarHeight], SCREENWIDTH, [self tabBarHeight]);
    }
    return _bottomView;
}
-(FillOrderTypeView *)typeView{
    if (!_typeView) {
        _typeView = [[FillOrderTypeView alloc]init];
        _typeView.frame = CGRectMake(0,[self navHeightWithHeight], SCREENWIDTH, 46);
    }
    return _typeView;
}
-(OrderDetailHeadView *)headView{
    if (!_headView) {
        _headView = [[OrderDetailHeadView alloc]init];
        _headView.frame = CGRectMake(0, 0, SCREENWIDTH, 165);
    }
    return _headView;
}
-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self setNavWithTitle:@"填写订单"];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableview];
    self.tableview.tableHeaderView = self.headView;
    [self.view addSubview:self.bottomView];
    [self.view addSubview:self.typeView];
    [self.view addSubview:self.dateView];
    _type = 1;
    [self.headView setGoodtype:CLAIMGOODSTYPEVISIT];
    __weak typeof(self) weakSelf = self;
    [self.typeView setChooseTypeBlock:^(NSInteger index) {
        weakSelf.type = index;
        if (index ==1) {
            [weakSelf.headView setGoodtype:CLAIMGOODSTYPEVISIT];
            weakSelf.headView.frame = CGRectMake(0, 0, SCREENWIDTH, 165);
        }else if (index ==2){
             [weakSelf.headView setGoodtype:CLAIMGOODSTYPEONESELF];
            weakSelf.headView.frame = CGRectMake(0, 0, SCREENWIDTH, 125);
        }
        weakSelf.tableview.tableHeaderView = weakSelf.headView;
    }];
    [self.headView setAddressBlock:^(NSInteger index) {
        MyReceiveAddressController *addressVC = [[MyReceiveAddressController alloc]init];
        [weakSelf.navigationController pushViewController:addressVC animated:YES];
    }];
    [self.headView setDateBlock:^(NSInteger index) {
        weakSelf.dateView.hidden = NO;
    }];
    [self.dateView setCancleBlock:^(NSInteger index) {
        weakSelf.dateView.hidden = YES;
    }];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section ==0){
        return 2;
    }else if (section ==1){
        return 4;
    }
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return 0;
    }
    return 5;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section ==1||indexPath.section ==2) {
        return 45;
    }
    return 120;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headView;
    if (section ==1||section ==2) {
         headView= [[UIView alloc]init];
        headView.frame = CGRectMake(0, 0, SCREENWIDTH, 5);
        headView.backgroundColor = DSColorFromHex(0xF0F0F0);
    }
    return headView;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section ==0) {
        static NSString *identify = @"FillOrderTableViewCell";
        FillOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
        if (!cell) {
            cell = [[FillOrderTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identify];
        }
        cell.accessoryType = UITableViewCellAccessoryNone;
        return cell;
    }
    static NSString *identify = @"UITableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identify];
    }
   cell.accessoryType = UITableViewCellAccessoryNone;
    if (indexPath.section ==1) {
        if (indexPath.row ==0) {
            cell.textLabel.text = @"优惠券：暂无可用";
            cell.detailTextLabel.text = @"0张";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }else if(indexPath.row ==1) {
            cell.textLabel.text = @"配送费";
            cell.detailTextLabel.text = @"¥ 0.00";
        }else if(indexPath.row ==2) {
            cell.textLabel.text = @"开具发票";
            cell.detailTextLabel.text = @"";
        }
        else if(indexPath.row ==3) {
            cell.textLabel.text = @"合计";
            cell.detailTextLabel.text = @"¥ 399.80";
        }
    }else if (indexPath.section ==2){
        cell.textLabel.text = @"微信支付";
        cell.detailTextLabel.text = @"";
        cell.imageView.image = [UIImage imageNamed:@"wechat_icon"];
    }
    cell.textLabel.textColor = DSColorFromHex(0x464646);
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    cell.detailTextLabel.textColor = DSColorFromHex(0x464646);
    cell.detailTextLabel.font = [UIFont systemFontOfSize:15];
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section ==1) {
        if (indexPath.row ==0) {
            UseCouponController *useVC = [[UseCouponController alloc]init];
            [self.navigationController pushViewController:useVC animated:YES];
        }
    }
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
