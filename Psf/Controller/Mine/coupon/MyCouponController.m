//
//  MyCouponController.m
//  Psf
//
//  Created by 燕来秋mac9 on 2018/6/25.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "MyCouponController.h"
#import "MyCouponCell.h"
#import "MyCouponHeadView.h"
#import "CouponServiceApi.h"

@interface MyCouponController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableview;

@property(nonatomic,strong)NSMutableArray *dataArr;
@property(nonatomic,strong)NSMutableArray *singleArr;
@property(nonatomic,strong)MyCouponHeadView *headView;

@property(nonatomic,assign)NSInteger type;
@end

@implementation MyCouponController

-(UITableView *)tableview{
    if (!_tableview) {
        _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 120+[self navHeightWithHeight], SCREENWIDTH, SCREENHEIGHT-[self tabBarHeight]) style:UITableViewStylePlain];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.separatorColor = [UIColor whiteColor];
        _tableview.tableFooterView = [[UIView alloc]init];
        _tableview.backgroundColor = DSColorFromHex(0xF0F0F0);
    }
    return _tableview;
}
-(MyCouponHeadView *)headView{
    if (!_headView) {
        _headView = [[MyCouponHeadView alloc]init];
        _headView.frame = CGRectMake(0, [self navHeightWithHeight], SCREENWIDTH, 120);
    }
    return _headView;
}
-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self setNavWithTitle:@"我的优惠券"];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableview];
    [self.view addSubview:self.headView];
    _dataArr = [NSMutableArray array];
    _singleArr = [NSMutableArray array];
    _type =0;
    [self getCouponList:@"allProduct"];
    [self getCouponList:@"singleProduct"];
    __weak typeof(self)weakself = self;
    [self.headView setTypeBlock:^(NSInteger index) {
        if (index ==0) {
//           [weakself getCouponList:@"allProduct"];
            weakself.type =0;
            [weakself.tableview reloadData];
        }else if (index ==2){
//            [weakself getCouponList:@"singleProduct"];
            weakself.type = 2;
            [weakself.tableview reloadData];
        }
    }];
}
-(void)getCouponList:(NSString*)type{
    StairCategoryReq *req = [[StairCategoryReq alloc]init];
    req.appId = @"993335466657415169";
    req.timestamp = @"529675086";
    
    req.token = @"eyJleHBpcmVUaW1lIjoxNTYxNjI1OTU3ODc0LCJ1c2VySWQiOiIxMDEwNDEyNTM0NzkxNTUzMDI2Iiwib2JqZWN0SWQiOiIxMDEwNDEyNTM0NzkxNTUzMDI1In0=";
    req.version = @"1.0.0";
    req.platform = @"ios";
    req.couponType = type;
    __weak typeof(self)weakself = self;
    [[CouponServiceApi share]requestMineCouponListWithParam:req response:^(id response) {
        if (response!= nil) {
            [weakself.dataArr removeAllObjects];
            [weakself.singleArr removeAllObjects];
            
            if ([type isEqualToString:@"allProduct"]) {
                [weakself.dataArr addObjectsFromArray:response];
                weakself.headView.allTitle.text = [NSString stringWithFormat:@"%ld张",weakself.dataArr.count];
                  [weakself getCouponList:@"singleProduct"];
            }else if ([type isEqualToString:@"singleProduct"]){
                [weakself.singleArr addObjectsFromArray:response];
                 weakself.headView.singleTitle.text = [NSString stringWithFormat:@"%ld张",weakself.singleArr.count];
            }
          
            [weakself.tableview reloadData];
        }
    }];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.type ==2) {
        return _singleArr.count;
    }
    return _dataArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 5;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identify = @"identify";
    MyCouponCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell) {
        cell = [[MyCouponCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    CouponListRes *model = _dataArr[indexPath.row];
    [cell setModel:model];
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
