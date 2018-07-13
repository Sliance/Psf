//
//  EditAddressController.m
//  Psf
//
//  Created by 燕来秋mac9 on 2018/6/26.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "EditAddressController.h"
#import "BottomView.h"
#import "EditAddressCell.h"
#import "DefaultAddressFootView.h"
#import "ZHMapAroundInfoViewController.h"
#import "AddressServiceApi.h"

@interface EditAddressController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    UITextField *_addressfield;
    UITextField *_namefield;
    UITextField *_numfield;
}
@property(nonatomic,strong)UITableView *tableview;
@property(nonatomic,strong)BottomView *bottomView;
@property(nonatomic,strong)DefaultAddressFootView *footView;

@end

@implementation EditAddressController



-(DefaultAddressFootView *)footView{
    if (!_footView) {
        _footView = [[DefaultAddressFootView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 59)];
        _footView.userInteractionEnabled  = YES;
    
    }
    return _footView;
}
-(BottomView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[BottomView alloc]init];
        _bottomView.frame = CGRectMake(0, SCREENHEIGHT-[self tabBarHeight], SCREENWIDTH, [self tabBarHeight]);
        [_bottomView.bottomBtn setTitle:@"保存" forState:UIControlStateNormal];
        [_bottomView.bottomBtn addTarget:self action:@selector(pressBottom) forControlEvents:UIControlEventTouchUpInside];
    }
    return _bottomView;
}
-(UITableView *)tableview{
    if (!_tableview) {
        _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0,[self navHeightWithHeight], SCREENWIDTH, SCREENHEIGHT-[self tabBarHeight]) style:UITableViewStylePlain];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.separatorColor = DSColorFromHex(0xF0F0F0);
        _tableview.tableFooterView = [[UIView alloc]init];
        _tableview.backgroundColor = DSColorFromHex(0xF0F0F0);
    }
    return _tableview;
}
-(void)setChangeReq:(ChangeAddressReq *)changeReq{
    
    _changeReq = [[ChangeAddressReq alloc]init];
    _changeReq = changeReq;
    _changeReq.memberAddressCity = @"000";
    self.footView.morenBtn.selected =changeReq.memberAddressIsDefault;
    [_tableview reloadData];

}
-(void)setType:(NSInteger)type{
    _type = type;
    
}

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self setNavWithTitle:@"新建地址"];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = DSColorFromHex(0xF0F0F0);
    [self.view addSubview:self.tableview];
    [self.view addSubview:self.bottomView];
    
    self.tableview.tableFooterView = self.footView;
    __weak typeof(self)weakself = self;
    [self.footView setMorenBlock:^(BOOL selected) {
        weakself.changeReq.memberAddressIsDefault = selected;
    }];
}
-(void)pressBottom{
    if (_type ==0) {
        [self addAddress];
    }else{
        [self changeAddress];
    }
}
-(void)addAddress{
    self.changeReq.appId = @"993335466657415169";
    self.changeReq.timestamp = @"529675086";
    
    self.changeReq.token = @"eyJleHBpcmVUaW1lIjoxNTYxNjI1OTU3ODc0LCJ1c2VySWQiOiIxMDEwNDEyNTM0NzkxNTUzMDI2Iiwib2JqZWN0SWQiOiIxMDEwNDEyNTM0NzkxNTUzMDI1In0=";
    self.changeReq.platform = @"ios";
    
    [[AddressServiceApi share]addAddressWithParam:self.changeReq response:^(id response) {
        
    }];
}
-(void)changeAddress{
    self.changeReq.appId = @"993335466657415169";
    self.changeReq.timestamp = @"529675086";
    
    self.changeReq.token = @"eyJleHBpcmVUaW1lIjoxNTYxNjI1OTU3ODc0LCJ1c2VySWQiOiIxMDEwNDEyNTM0NzkxNTUzMDI2Iiwib2JqZWN0SWQiOiIxMDEwNDEyNTM0NzkxNTUzMDI1In0=";
    self.changeReq.platform = @"ios";
    [[AddressServiceApi share]updateAddressWithParam:self.changeReq response:^(id response) {
        
    }];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 5;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 15;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 45;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 59;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0||indexPath.row ==1) {
        static NSString *identify = @"UITableViewCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
        }
        cell.textLabel.textColor = DSColorFromHex(0x454545);
        cell.textLabel.font = [UIFont systemFontOfSize:13];
        if (indexPath.row==0) {
            
            if (_type ==0) {
                cell.textLabel.text = @"请选择省市区";
            }else{
                if (self.changeReq.memberAddressProvince.length<1) {
                    cell.textLabel.text = @"请选择省市区";
                }else{
                cell.textLabel.text = [NSString stringWithFormat:@"%@   %@   %@",self.changeReq.memberAddressProvince,self.changeReq.memberAddressCity,self.changeReq.memberAddressArea];
                }
            }
        }else if (indexPath.row ==1){
            cell.textLabel.text =self.changeReq.memberAddressPositionDetail;
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    static NSString *identify = @"EditAddressCell";
    EditAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell) {
        cell = [[EditAddressCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    if (indexPath.row ==2) {
        cell.contentField.placeholder = @"请输入详细地址";
        cell.contentField.text = _changeReq.memberAddressDetail;
        _addressfield = cell.contentField;
    }else if (indexPath.row==3) {
         cell.contentField.placeholder = @"请填写姓名";
        cell.contentField.text = _changeReq.memberAddressName;
        _namefield = cell.contentField;
    }else if (indexPath.row ==4){
         cell.contentField.placeholder = @"请填写手机号";
        cell.contentField.text = _changeReq.memberAddressMobile;
        _numfield = cell.contentField;
    }
    cell.contentField.delegate = self;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row ==1) {
        ZHMapAroundInfoViewController *mapVC = [[ZHMapAroundInfoViewController alloc]initWithNibName:@"ZHMapAroundInfoViewController" bundle:[NSBundle mainBundle]];
        __weak typeof(self)weakself = self;
        [mapVC setGetAddressBlock:^(ZHPlaceInfoModel * model) {
            weakself.changeReq = [[ChangeAddressReq alloc]init];
            weakself.changeReq.memberAddressPositionDetail = model.thoroughfare;
            weakself.changeReq.memberAddressLatitude = [NSString stringWithFormat:@"%f",model.coordinate.latitude];
            weakself.changeReq.memberAddressLongitude = [NSString stringWithFormat:@"%f",model.coordinate.longitude];
            [weakself.tableview reloadData];
            
        }];
        [self.navigationController pushViewController:mapVC animated:YES];
    }
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    self.changeReq.memberAddressName = _namefield.text;
    self.changeReq.memberAddressMobile = _numfield.text;
    self.changeReq.memberAddressDetail = _addressfield.text;
    return [textField resignFirstResponder];
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
