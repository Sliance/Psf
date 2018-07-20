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
#import "AddressServiceApi.h"
#import "ShopServiceApi.h"
#import "PointAmountCell.h"

@interface FillOrderViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableview;
@property(nonatomic,strong)NSMutableArray *dataArr;
@property(nonatomic,strong)OrderDetailHeadView *headView;
@property(nonatomic,strong)FillOrderBottomView *bottomView;
@property(nonatomic,strong)FillOrderTypeView *typeView;
@property(nonatomic,strong)NextReceiveDateView *dateView;
@property(nonatomic,strong)CalculateReq *calculateModel;
@property(nonatomic,strong)CalculateThePriceRes* resModel;

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
        _dataArr = [NSMutableArray array];
        _calculateModel = [[CalculateReq alloc]init];
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
        [addressVC setChooseBlock:^(ChangeAddressReq * model) {
            [weakSelf.headView setModel:model];
        }];
        addressVC.type = ADDRESSTYPEOrder;
        [weakSelf.navigationController pushViewController:addressVC animated:YES];
    }];
    [self.headView setDateBlock:^(NSInteger index) {
        weakSelf.dateView.hidden = NO;
    }];
    [self.dateView setCancleBlock:^(NSString* date) {
        weakSelf.dateView.hidden = YES;
        if (date.length>0) {
            weakSelf.headView.dateLabel.text = date;
        }
    }];
}

-(void)setResult:(ShoppingListRes *)result{
    _result = result;
    [_dataArr removeAllObjects];
    [_dataArr addObjectsFromArray:self.result.cartProductList];
    [_tableview reloadData];

    [self reloadLeftAddress];
}

-(void)reloadLeftAddress{
    AddressBaeReq *req = [[AddressBaeReq alloc]init];
    req.appId = @"993335466657415169";
    req.timestamp = @"529675086";
    req.token = @"eyJleHBpcmVUaW1lIjoxNTYxNjI1OTU3ODc0LCJ1c2VySWQiOiIxMDEwNDEyNTM0NzkxNTUzMDI2Iiwib2JqZWN0SWQiOiIxMDEwNDEyNTM0NzkxNTUzMDI1In0=";
    req.platform = @"ios";
    __weak typeof(self)weakself = self;
    [[AddressServiceApi share]getSingleDefaultAddresWithParam:req response:^(id response) {
        if (response!=nil) {
            ChangeAddressReq *res = [[ChangeAddressReq alloc]init];
            res = response;
            [weakself.headView setModel:res];
        
        }else{
             weakself.headView.centerLabel.hidden = NO;
        }
        weakself.calculateModel.usePointIs = YES;
        weakself.calculateModel.productList = weakself.result.cartProductList;
        weakself.calculateModel.useIsBalance = YES;
        weakself.calculateModel.expressEnable = YES;
        NSDate *date = [[[NSDate alloc]init]dateByAddingDays:1];
        NSString *next = [date stringWithFormat:@"yyyy-MM-dd"];
        NSString *end = [NSString stringWithFormat:@"%@ 12:00:00",next];
        next = [NSString stringWithFormat:@"%@ 09:00:00",next];
        weakself.calculateModel.couponId = @"";
        weakself.calculateModel.saleOrderDistributionStartTime = next;
        weakself.calculateModel.saleOrderDistributionEndTime = end ;
        [weakself calculatePrice:weakself.calculateModel];
    }];
}
-(void)calculatePrice:(CalculateReq*)req{
    req.appId = @"993335466657415169";
    req.timestamp = @"529675086";
    req.token = @"eyJleHBpcmVUaW1lIjoxNTYzNDUzNjA5MDc1LCJ1c2VySWQiOiIxMDE2NjExMjI4MzA0NTgwNjExIiwib2JqZWN0SWQiOiIxMDE2NjExMjI4MzA0NTgwNjEwIn0=";
    req.platform = @"ios";
    NSMutableArray *arr = [NSMutableArray array];
    for (CartProductModel *model in self.result.cartProductList) {
        if (model.productQuantity) {
            model.saleOrderProductQty = model.productQuantity;
            [arr addObject:model];
        }
    }
    req.productList = arr;
    __weak typeof(self)weakself = self;
    [[ShopServiceApi share]CalculateThePriceWithParam:req response:^(id response) {
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
        return 6;
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
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        CartProductModel *model = _dataArr[indexPath.row];
        [cell setModel:model];
        cell.accessoryType = UITableViewCellAccessoryNone;
        return cell;
    }
    if (indexPath.row ==3||indexPath.row ==4) {
        static NSString *identify = @"PointAmountCell";
        PointAmountCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
        if (!cell) {
            cell = [[PointAmountCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
        }
         cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setIndex:indexPath.row];
        if(indexPath.row ==3) {
            if (self.resModel.saleOrderPointAmount) {
                cell.nameLabel.text = [NSString stringWithFormat:@"积分抵扣（￥%@）",self.resModel.saleOrderPointAmount];
            }else{
                cell.nameLabel.text = @"积分抵扣（￥0）";
            }
            
            
            if (self.calculateModel) {
                cell.yuEswitch.on = self.calculateModel.usePointIs;
            }else{
                cell.yuEswitch.on = YES;
                self.calculateModel.usePointIs = YES;
            }
            
        }else if(indexPath.row ==4) {
            cell.nameLabel.text = [NSString stringWithFormat:@"余额抵扣（￥%@）",self.resModel.useMemberBalance];
            if (self.calculateModel) {
                cell.yuEswitch.on = self.calculateModel.useIsBalance;
            }else{
                cell.yuEswitch.on = YES;
                self.calculateModel.useIsBalance = YES;
            }
            
        }
        __weak typeof(self)weakself = self;
        [cell setYuEBlock:^(NSInteger index) {
            if (index ==4) {
                weakself.calculateModel.useIsBalance = !weakself.calculateModel.useIsBalance;
                [weakself calculatePrice:weakself.calculateModel];
            }else if (index ==3){
                weakself.calculateModel.usePointIs = !weakself.calculateModel.usePointIs;
                [weakself calculatePrice:weakself.calculateModel];
            }
        }];
        return cell;
    }
    static NSString *identify = @"UITableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identify];
    }
   cell.imageView.image = [UIImage imageNamed:@""];
   cell.accessoryType = UITableViewCellAccessoryNone;
    for (UIView*view in cell.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            [view removeFromSuperview];
        }
    }
    if (indexPath.section ==1) {
        if (indexPath.row ==0) {
            cell.textLabel.text = @"优惠券：暂无可用";
            cell.detailTextLabel.text = @"0张";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }else if(indexPath.row ==2) {
            cell.textLabel.text = @"配送费";
            cell.detailTextLabel.text = [NSString stringWithFormat:@"￥%@",self.resModel.saleOrderExpressAmount];
        }else if(indexPath.row ==1) {
            cell.textLabel.text = @"开具发票（否）";
            cell.detailTextLabel.text = @"";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }else if(indexPath.row ==5) {
            cell.textLabel.text = @"合计";
            cell.detailTextLabel.text = [NSString stringWithFormat:@"¥ %@",self.resModel.saleOrderPayAmount];
        }
    }else if (indexPath.section ==2){
        cell.textLabel.text = @"微信支付";
        cell.detailTextLabel.text = @"";
        cell.imageView.image = [UIImage imageNamed:@"wechat_icon"];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:@"shopping_normal"] forState:UIControlStateNormal];
         [btn setImage:[UIImage imageNamed:@"shopping_selected"] forState:UIControlStateSelected];
        btn.selected = YES;
        [btn addTarget:self action:@selector(pressWeChart:) forControlEvents:UIControlEventTouchUpInside];
        btn.frame = CGRectMake(SCREENWIDTH-35, 12, 20, 20);
        [cell addSubview:btn];
    }
    cell.textLabel.textColor = DSColorFromHex(0x464646);
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    cell.detailTextLabel.textColor = DSColorFromHex(0x464646);
    cell.detailTextLabel.font = [UIFont systemFontOfSize:15];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)pressWeChart:(UIButton*)sender{
    sender.selected = !sender.selected;
    
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
