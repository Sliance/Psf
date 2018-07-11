//
//  BaseDetailSortController.m
//  Psf
//
//  Created by 燕来秋mac9 on 2018/6/28.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "BaseDetailSortController.h"
#import "detailGoodsViewController.h"
#import "NextCollectionViewCell.h"
#import "NextServiceApi.h"

@interface BaseDetailSortController ()<UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong)UICollectionView *collectionView;
@property(nonatomic,strong)NSMutableArray *dateArr;
@end
static NSString *cellId = @"cellId";
@implementation BaseDetailSortController
-(UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        layout.itemSize = CGSizeMake(165, 165);
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 5, SCREENWIDTH, SCREENHEIGHT-100) collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
//        _collectionView.scrollEnabled = YES;
        [_collectionView registerClass:[NextCollectionViewCell class] forCellWithReuseIdentifier:cellId];
        _collectionView.backgroundColor = [UIColor whiteColor];
    }
    return _collectionView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.collectionView];
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"reusableView"];
    
}

-(void)requestData{
     StairCategoryReq *req = [[StairCategoryReq alloc]init];
    req.appId = @"993335466657415169";
    req.timestamp = @"529675086";
    
    req.token = @"eyJleHBpcmVUaW1lIjoxNTYxNjI1OTU3ODc0LCJ1c2VySWQiOiIxMDEwNDEyNTM0NzkxNTUzMDI2Iiwib2JqZWN0SWQiOiIxMDEwNDEyNTM0NzkxNTUzMDI1In0=";
    req.userId = @"1009660103519952898";
    req.version = @"1.0.0";
    req.platform = @"ios";
    //    req.couponType = @"allProduct";
    //    req.saleOrderStatus = @"0";
    req.userLongitude = @"121.4737";
    req.userLatitude = @"31.23037";
    req.productId = [NSString stringWithFormat:@"%ld",self.model.productCategoryId];
    //    req.pageIndex = @"1";
    //    req.pageSize = @"10";
    req.productCategoryParentId = self.model.productCategoryParentId;
    //    req.saleOrderId = @"1013703405872041985";
    req.cityId = @"310100";
    req.cityName = @"上海市";
    self.dateArr = [[NSMutableArray alloc]init];
    __weak typeof(self) weakSelf = self;
    [[NextServiceApi share]requestSortListLoadWithParam:req response:^(id response) {
        if(response!=nil){
            StairCategoryRes *model = [response firstObject];
            [weakSelf.dateArr removeAllObjects];
            [weakSelf.dateArr addObjectsFromArray:model.productList];
            [weakSelf.collectionView reloadData];
        }
    }];
}
-(void)setModel:(StairCategoryRes *)model{
    _model = model;
    [self requestData];
   
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _dateArr.count;
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
    return CGSizeMake(165, 288);
    
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
    return CGSizeMake(SCREENWIDTH, 50);
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"reusableView" forIndexPath:indexPath];
    
    
    for (UIView *view in headerView.subviews) {
        if ([view isKindOfClass:[UIView class]]) {
            [view removeFromSuperview];
        }
    }
    
    
        UILabel* titleView = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 50)];
        titleView.text = @"冷链配送，新鲜直达";
        titleView.font = [UIFont systemFontOfSize:15];
        titleView.textColor = DSColorFromHex(0x464646);
        titleView.textAlignment = NSTextAlignmentCenter;
        [headerView addSubview:titleView];
    return headerView;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NextCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    StairCategoryListRes *model = _dateArr[indexPath.row];
    [cell setModel:model];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    detailGoodsViewController *vc = [[detailGoodsViewController alloc]init];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vc];
   StairCategoryListRes *model = _dateArr[indexPath.row];
    [vc setProductID:model.productId];
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
