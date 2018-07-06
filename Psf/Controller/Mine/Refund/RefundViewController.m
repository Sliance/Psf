//
//  RefundViewController.m
//  Psf
//
//  Created by 燕来秋mac9 on 2018/7/4.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "RefundViewController.h"
#import "SureOrderTableViewCell.h"
@interface RefundViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableview;
@property(nonatomic,strong)UIButton *submitBtn;

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
-(UIButton *)submitBtn{
    if (!_submitBtn) {
        _submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_submitBtn setTitle:@"提交" forState:UIControlStateNormal];
        _submitBtn.backgroundColor = DSColorFromHex(0xFF4C4D);
        [_submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _submitBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    }
    return _submitBtn;
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
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section ==1) {
        return 2;
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

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section ==1||indexPath.section ==2) {
        return 45;
    }
    return 120;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headView;
    if (section ==1) {
        headView= [[UIView alloc]init];
        headView.frame = CGRectMake(0, 0, SCREENWIDTH, 5);
        headView.backgroundColor = DSColorFromHex(0xF0F0F0);
    }else if (section ==2){
        UILabel *label = [[UILabel alloc]init];
        label.text = @"   最多 ¥ 56.0，含发货邮费¥ 0.0";
        label.frame = CGRectMake(15, 0, SCREENWIDTH-30, 30);
        label.font = [UIFont systemFontOfSize:12];
        label.textColor = DSColorFromHex(0x959595);
        return label;
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
        cell.subBtn.hidden = YES;
        cell.addBtn.hidden = YES;
        cell.countField.hidden = YES;
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    static NSString *identify = @"UITableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    
    
    if (indexPath.section ==1) {
        if (indexPath.row ==0) {
            if (!cell) {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identify];
            }
            cell.textLabel.text = @"退款原因";
            cell.detailTextLabel.text = @"请选择";
            cell.detailTextLabel.font = [UIFont systemFontOfSize:12];
            cell.detailTextLabel.textColor = DSColorFromHex(0x969696);
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        } else {
            if (!cell) {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
            }
            cell.textLabel.text = @"退款金额：¥56.0";
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
        [cell addSubview:field];
    }
    
    cell.textLabel.textColor = DSColorFromHex(0x464646);
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
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
