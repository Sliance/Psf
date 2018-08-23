//
//  GoodFootView.m
//  Psf
//
//  Created by 燕来秋mac9 on 2018/6/29.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "GoodFootView.h"
#import "GoodCollectionViewCell.h"
static NSString *cellId = @"GoodCollectionViewCell";
@implementation GoodFootView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setCornerLayout];
    }
    return self;
}
-(void)setCornerLayout{
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.lineLabel];
    [self addSubview:self.kanBtn];
    [self addSubview:self.kanLabel];
    [self addSubview:self.reBtn];
    [self addSubview:self.reLabel];
    [self addSubview:self.collectionView];
    self.lineLabel.frame = CGRectMake(0, 54, SCREENWIDTH, 1);
    self.kanBtn.frame = CGRectMake(0, 0, SCREENWIDTH/2, 54);
    self.reBtn.frame = CGRectMake(SCREENWIDTH/2, 0, SCREENWIDTH/2, 54);
    self.kanLabel.frame = CGRectMake(SCREENWIDTH/4-43, 52, 86, 2);
    self.reLabel.frame = CGRectMake(SCREENWIDTH*3/4-43, 52, 86, 2);
}
-(UILabel *)lineLabel{
    if (!_lineLabel) {
        _lineLabel = [[UILabel alloc]init];
        _lineLabel.backgroundColor = DSColorFromHex(0xDCDCDC);
    }
    return _lineLabel;
}
-(UIButton *)kanBtn{
    if (!_kanBtn) {
        _kanBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_kanBtn setTitle:@"大家都在看" forState:UIControlStateNormal];
        [_kanBtn setTitleColor:DSColorFromHex(0x474747) forState:UIControlStateNormal];
        _kanBtn.selected = YES;
        [_kanBtn setTitleColor:DSColorFromHex(0xFF4C4D) forState:UIControlStateSelected];
        [_kanBtn addTarget:self action:@selector(pressBtn:) forControlEvents:UIControlEventTouchUpInside];
        _kanBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    }
    return _kanBtn;
}
-(UIButton *)reBtn{
    if (!_reBtn) {
        _reBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_reBtn setTitle:@"24小时热销" forState:UIControlStateNormal];
        [_reBtn setTitleColor:DSColorFromHex(0x474747) forState:UIControlStateNormal];
        [_reBtn setTitleColor:DSColorFromHex(0xFF4C4D) forState:UIControlStateSelected];
        [_reBtn addTarget:self action:@selector(pressBtn:) forControlEvents:UIControlEventTouchUpInside];
        _reBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    }
    return _reBtn;
}
-(UILabel *)kanLabel{
    if (!_kanLabel) {
        _kanLabel = [[UILabel alloc]init];
        _kanLabel.backgroundColor = DSColorFromHex(0xFF4C4D);
    }
    return _kanLabel;
}
-(UILabel *)reLabel{
    if (!_reLabel) {
        _reLabel = [[UILabel alloc]init];
        _reLabel.backgroundColor = DSColorFromHex(0xFF4C4D);
        _reLabel.hidden = YES;
    }
    return _reLabel;
}
-(UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.minimumLineSpacing = 2;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0,55, SCREENWIDTH, 199) collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.scrollsToTop = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        [_collectionView registerClass:[GoodCollectionViewCell class] forCellWithReuseIdentifier:cellId];
       
        _collectionView.backgroundColor = [UIColor whiteColor];

    }
    return _collectionView;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArr.count;
}
//设置每个item的UIEdgeInsets
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 10, 0, 0);
    
}

//设置每个item水平间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    return CGSizeMake(134, 199);
    
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    GoodCollectionViewCell *collectcell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    GoodDetailRes *model = _dataArr[indexPath.row];
    [collectcell setModel:model];
    return collectcell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    GoodDetailRes *model = _dataArr[indexPath.row];
    self.selectedCollect(model.productId);
}
-(void)pressBtn:(UIButton*)sender{
    _kanBtn.selected = NO;
    if (_tmpBtn == nil){
        sender.selected = YES;
        _tmpBtn = sender;
    }else if (_tmpBtn !=nil && _tmpBtn == sender){
        sender.selected = YES;
        
    }else if (_tmpBtn!= sender && _tmpBtn!=nil){
        _tmpBtn.selected = NO;
        sender.selected = YES;
        _tmpBtn = sender;
    }
    if (_tmpBtn== _kanBtn) {
        _kanLabel.hidden = NO;
        _reLabel.hidden = YES;
        [self requestRecommend];
        
    }else if (_tmpBtn==_reBtn){
        _reLabel.hidden = NO;
        _kanLabel.hidden = YES;
        [self requestHot];
    }
}
-(void)setPruductId:(NSInteger)pruductId{
    _pruductId =pruductId;
    _dataArr = [NSMutableArray array];
    [self requestRecommend];
}
-(void)requestRecommend{
    
    StairCategoryReq *req = [[StairCategoryReq alloc]init];
    req.appId = @"993335466657415169";
    req.timestamp = @"529675086";
    req.token = [UserCacheBean share].userInfo.token;
    req.version = @"1.0.0";
    req.platform = @"ios";
    req.couponType = @"allProduct";
    req.saleOrderStatus = @"0";
    req.userLongitude = @"121.4737";
    req.userLatitude = @"31.23037";
    req.productId = _pruductId;
    req.pageIndex = 1;
    req.pageSize = @"10";
    req.productCategoryParentId = @"";
    req.saleOrderId = @"1013703405872041985";
    req.cityId = @"310100";
    req.cityName = @"上海市";
    __weak typeof(self)weakself = self;
    [[NextServiceApi share]requestRecommendListLoadWithParam:req response:^(id response) {
        if (response!= nil) {
            [weakself.dataArr removeAllObjects];
            [weakself.dataArr addObjectsFromArray:response];
            [weakself.collectionView reloadData];
        }
       
    }];
}
-(void)requestHot{
    StairCategoryReq *req = [[StairCategoryReq alloc]init];
    req.appId = @"993335466657415169";
    req.timestamp = @"529675086";
    req.token = [UserCacheBean share].userInfo.token;
    req.version = @"1.0.0";
    req.platform = @"ios";
    req.couponType = @"allProduct";
    req.saleOrderStatus = @"0";
    req.userLongitude = @"121.4737";
    req.userLatitude = @"31.23037";
    req.productId = _pruductId;
    req.pageIndex = 1;
    req.pageSize = @"10";
    req.productCategoryParentId = @"";
    req.saleOrderId = @"1013703405872041985";
    req.cityId = @"310100";
    req.cityName = @"上海市";
    __weak typeof(self)weakself = self;
    [[NextServiceApi share]requestHotListLoadWithParam:req response:^(id response) {
        if (response!= nil) {
            [weakself.dataArr removeAllObjects];
            [weakself.dataArr addObjectsFromArray:response];
            [weakself.collectionView reloadData];
        }
    }];
}
@end
