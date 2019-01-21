//
//  MineCollectController.m
//  Psf
//
//  Created by zhangshu on 2019/1/21.
//  Copyright © 2019 zhangshu. All rights reserved.
//

#import "MineCollectController.h"
#import "NextServiceApi.h"
#import "CircleListCell.h"
#import "DetailRecipeController.h"

@interface MineCollectController ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic, strong) UICollectionView * collectionView;
@property(nonatomic,strong)NSMutableArray *sortArr;
@property(nonatomic,strong)NSMutableArray *dataArr;
@property(nonatomic,strong)NSMutableArray *controllersArr;
@property(nonatomic,assign)NSInteger pageIndex;

@end

@implementation MineCollectController
-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self setTitle:@"我的收藏"];
       
    }
    return self;
}
-(UICollectionView *)collectionView{
    if (!_collectionView) {
        // 创建布局
        UICollectionViewFlowLayout * waterFallLayout = [[UICollectionViewFlowLayout alloc]init];
        
        // 创建collectionView
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, NavitionbarHeight, SCREENWIDTH, SCREENHEIGHT-NavitionbarHeight) collectionViewLayout:waterFallLayout];
        _collectionView.backgroundColor = DSColorFromHex(0xF0F0F0);
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        // 注册
        [_collectionView registerClass:[CircleListCell class] forCellWithReuseIdentifier:NSStringFromClass([CircleListCell class])];
    }
    return _collectionView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.collectionView];
    self.dataArr = [[NSMutableArray alloc]init];
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

   
        self.pageIndex = 1;
        [self requestData];
    
}

/**
 *  上拉刷新
 */
-(void)footerRefreshing
{
    
    self.pageIndex++;
    [self requestData];
}
-(void)requestData{
    StairCategoryReq *req = [[StairCategoryReq alloc]init];
    req.token = [UserCacheBean share].userInfo.token;
    req.platform = @"ios";
    req.appId = @"993335466657415169";
    req.cityName = @"上海市";
    req.cityId = @"310100";
    req.timestamp = @"0";
    req.erpStoreId = [UserCacheBean share].userInfo.erpStoreId;
    req.pageIndex = self.pageIndex;
    req.pageSize = @"10";
    req.memberCollectionType = @"EPICURE";
    WEAKSELF;
    [[NextServiceApi share]mineCollectListWithParam:req response:^(id response) {
        if (response) {
            
            if (self.pageIndex ==1) {
                [weakSelf.dataArr removeAllObjects];
                [weakSelf.dataArr addObjectsFromArray:response];
                
            }else{
                [weakSelf.dataArr addObjectsFromArray:response];
                [weakSelf.collectionView.mj_header endRefreshing];
                [weakSelf.collectionView.mj_footer endRefreshing];
            }
            
            
            if ([response count] < 10) {
                [weakSelf.collectionView.mj_footer removeFromSuperview];
                
            }
            else{
                weakSelf.collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:weakSelf refreshingAction:@selector(footerRefreshing)];
            }
            [weakSelf.collectionView reloadData];
            
        }
    }];
}

#pragma mark UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArr.count;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(SCREENWIDTH/2-30/2, 120*(SCREENWIDTH/2-15)/172.5+55);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 10, 10, 10);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 5;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CircleListCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([CircleListCell class]) forIndexPath:indexPath];
    if ([self.collectionView numberOfItemsInSection:0] ==self.dataArr.count) {
        CircleListRes *model =self.dataArr[indexPath.item];
        [cell setModel:model];
        WEAKSELF;
        
        [cell setHeightBlock:^(CGFloat height) {
            model.height = height;
            [UIView performWithoutAnimation:^{
                if (indexPath.row < weakSelf.dataArr.count) {
                    [weakSelf.collectionView reloadItemsAtIndexPaths:@[indexPath]];
                }
            }];
            
            
        }];
    }
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    DetailRecipeController *detailVC = [[DetailRecipeController alloc]init];
    CircleListRes *model =self.dataArr[indexPath.item];
    detailVC.hidesBottomBarWhenPushed = YES;
    [detailVC setEpicureId:model.articleId];
    [self.navigationController pushViewController:detailVC animated:YES];
}
@end
