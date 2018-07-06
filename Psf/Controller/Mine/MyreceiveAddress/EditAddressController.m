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

@interface EditAddressController ()<UITableViewDelegate,UITableViewDataSource>
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
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 4;
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
    if (indexPath.row==0) {
        static NSString *identify = @"UITableViewCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
        }
        cell.textLabel.textColor = DSColorFromHex(0x454545);
        cell.textLabel.font = [UIFont systemFontOfSize:13];
        if (indexPath.row==0) {
            cell.textLabel.text = @"上海  上海市  闵行区";
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    static NSString *identify = @"EditAddressCell";
    EditAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell) {
        cell = [[EditAddressCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    if (indexPath.row ==1) {
        cell.contentField.placeholder = @"请输入详细地址";
    }else if (indexPath.row==2) {
         cell.contentField.placeholder = @"请填写姓名";
    }else if (indexPath.row ==3){
         cell.contentField.placeholder = @"请填写手机号";
    }
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
