//
//  ZSPageViewController.m
//  Psf
//
//  Created by 燕来秋mac9 on 2018/6/26.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "ZSPageViewController.h"
#import "ZSCycleScrollView.h"
#import "NextCollectionViewCell.h"
#import "detailGoodsViewController.h"
#import "NextDayServiceController.h"
#import "NextCollectionHeadView.h"
#import "DetailSortController.h"
#import "GroupViewController.h"
#import "RechargeViewController.h"

@interface ZSPageViewController ()<ZSCycleScrollViewDelegate,UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong)UICollectionView *collectionView;
@property(nonatomic,strong)ZSCycleScrollView *cycleScroll;
@property(nonatomic,strong)UIScrollView *bgScrollow;

@end
static NSString *cellId = @"cellId";
@implementation ZSPageViewController
-(UIScrollView *)bgScrollow{
    if (!_bgScrollow) {
        _bgScrollow = [[UIScrollView alloc]init];
        _bgScrollow.contentSize = CGSizeMake(0, SCREENHEIGHT*10);
        _bgScrollow.delegate = self;
    }
    return _bgScrollow;
}
-(ZSCycleScrollView *)cycleScroll{
    if (!_cycleScroll) {
        _cycleScroll = [[ZSCycleScrollView alloc] init];
        _cycleScroll.imageSize = CGSizeMake(SCREENWIDTH, 200);
        _cycleScroll.delegate =self;
        NSArray *images = [[NSArray alloc] initWithObjects:[UIImage imageNamed:@"banner"],[UIImage imageNamed:@"banner"],[UIImage imageNamed:@"banner"],[UIImage imageNamed:@"banner"],nil];
        _cycleScroll.localImageGroups = images;
        _cycleScroll.autoScrollTimeInterval = 3.0;
        _cycleScroll.dotColor = [UIColor redColor];
    }
    return _cycleScroll;
}
-(UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        layout.itemSize = CGSizeMake(165, 165);
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT*10) collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.scrollEnabled = NO;
        [_collectionView registerClass:[NextCollectionViewCell class] forCellWithReuseIdentifier:cellId];
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"reusableView"];
    }
    return _collectionView;
}
-(void)setSelectedIndex:(NSInteger)selectedIndex{
    _selectedIndex = selectedIndex;
}
#pragma 以上三个方法是必须实现的
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.bgScrollow];
    [self.bgScrollow addSubview:self.cycleScroll];
    [self.bgScrollow addSubview:self.collectionView];
    self.bgScrollow.frame = CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT);
    self.cycleScroll.frame = CGRectMake(0, 0,SCREENWIDTH, 340);
    self.collectionView.frame = CGRectMake(0, self.cycleScroll.ctBottom, SCREENWIDTH, SCREENHEIGHT*10);
    self.view.backgroundColor = [UIColor whiteColor];
    __weak typeof(self)weakself = self;
    [self.cycleScroll setSelectedItemBlock:^(NSInteger index) {
        if (index==0) {
            GroupViewController *groupVC = [[GroupViewController alloc]init];
            groupVC.hidesBottomBarWhenPushed = YES;
            groupVC.goodtype = GOODTYPEPRESELL;
            [weakself.navigationController pushViewController:groupVC animated:YES];
        }else if (index ==1){
            GroupViewController *groupVC = [[GroupViewController alloc]init];
            groupVC.hidesBottomBarWhenPushed = YES;
            groupVC.goodtype = GOODTYPEGROUP;
            [weakself.navigationController pushViewController:groupVC animated:YES];
        }else if (index ==2){
            RechargeViewController *rechargeVC = [[RechargeViewController alloc]init];
            rechargeVC.hidesBottomBarWhenPushed = YES;
            [weakself.navigationController pushViewController:rechargeVC animated:YES];
        }
    }];
}


-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 2;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 6;
}
//设置每个item的UIEdgeInsets
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 15, 0, 15);
    
}

//设置每个item水平间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return -10;
}


////设置每个item垂直间距
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
//{
//    return 0;
//}
//设置每个item的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(165, 300);
    
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NextCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
    return CGSizeMake(SCREENWIDTH, 70);
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    
    UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"reusableView" forIndexPath:indexPath];
    
    
    for (UIView *view in headerView.subviews) {
        if ([view isKindOfClass:[UIView class]]) {
            [view removeFromSuperview];
        }
    }
    NextCollectionHeadView* validView = [[NextCollectionHeadView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 69)];
    __weak typeof(self)weakSelf = self;
    [validView setPressTypeBlock:^(NSInteger index) {
        DetailSortController *detailVC = [[DetailSortController alloc]init];
        detailVC.hidesBottomBarWhenPushed = YES;
        [weakSelf.navigationController pushViewController:detailVC animated:YES];
    }];
    [headerView addSubview:validView];
    return headerView;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    detailGoodsViewController *vc = [[detailGoodsViewController alloc]init];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vc];
//    [self showViewController:nav sender:nil];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    
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
