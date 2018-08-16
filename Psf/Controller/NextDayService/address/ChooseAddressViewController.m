//
//  ChooseAddressViewController.m
//  Psf
//
//  Created by 燕来秋mac9 on 2018/6/25.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "ChooseAddressViewController.h"
#import "ChooseCityHeadView.h"
#import "ChooseAddressTableViewCell.h"
#import "BottomView.h"
#import "AddressServiceApi.h"
#import "MineAddressCell.h"
#import "EditAddressController.h"

@interface ChooseAddressViewController ()<UITableViewDelegate,UITableViewDataSource,MineAddressCellDelegate>
@property(nonatomic,strong)UITableView *tableview;
@property(nonatomic,strong)ChooseCityHeadView *chooseView;
@property(nonatomic,strong)BottomView *bottomView;
@property(nonatomic,strong)NSMutableArray *dataArr;
@end

@implementation ChooseAddressViewController
-(ChooseCityHeadView *)chooseView{
    if (!_chooseView) {
        _chooseView = [[ChooseCityHeadView alloc]initWithFrame:CGRectMake(0, 64, SCREENWIDTH, 46)];
    }
    return _chooseView;
}
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
        _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 11+[self navHeightWithHeight], SCREENWIDTH, SCREENHEIGHT-[self navHeightWithHeight]-[self tabBarHeight]-46) style:UITableViewStyleGrouped];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.separatorColor = [UIColor whiteColor];
        _tableview.tableFooterView = [[UIView alloc]init];
        _tableview.backgroundColor = DSColorFromHex(0xF0F0F0);
    }
    return _tableview;
}
-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self setNavWithTitle:@"选择收货地址"];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
   [self.view addSubview:self.backBtn];
    [self.view addSubview:self.bottomView];
     [self setTextFieldLeftView:self.chooseView.searchField :@"search_icon":20];
    [self.view addSubview:self.tableview];
     [self.view addSubview:self.chooseView];
    self.dataArr = [NSMutableArray array];
    [self requestAddressList];
}
-(void)requestAddressList{
    AddressBaeReq *req = [[AddressBaeReq alloc]init];
    req.appId = @"993335466657415169";
    req.timestamp = @"529675086";
    
    req.token = [UserCacheBean share].userInfo.token;
    req.systemVersion = @"1.0.0";
    req.platform = @"ios";
    __weak typeof(self)weakself = self;
    [[AddressServiceApi share]getAddressListWithParam:req response:^(id response) {
        if (response!= nil) {
            [weakself.dataArr removeAllObjects];
            [weakself.dataArr addObjectsFromArray:response];
            [weakself.tableview reloadData];
        }
    }];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section ==1) {
        return self.dataArr.count;
    }
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 15;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section ==1){
        return 75;
        
    }
    return 44;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section ==1){
        return @"我的收货地址";
    }
  return @"";
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section ==1) {
        static NSString *identify = @"MineAddressCell";
        MineAddressCell *choosecell = [tableView dequeueReusableCellWithIdentifier:identify];
        if (!choosecell) {
            choosecell = [[MineAddressCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
        }
        choosecell.delegate = self;
        choosecell.selectionStyle = UITableViewCellSelectionStyleNone;
        choosecell.textLabel.textColor = DSColorFromHex(0x464646);
        choosecell.textLabel.font = [UIFont systemFontOfSize:14];
        ChangeAddressReq *model = _dataArr[indexPath.section];
        [choosecell setIndex:indexPath.row];
        [choosecell setModel:model];
        return choosecell;
    }
    static NSString *identify = @"identify";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    if (indexPath.section ==0) {
        cell.textLabel.text = @"当前：闵行区旭辉·浦江国际";
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.textColor = DSColorFromHex(0x464646);
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
}
-(void)editAddressIndex:(NSInteger)index{
    EditAddressController *editVC = [[EditAddressController alloc]init];
    ChangeAddressReq *model = _dataArr[index];
    [editVC setChangeReq:model];
    [editVC setType:1];
    [self.navigationController pushViewController:editVC animated:YES];
}
-(void)pressBottom:(UIButton*)sender{
    EditAddressController *editVC = [[EditAddressController alloc]init];
    [editVC setType:0];
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
