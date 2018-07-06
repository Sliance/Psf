//
//  detailGoodsViewController.m
//  Psf
//
//  Created by 燕来秋mac9 on 2018/6/22.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "detailGoodsViewController.h"
#import "ZSCycleScrollView.h"
#import "EvaluateViewController.h"
#import "GoodHeadView.h"
#import "GoodEvaluateView.h"
#import "GoodFootView.h"
#import "GetCouponsCellView.h"
#import "GetCouponsView.h"
#import "TourDiyGooddetailView.h"
#import "DetailGroupController.h"
#import "GoodBottomView.h"


@interface detailGoodsViewController ()<UIScrollViewDelegate,ZSCycleScrollViewDelegate,GetCouponsViewDelegate>

@property(nonatomic,strong)UIScrollView *bgscrollow;
@property(nonatomic,strong)ZSCycleScrollView *cycleScroll;

@property(nonatomic,strong)GoodEvaluateView *evaView;
@property(nonatomic,strong)GoodHeadView *headView;
@property(nonatomic,strong)GoodFootView *footView;
@property(nonatomic,strong)GetCouponsCellView *couponCell;
@property(nonatomic,strong)GetCouponsView *couponView;
@property(nonatomic,strong)TourDiyGooddetailView *tourDiyView;
@property(nonatomic,strong)GoodBottomView *bottomView;

@end

@implementation detailGoodsViewController
-(GoodEvaluateView *)evaView{
    if (!_evaView) {
        _evaView = [[GoodEvaluateView alloc]init];
    }
    return _evaView;
}
-(TourDiyGooddetailView *)tourDiyView{
    if (!_tourDiyView) {
        _tourDiyView = [[TourDiyGooddetailView alloc]init];
    }
    return _tourDiyView;
}
-(GoodHeadView *)headView{
    if (!_headView) {
        _headView = [[GoodHeadView alloc]init];
    }
    return _headView;
}
-(GoodFootView *)footView{
    if (!_footView) {
        _footView = [[GoodFootView alloc]init];
    }
    return _footView;
}
-(GoodBottomView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[GoodBottomView alloc]initWithFrame:CGRectMake(0, SCREENHEIGHT-[self tabBarHeight], SCREENHEIGHT, [self tabBarHeight])];
        
    }
    return _bottomView;
}
-(GetCouponsCellView *)couponCell{
    if (!_couponCell) {
        _couponCell = [[GetCouponsCellView alloc]init];
    }
    return _couponCell;
}
-(GetCouponsView *)couponView{
    if (!_couponView) {
        _couponView = [[GetCouponsView alloc]init];
        _couponView.hidden = YES;
         _couponView.frame = CGRectMake(0, [self navHeightWithHeight], SCREENWIDTH, SCREENHEIGHT);
        _couponView.delegate = self;
    }
    return _couponView;
}
-(ZSCycleScrollView *)cycleScroll{
    if (!_cycleScroll) {
        _cycleScroll = [[ZSCycleScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 375)];
        _cycleScroll.imageSize = CGSizeMake(SCREENWIDTH, 375);
        _cycleScroll.delegate =self;
        NSArray *images = [[NSArray alloc] initWithObjects:[UIImage imageNamed:@"banner"],[UIImage imageNamed:@"banner"],[UIImage imageNamed:@"banner"],[UIImage imageNamed:@"banner"],nil];
        _cycleScroll.localImageGroups = images;
        _cycleScroll.autoScrollTimeInterval = 3.0;
        _cycleScroll.dotColor = [UIColor redColor];
    }
    return _cycleScroll;
}
-(UIScrollView *)bgscrollow{
    if (!_bgscrollow) {
        _bgscrollow = [[UIScrollView alloc]initWithFrame:CGRectMake(0, [self navHeightWithHeight], SCREENWIDTH, SCREENHEIGHT)];
        _bgscrollow.contentSize = CGSizeMake(0, SCREENHEIGHT*3);
        _bgscrollow.delegate = self;
        _bgscrollow.backgroundColor = DSColorFromHex(0xF0F0F0);
    }
    return _bgscrollow;
}
-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self setNavWithTitle:@"商品"];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self.view addSubview:self.bgscrollow];
    [self.bgscrollow addSubview:self.cycleScroll];
    [self.bgscrollow addSubview:self.headView];
    [self.bgscrollow addSubview:self.evaView];
    [self.bgscrollow addSubview:self.footView];
    [self.bgscrollow addSubview:self.couponCell];
    [self.bgscrollow addSubview:self.tourDiyView];
     [self.view addSubview:self.bottomView];
    [self.view addSubview:self.couponView];
    self.headView.frame = CGRectMake(0, self.cycleScroll.ctBottom, SCREENWIDTH, 114);
    self.tourDiyView.frame = CGRectMake(0, self.headView.ctBottom, SCREENWIDTH, 192);
    self.couponCell.frame = CGRectMake(0, self.tourDiyView.ctBottom, SCREENWIDTH, 50);
    self.evaView.frame = CGRectMake(0, self.couponCell.ctBottom, SCREENWIDTH, 50);
    self.footView.frame = CGRectMake(0, self.evaView.ctBottom+5, SCREENWIDTH, 253);
   __weak typeof(self) _weakSelf = self;
    [self.evaView setSkipBlock:^(NSInteger index) {
        EvaluateViewController *evaVC = [[EvaluateViewController alloc]init];
        [_weakSelf.navigationController pushViewController:evaVC animated:YES];
    }];
    [self.couponCell setPressCoupBlock:^(NSInteger index) {
        _weakSelf.couponView.hidden = NO;
    }];
    [self.tourDiyView setPressGoBlock:^(NSInteger index) {
        DetailGroupController *detailVC = [[DetailGroupController alloc]init];
        [_weakSelf.navigationController pushViewController:detailVC animated:YES];
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self adjustNavigationUI:self.navigationController];
    
}

-(void)cycleScrollView:(ZSCycleScrollView *)cycleScrollView didSelectItemAtRow:(NSInteger)row{
    EvaluateViewController *evaVC = [[EvaluateViewController alloc]init];
    [self.navigationController pushViewController:evaVC animated:YES];
}
-(void)finishCouponView{
    self.couponView.hidden = YES;
}
-(void)getCouponViewWithIndex:(NSInteger)index{
    
}
-(void)pressShareBtn:(UIButton*)sender{
    
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
