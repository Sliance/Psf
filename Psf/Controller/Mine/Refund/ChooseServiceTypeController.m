//
//  ChooseServiceTypeController.m
//  Psf
//
//  Created by 燕来秋mac9 on 2018/7/4.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "ChooseServiceTypeController.h"
#import "SureOrderTableViewCell.h"
#import "RefundViewController.h"
#import "OrderRuleController.h"

@interface ChooseServiceTypeController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableview;

@end

@implementation ChooseServiceTypeController
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
-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self setTitle:@"选择服务类型"];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    if (@available(iOS 11.0, *)) {
        _tableview.contentInsetAdjustmentBehavior = NO;
    } else {
        self.navigationController.navigationBar.translucent = NO;
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    [self.view addSubview:self.tableview];
     [self setRightButtonWithIcon:[UIImage imageNamed:@"jifen_rule"]];
}
-(void)didRightClick{
    OrderRuleController*ruleVC = [[OrderRuleController alloc]init];
    [ruleVC setType:1];
    [self.navigationController pushViewController:ruleVC animated:YES];
}
-(void)setCarmodel:(CartProductModel *)carmodel{
    _carmodel = carmodel;
}
-(void)setModel:(OrderListRes *)model{
    _model = model;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==1) {
        return 5;
    }
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section ==1||indexPath.section ==2) {
        return 66;
    }
    return 120;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headView;
    if (section ==1) {
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
        cell.priceLabel.hidden = YES;
        cell.countField.hidden = YES;
        [cell setCarmodel:_carmodel];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    static NSString *identify = @"UITableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identify];
    }
    
    if (indexPath.section ==1) {
        cell.textLabel.text = @"仅退款";
        cell.detailTextLabel.text = @"坏单包赔，商家将快速响应消费者需求";
    }else if (indexPath.section ==2){
        cell.textLabel.text = @"退货退款";
        cell.detailTextLabel.text = @"坏单包赔，商家将快速响应消费者需求 拷贝";
        
    }
    cell.textLabel.textColor = DSColorFromHex(0x464646);
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    cell.detailTextLabel.textColor = DSColorFromHex(0x969696);
    cell.detailTextLabel.font = [UIFont systemFontOfSize:12];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section ==1||indexPath.section ==2) {
        RefundViewController *refundVC = [[RefundViewController alloc]init];
        [refundVC setType:indexPath.section-1];
        [refundVC setCarmodel:_carmodel];
        [self.navigationController pushViewController:refundVC animated:YES];
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
