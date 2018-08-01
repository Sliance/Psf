//
//  SureOrderViewController.m
//  Psf
//
//  Created by 燕来秋mac9 on 2018/7/4.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "SureOrderViewController.h"
#import "OrderDetailHeadView.h"
#import "FillOrderBottomView.h"
#import "FillOrderTypeView.h"
#import "SureOrderTableViewCell.h"
#import "MyReceiveAddressController.h"
#import "AddressServiceApi.h"
#import "GroupServiceApi.h"

@interface SureOrderViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableview;
@property(nonatomic,strong)NSMutableArray *dataArr;
@property(nonatomic,strong)OrderDetailHeadView *headView;
@property(nonatomic,strong)FillOrderBottomView *bottomView;
@property(nonatomic,strong)FillOrderTypeView *typeView;
@property(nonatomic,assign)NSInteger type;
@property(nonatomic,strong)CalculateThePriceRes* resModel;
@end

@implementation SureOrderViewController

-(UITableView *)tableview{
    if (!_tableview) {
        _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0,46, SCREENWIDTH, SCREENHEIGHT-[self tabBarHeight]) style:UITableViewStylePlain];
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
        _typeView.frame = CGRectMake(0,0, SCREENWIDTH, 46);
    }
    return _typeView;
}
-(OrderDetailHeadView *)headView{
    if (!_headView) {
        _headView = [[OrderDetailHeadView alloc]init];
        _headView.frame = CGRectMake(0, 0, SCREENWIDTH, 80);
    }
    return _headView;
}
-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self setNavWithTitle:@"确认订单"];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableview];
    self.tableview.tableHeaderView = self.headView;
    [self.view addSubview:self.bottomView];
    [self.view addSubview:self.typeView];
    _dataArr = [NSMutableArray array];
    _type = 1;
    [self.headView setGoodtype:CLAIMGOODSTYPECOMMON];
    __weak typeof(self) weakSelf = self;
    [self.typeView setChooseTypeBlock:^(NSInteger index) {
        weakSelf.type = index;
    }];
    [self.headView setAddressBlock:^(NSInteger index) {
        MyReceiveAddressController *addressVC = [[MyReceiveAddressController alloc]init];
        [weakSelf.navigationController pushViewController:addressVC animated:YES];
    }];
}
-(void)setCount:(NSInteger)count{
    _count = count;
}
-(void)setResult:(GoodDetailRes *)result{
    [_dataArr removeAllObjects];
    [_dataArr addObject:result];
    [_tableview reloadData];
    [self reloadLeftAddress];
}

-(void)reloadLeftAddress{
    AddressBaeReq *req = [[AddressBaeReq alloc]init];
    req.appId = @"993335466657415169";
    req.timestamp = @"529675086";
    req.token = [UserCacheBean share].userInfo.token;
    req.platform = @"ios";
    __weak typeof(self)weakself = self;
    [[AddressServiceApi share]getSingleDefaultAddresWithParam:req response:^(id response) {
        if (response!=nil) {
            
            [weakself.headView setModel:response];
            
        }else{
            weakself.headView.centerLabel.hidden = NO;
        }
        [weakself calculatePrice];
        
    }];
}
-(void)calculatePrice{
    CalculateReq *req = [[CalculateReq alloc]init];
    req.usePointIs = YES;
    req.productId = self.result.productId;
    req.saleOrderProductQty = self.count;
    req.useIsBalance = YES;
    req.expressEnable = YES;
    NSDate *date = [[[NSDate alloc]init]dateByAddingDays:1];
    NSString *next = [date stringWithFormat:@"yyyy-MM-dd"];
    NSString *end = [NSString stringWithFormat:@"%@ 12:00:00",next];
    next = [NSString stringWithFormat:@"%@ 09:00:00",next];
    req.couponId = @"";
    req.saleOrderDistributionStartTime = next;
    req.saleOrderDistributionEndTime = end ;
    req.appId = @"993335466657415169";
    req.timestamp = @"529675086";
    req.token = [UserCacheBean share].userInfo.token;
    req.platform = @"ios";
  
    __weak typeof(self)weakself = self;
    [[GroupServiceApi share]getGroupPriceWithParam:req response:^(id response) {
        if (response) {
            weakself.resModel = [[CalculateThePriceRes alloc]init];
            weakself.resModel = response;
            weakself.bottomView.payableLabel.text = [NSString stringWithFormat:@"应付款：￥%@",weakself.resModel.saleOrderPayAmount];
            [weakself.tableview reloadData];
        }
    }];
 
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section ==0){
        return self.dataArr.count;
    }else if (section ==1){
        return 3;
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
        static NSString *identify = @"SureOrderTableViewCell";
        SureOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
        if (!cell) {
            cell = [[SureOrderTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identify];
        }
        cell.accessoryType = UITableViewCellAccessoryNone;
        return cell;
    }
    static NSString *identify = @"UITableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identify];
    }
    
    if (indexPath.section ==1) {
         if(indexPath.row ==0) {
            cell.textLabel.text = @"配送费";
            cell.detailTextLabel.text = @"¥ 0.00";
        }else if(indexPath.row ==1) {
            cell.textLabel.text = @"开具发票";
            cell.detailTextLabel.text = @"";
        }
        else if(indexPath.row ==2) {
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
    cell.accessoryType = UITableViewCellAccessoryNone;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
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
