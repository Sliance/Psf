//
//  UseCouponController.m
//  Psf
//
//  Created by 燕来秋mac9 on 2018/7/5.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "UseCouponController.h"
#import "MyCouponCell.h"
#import "CouponServiceApi.h"

@interface UseCouponController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableview;
@property(nonatomic,strong)UILabel *titlelabel;
@property(nonatomic,strong)UIButton *titleBtn;
@property(nonatomic,strong)NSArray *dataArr;

@end

@implementation UseCouponController
-(UITableView *)tableview{
    if (!_tableview) {
        _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 44+[self navHeightWithHeight], SCREENWIDTH, SCREENHEIGHT-[self tabBarHeight]) style:UITableViewStylePlain];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.separatorColor = [UIColor whiteColor];
        _tableview.tableFooterView = [[UIView alloc]init];
        _tableview.backgroundColor = DSColorFromHex(0xF0F0F0);
    }
    return _tableview;
}
-(UILabel *)titlelabel{
    if (!_titlelabel) {
        _titlelabel = [[UILabel alloc]init];
        _titlelabel.text = @"不使用优惠券";
        _titlelabel.font = [UIFont systemFontOfSize:15];
        _titlelabel.textColor = DSColorFromHex(0x474747);
        _titlelabel.frame = CGRectMake(15, [self navHeightWithHeight]+9, SCREENWIDTH-60, 35);
    }
    return _titlelabel;
}
-(UIButton *)titleBtn{
    if (!_titleBtn) {
        _titleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_titleBtn setImage:[UIImage imageNamed:@"shopping_normal"] forState:UIControlStateNormal];
        [_titleBtn setImage:[UIImage imageNamed:@"shopping_selected"] forState:UIControlStateSelected];
        [_titleBtn addTarget:self action:@selector(pressBtn:) forControlEvents:UIControlEventTouchUpInside];
        _titleBtn.frame = CGRectMake(SCREENWIDTH-35, 19+[self navHeightWithHeight], 20, 20);
        
    }
    return _titleBtn;
}
-(void)pressBtn:(UIButton*)sender{
    sender.selected = !sender.selected;
}
-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self setTitle:@"优惠券"];
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
    [self.view addSubview:self.titlelabel];
     [self.view addSubview:self.titleBtn];
    [self reloadData];
}
-(void)reloadData{
    StairCategoryReq *req = [[StairCategoryReq alloc]init];
    req.appId = @"993335466657415169";
    req.timestamp = @"529675086";
    
    req.token = [UserCacheBean share].userInfo.token;
    req.version = @"1.0.0";
    req.platform = @"ios";
//    req.couponType = type;
    __weak typeof(self)weakself = self;
    [[CouponServiceApi share]fillOrderCouponWithParam:req response:^(id response) {
        
    }];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 2;
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
