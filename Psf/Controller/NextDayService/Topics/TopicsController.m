//
//  TopicsController.m
//  Psf
//
//  Created by zhangshu on 2018/12/20.
//  Copyright © 2018 zhangshu. All rights reserved.
//

#import "TopicsController.h"
#import "NextServiceApi.h"
#import "NextCollectionViewCell.h"
#import "TopicTopCell.h"
#import "detailGoodsViewController.h"

@interface TopicsController ()<UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong)UICollectionView *collectionView;
@property (nonatomic, strong)TopicsListRes *result;
@end

@implementation TopicsController
-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        [self setTitle:@"专题"];
    }
    return self;
}
-(UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        layout.itemSize = CGSizeMake(165, 165);
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, [self navHeightWithHeight], SCREENWIDTH, SCREENHEIGHT*10) collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[NextCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([NextCollectionViewCell class])];
        [_collectionView registerClass:[TopicTopCell class] forCellWithReuseIdentifier:NSStringFromClass([TopicTopCell class])];
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"reusableView"];
    }
    return _collectionView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    if (@available(iOS 11.0, *)) {
        _collectionView.contentInsetAdjustmentBehavior = NO;
        self.collectionView.frame= CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT);
    } else {
        self.collectionView.frame = CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT);
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    [self.view addSubview:self.collectionView];
  
}
-(void)setSubjectId:(NSString*)subjectId{
    _subjectId = subjectId;
      [self requestBanner];
}
-(void)requestBanner{
    StairCategoryReq*req = [[StairCategoryReq alloc]init];
    req.appId = @"993335466657415169";
    req.timestamp = @"529675086";
    req.token = [UserCacheBean share].userInfo.token;
    req.version = @"";
    req.platform = @"ios";
    req.subjectId = self.subjectId;
    req.cityName = @"上海市";
    self.result = [[TopicsListRes alloc]init];
    __weak typeof(self)weakself = self;
    [[NextServiceApi share] getTopicListWithParam:req response:^(id response) {
        if (response) {
            weakself.result = response;
            [weakself.collectionView reloadData];
        }
    }];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return self.result.subjectCustomCategoryList.count+2;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section ==0) {
        return self.result.subjectTopProductList.count;
    }else if (section ==1){
        
    }else if (section>1){
        SubjectCategoryModel *model = self.result.subjectCustomCategoryList[section-2];
        return model.subjectCategoryProductList.count;
    }
    
    return 0;
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
    if (indexPath.section ==0) {
        return CGSizeMake(SCREENWIDTH, 145*SCREENWIDTH/345+95);
    }
    return CGSizeMake(165, 260);
    
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section ==0) {
        TopicTopCell*cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([TopicTopCell class]) forIndexPath:indexPath];
        StairCategoryListRes*model = self.result.subjectTopProductList[indexPath.row];
        [cell setModel:model];
        return cell;
    }
    NextCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([NextCollectionViewCell class]) forIndexPath:indexPath];
    if (indexPath.section ==1) {
        
    }else{
        SubjectCategoryModel *model = self.result.subjectCustomCategoryList[indexPath.section-2];
        StairCategoryListRes *res = model.subjectCategoryProductList[indexPath.row];
        [cell setModel:res];
    }
    
    [cell setAddBlock:^{
        
    }];
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if (section ==0) {
        return CGSizeMake(SCREENWIDTH, SCREENWIDTH);
    }else if (section ==1){
        
    }else if (section>1){
        return CGSizeMake(SCREENWIDTH, 100*SCREENWIDTH/375);
    }
    return CGSizeMake(SCREENWIDTH,0);
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    
    UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"reusableView" forIndexPath:indexPath];
    
    
    for (UIView *view in headerView.subviews) {
        if ([view isKindOfClass:[UIView class]]) {
            [view removeFromSuperview];
        }
    }
    if (indexPath.section ==0) {
        UIImageView*image = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENWIDTH)];
        NSString*url = [NSString stringWithFormat:@"%@%@",IMAGEHOST,self.result.subjectTopImagePath];
        [image sd_setImageWithURL:[NSURL URLWithString:url]];
        [headerView addSubview:image];
    }else if (indexPath.section ==1){
        
    }else if (indexPath.section>1){
        UIImageView*image = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 100*SCREENWIDTH/375)];
        SubjectCategoryModel *model = self.result.subjectCustomCategoryList[indexPath.section-2];
        NSString*url = [NSString stringWithFormat:@"%@%@",IMAGEHOST,model.subjectCategoryImagePath];
        [image sd_setImageWithURL:[NSURL URLWithString:url]];
        [headerView addSubview:image];
    }
    return headerView;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    detailGoodsViewController *vc = [[detailGoodsViewController alloc]init];
//    SubjectCategoryModel *model = self.dataArr[indexPath.section];
//    StairCategoryListRes *res = model.subjectCategoryProductList[indexPath.row];
//    [vc setProductID:res.productId];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    
}

@end
