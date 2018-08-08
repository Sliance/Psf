//
//  RefundViewController.m
//  Psf
//
//  Created by 燕来秋mac9 on 2018/7/4.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "RefundViewController.h"
#import "SureOrderTableViewCell.h"
#import "SexPickerTool.h"
#import "RefundfootView.h"
#import "BottomView.h"
#import "RefundOrderReq.h"
#import "OrderServiceApi.h"
#import "AllOrdersController.h"

@interface RefundViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableview;
@property(nonatomic,strong)UIButton *submitBtn;
@property(nonatomic,strong)RefundfootView *footView;
@property(nonatomic,strong)BottomView *bottomView;
@property(nonatomic,strong)RefundOrderReq *orderReq;
@property(nonatomic,strong)UITextField *reasonField;
@end

@implementation RefundViewController
-(UITableView *)tableview{
    if (!_tableview) {
        _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0,[self navHeightWithHeight], SCREENWIDTH, SCREENHEIGHT-[self tabBarHeight]) style:UITableViewStylePlain];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.tableFooterView = [[UIView alloc]init];
        _tableview.separatorColor = DSColorFromHex(0xF0F0F0);
        _tableview.backgroundColor = DSColorFromHex(0xF0F0F0);
        
    }
    return _tableview;
}
-(BottomView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[BottomView alloc]init];
        _bottomView.frame = CGRectMake(0, SCREENHEIGHT-[self tabBarHeight], SCREENWIDTH, [self tabBarHeight]);
        [_bottomView.bottomBtn setTitle:@"提交" forState:UIControlStateNormal];
        [_bottomView.bottomBtn addTarget:self action:@selector(pressBottom) forControlEvents:UIControlEventTouchUpInside];
    }
    return _bottomView;
}

-(RefundfootView *)footView{
    if (!_footView) {
        _footView = [[RefundfootView alloc]init];
        _footView.viewPhotoBgIDCard.superViewController = self;
        _footView.frame = CGRectMake(0, 5, SCREENWIDTH, 135);
    }
    return _footView;
}
-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self setNavWithTitle:@"申请退款"];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableview];
    [self.view addSubview:self.submitBtn];
    self.tableview.tableFooterView = self.footView;
    [self.view addSubview:self.bottomView];
    self.orderReq = [[RefundOrderReq alloc]init];
    __weak typeof(self)weakself = self;
    [self.footView setPhotoBlock:^(NSMutableArray * arr) {
        weakself.orderReq.saleOrderRefundImageList = arr;
    }];
}-(void)setType:(NSInteger)type{
    _type = type;
}
-(void)setCarmodel:(CartProductModel *)carmodel{
    _carmodel = carmodel;
    self.orderReq.saleOrderId = carmodel.saleOrderId;
    self.orderReq.saleOrderProductId = carmodel.saleOrderProductId;
    self.orderReq.saleOrderRefundType = _type;
    self.orderReq.saleOrderRefundAmount = carmodel.productPrice;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section ==1) {
        return 1;
    }
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==1) {
        return 5;
    }else if (section ==2){
        return 30;
    }
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section ==2) {
        return 145;
    }
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section ==1||indexPath.section ==2) {
        return 45;
    }else if (indexPath.section ==0){
        return 120;
    }
    return 0;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headView;
    if (section ==1) {
        headView= [[UIView alloc]init];
        headView.frame = CGRectMake(0, 0, SCREENWIDTH, 5);
        headView.backgroundColor = DSColorFromHex(0xF0F0F0);
    }else if (section ==2){
        UILabel *label = [[UILabel alloc]init];
//        label.text = @"   最多 ¥ 56.0，含发货邮费¥ 0.0";
        label.frame = CGRectMake(15, 0, SCREENWIDTH-30, 30);
        label.font = [UIFont systemFontOfSize:12];
        label.textColor = DSColorFromHex(0x959595);
        return label;
    }
    return headView;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    return self.footView;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section ==0) {
        static NSString *identify = @"SureOrderTableViewCell";
        SureOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
        if (!cell) {
            cell = [[SureOrderTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identify];
        }
        [cell setCarmodel:_carmodel];
        cell.priceLabel.hidden = YES;
        cell.countField.hidden = YES;
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    static NSString *identify = @"UITableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    
    
    if (indexPath.section ==1) {
       
        if (indexPath.row ==0){
            if (!cell) {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
            }
            cell.textLabel.text = [NSString stringWithFormat:@"退款金额：¥%@",_carmodel.productPrice];
            cell.detailTextLabel.textColor = DSColorFromHex(0xFF4C4D);
            cell.accessoryType = UITableViewCellAccessoryNone;
            
        }
       
    }else if (indexPath.section ==2){
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
        }
        cell.textLabel.text = @"退款原因：";
        cell.accessoryType = UITableViewCellAccessoryNone;
        UITextField *field = [[UITextField alloc]init];
        field.placeholder = @"选填";
        field.font = [UIFont systemFontOfSize:15];
        field.frame = CGRectMake(92, 0, SCREENWIDTH-107, 45);
        _reasonField = field;
        [cell addSubview:field];
    }
    
    cell.textLabel.textColor = DSColorFromHex(0x464646);
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   
}
-(void)pressBottom{
    self.orderReq.appId = @"993335466657415169";
    self.orderReq.timestamp = @"529675086";
    
    self.orderReq.token = [UserCacheBean share].userInfo.token;
    self.orderReq.platform = @"ios";
    self.orderReq.saleOrderRefundReason = self.reasonField.text;
    [[OrderServiceApi share]refundOrderWithParam:self.orderReq response:^(id response) {
        if (response) {
            if ([response[@"code"] integerValue] ==200) {
                for (UIViewController *controller in self.navigationController.viewControllers) {
                    if ([controller isKindOfClass:[AllOrdersController class]]) {
                        [self.navigationController popToViewController:controller animated:YES];
                    }
                }
            }
        }
    }];
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
