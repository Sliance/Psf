//
//  MyIntegralController.m
//  Psf
//
//  Created by 燕来秋mac9 on 2018/7/3.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "MyIntegralController.h"
#import "BottomView.h"
#import "TradingDetailController.h"
#import "MineViewController.h"

@interface MyIntegralController ()<UIScrollViewDelegate>

@property(nonatomic,strong)UIScrollView *bgscrollow;
@property(nonatomic,strong)BottomView *bottomView;
@property(nonatomic,strong)UIView *headView;
@property(nonatomic,strong)UILabel *countLabel;
@property(nonatomic,strong)UILabel *detailLabel;
@property(nonatomic,strong)UIButton *detailBtn;
@end

@implementation MyIntegralController
-(UIScrollView *)bgscrollow{
    if (!_bgscrollow) {
        _bgscrollow = [[UIScrollView alloc]initWithFrame:CGRectMake(0, [self navHeightWithHeight], SCREENWIDTH, SCREENHEIGHT)];
        _bgscrollow.delegate = self;
    }
    return _bgscrollow;
}
-(BottomView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[BottomView alloc]init];
        _bottomView.frame = CGRectMake(0, SCREENHEIGHT-53, SCREENWIDTH, 53);
        [_bottomView.bottomBtn setTitle:@"去购物" forState:UIControlStateNormal];
        _bottomView.backgroundColor = DSColorFromHex(0xF0F0F0);
        [_bottomView.bottomBtn addTarget:self action:@selector(pressBottom:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _bottomView;
}
-(UIView *)headView{
    if (!_headView) {
        _headView = [[UIView alloc]init];
        _headView.backgroundColor = [UIColor whiteColor];
        
    }
    return _headView;
}
-(UILabel *)countLabel{
    if (!_countLabel) {
        _countLabel = [[UILabel alloc]init];
        _countLabel.font = [UIFont systemFontOfSize:24];
        _countLabel.text = @"";
        _countLabel.textColor = DSColorFromHex(0x323232);
    }
    return _countLabel;
}
-(UILabel *)detailLabel{
    if (!_detailLabel) {
        _detailLabel = [[UILabel alloc]init];
        _detailLabel.font = [UIFont systemFontOfSize:15];
        _detailLabel.text = @"满额积分自动抵扣现金";
        _detailLabel.textColor = DSColorFromHex(0x969696);
    }
    return _detailLabel;
}
-(UIButton *)detailBtn{
    if (!_detailBtn) {
        _detailBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_detailBtn setTitle:@"积分明细" forState:UIControlStateNormal];
        [_detailBtn setTitleColor:DSColorFromHex(0x969696) forState:UIControlStateNormal];
        _detailBtn.backgroundColor = DSColorFromHex(0xF0F0F0);
        _detailBtn.frame = CGRectMake(0, 0, SCREENWIDTH, 30);
        [_detailBtn addTarget:self action:@selector(pressDetail:) forControlEvents:UIControlEventTouchUpInside];
        _detailBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    }
    return _detailBtn;
}
-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self setTitle:@"我的积分"];
        
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    if (@available(iOS 11.0, *)) {
        _bgscrollow.contentInsetAdjustmentBehavior = NO;
    } else {
        self.navigationController.navigationBar.translucent = NO;
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    [self.view addSubview:self.bgscrollow];
    [self.bgscrollow addSubview:self.headView];
    [self.bgscrollow addSubview:self.detailBtn];
    [self.view addSubview:self.bottomView];
    [self.headView addSubview:self.countLabel];
    [self.headView addSubview:self.detailLabel];
    self.headView.frame = CGRectMake(0, 0, SCREENWIDTH, 122);
    self.detailBtn.frame = CGRectMake(0, self.headView.ctBottom, SCREENWIDTH, 40);
    self.countLabel.frame = CGRectMake(15, 30, SCREENWIDTH-30, 24);
    self.detailLabel.frame = CGRectMake(15, self.countLabel.ctBottom+15, SCREENWIDTH-30, 15);
    
}
-(void)setDic:(NSMutableDictionary *)dic{
    _dic = dic;
    _countLabel.text = [NSString stringWithFormat:@"%@积分",dic[@"memberPoint"]];
}
-(void)pressDetail:(UIButton*)sender{
    TradingDetailController *detailVC = [[TradingDetailController alloc]init];
    detailVC.type =2;
    [self.navigationController pushViewController:detailVC animated:YES];
}
-(void)pressBottom:(UIButton*)sedner{
    self.tabBarController.selectedIndex = 1;
    for (UIViewController *controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[MineViewController class]]) {
            [self.navigationController popToViewController:controller animated:YES];
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
