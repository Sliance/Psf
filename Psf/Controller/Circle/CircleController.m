//
//  CircleController.m
//  Ypc
//
//  Created by zhangshu on 2018/12/12.
//  Copyright © 2018 zhangshu. All rights reserved.
//

#import "CircleController.h"
#import "CircleNavView.h"
#import "CircleServiseApi.h"
#import "CircleListCell.h"
#import "LMHWaterFallLayout.h"



@interface CircleController ()<LMHWaterFallLayoutDeleaget,UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView * collectionView;
@property(nonatomic,strong)NSMutableArray *sortArr;
@property(nonatomic,strong)NSMutableArray *dataArr;
@property(nonatomic,strong)NSMutableArray *controllersArr;



@end

@implementation CircleController
-(UICollectionView *)collectionView{
    if (!_collectionView) {
        // 创建布局
        LMHWaterFallLayout * waterFallLayout = [[LMHWaterFallLayout alloc]init];
        waterFallLayout.delegate = self;
        
        // 创建collectionView
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, NavitionbarHeight, SCREENWIDTH, SCREENHEIGHT-NavitionbarHeight) collectionViewLayout:waterFallLayout];
        _collectionView.backgroundColor = DSColorFromHex(0xF0F0F0);
        
        _collectionView.dataSource = self;
        // 注册
        [_collectionView registerClass:[CircleListCell class] forCellWithReuseIdentifier:NSStringFromClass([CircleListCell class])];
    }
    return _collectionView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.collectionView];
}





-(void)requestData:(NSString*)categaryId{
    HomeReq *req = [[HomeReq alloc]init];
    req.token = [UserCacheBean share].userInfo.token;
    req.platform = @"ios";
    req.appId = @"111557561165794302";
    req.cityName = @"上海市";
    req.cityId = @"310100";
    req.timestamp = @"0";
//    req.storeId = [UserCacheBean share].userInfo.storeId;
    req.topicCategoryId = categaryId;
    req.pageIndex = 1;
    req.pageSize = @"8";
    WEAKSELF;
    [[CircleServiseApi share]getCircleListWithParam:req response:^(id response) {
        if (response) {
            
            [weakSelf.dataArr removeAllObjects];
            [weakSelf.dataArr addObjectsFromArray:response];
           
            
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
#pragma mark  - <LMHWaterFallLayoutDeleaget>
- (CGFloat)waterFallLayout:(LMHWaterFallLayout *)waterFallLayout heightForItemAtIndexPath:(NSUInteger)indexPath itemWidth:(CGFloat)itemWidth{
    
    CircleListRes * model = self.dataArr[indexPath];
    
    return model.height;
}

- (CGFloat)rowMarginInWaterFallLayout:(LMHWaterFallLayout *)waterFallLayout{
    
    return 10;
    
}

- (NSUInteger)columnCountInWaterFallLayout:(LMHWaterFallLayout *)waterFallLayout{
    
    return 2;
    
}


@end
