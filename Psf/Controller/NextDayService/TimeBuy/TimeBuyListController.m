//
//  TimeBuyListController.m
//  Psf
//
//  Created by zhangshu on 2019/2/22.
//  Copyright © 2019 zhangshu. All rights reserved.
//

#import "TimeBuyListController.h"
#import "NextCollectionViewCell.h"
#import "detailGoodsViewController.h"
#import "NextServiceApi.h"

@interface TimeBuyListController ()<UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong)UICollectionView *collectionView;
@property(nonatomic,strong)NSMutableArray *dataArr;
@end

@implementation TimeBuyListController
-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        [self setTitle:@"限时购"];
    }
    return self;
}
-(UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        layout.itemSize = CGSizeMake(165, 165);
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT) collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[NextCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([NextCollectionViewCell class])];
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"reusableView"];
    }
    return _collectionView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.collectionView];
    
    self.collectionView.frame = CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT);
    self.view.backgroundColor = [UIColor whiteColor];
    _dataArr = [NSMutableArray array];
    
    
    
}
-(void)setActivityId:(NSString *)activityId{
    _activityId = activityId;
    [self requestTimeBuyList:activityId];
}
-(void)requestTimeBuyList:(NSString*)ruleId{
    StairCategoryReq *req = [[StairCategoryReq alloc]init];
    req.appId = @"993335466657415169";
    req.timestamp = @"529675086";
    req.token = [UserCacheBean share].userInfo.token;
    req.version = @"";
    req.platform = @"ios";
    req.ruleActivityId = ruleId;
    req.erpStoreId = [UserCacheBean share].userInfo.erpStoreId;
    [[NextServiceApi share]timeBuyListWithParam:req response:^(id response) {
        if (response) {
            [self.dataArr removeAllObjects];
            [self.dataArr addObjectsFromArray:response];
            
        }
        [self.collectionView reloadData];
    }];
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArr.count;
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

//设置每个item的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    return CGSizeMake(SCREENWIDTH/2-45/2, SCREENWIDTH/2-45/2+90);
    
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NextCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([NextCollectionViewCell class]) forIndexPath:indexPath];
    TimeBuyModel *model = self.dataArr[indexPath.row];
    [cell setImageWidth:SCREENWIDTH/2-45/2];
    [cell setTimeModel:model];
    cell.addBtn.hidden = NO;
    return cell;
}



- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    detailGoodsViewController *vc = [[detailGoodsViewController alloc]init];
    
    TimeBuyModel *model = self.dataArr[indexPath.row];
    [vc setErpProductId:model.erpProductId];
    [vc setProductID:model.productId];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    
}
@end
