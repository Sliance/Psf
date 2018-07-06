//
//  MyReceiveAddressController.m
//  Psf
//
//  Created by 燕来秋mac9 on 2018/6/25.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "MyReceiveAddressController.h"
#import "BottomView.h"
#import "MineAddressCell.h"
#import "EditAddressController.h"

@interface MyReceiveAddressController ()<UITableViewDelegate,UITableViewDataSource,MineAddressCellDelegate>
@property(nonatomic,strong)UITableView *tableview;
@property(nonatomic,strong)BottomView *bottomView;

@end

@implementation MyReceiveAddressController
-(BottomView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[BottomView alloc]init];
        _bottomView.frame = CGRectMake(0, SCREENHEIGHT-[self tabBarHeight], SCREENWIDTH, [self tabBarHeight]);
        [_bottomView.bottomBtn setTitle:@"+ 新建地址" forState:UIControlStateNormal];
        [_bottomView.bottomBtn addTarget:self action:@selector(pressBottom:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _bottomView;
}
-(UITableView *)tableview{
    if (!_tableview) {
        _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0,[self navHeightWithHeight], SCREENWIDTH, SCREENHEIGHT-[self tabBarHeight]) style:UITableViewStylePlain];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.separatorColor = [UIColor clearColor];
        _tableview.tableFooterView = [[UIView alloc]init];
        _tableview.backgroundColor = DSColorFromHex(0xF0F0F0);
    }
    return _tableview;
}
-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self setNavWithTitle:@"我的收货地址"];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableview];
    [self.view addSubview:self.bottomView];
    
}
-(void)pressBottom:(UIButton*)sender{
    EditAddressController *editVC = [[EditAddressController alloc]init];
    [self.navigationController pushViewController:editVC animated:YES];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 15;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 80;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  
    static NSString *identify = @"identify";
    MineAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell) {
        cell = [[MineAddressCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    cell.delegate = self;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.textColor = DSColorFromHex(0x464646);
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

}
-(void)editAddressIndex:(NSInteger)index{
    EditAddressController *editVC = [[EditAddressController alloc]init];
    [self.navigationController pushViewController:editVC animated:YES];
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
