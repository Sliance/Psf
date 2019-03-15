//
//  HomeHeadView.m
//  Psf
//
//  Created by zhangshu on 2018/12/20.
//  Copyright © 2018 zhangshu. All rights reserved.
//

#import "HomeHeadView.h"
#import "NextCollectionViewCell.h"
#import "ShopServiceApi.h"

@implementation HomeHeadView

-(ZSCycleScrollView *)cycleScroll{
    if (!_cycleScroll) {
        _cycleScroll = [[ZSCycleScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH,200*SCREENWIDTH/375+130)];
        _cycleScroll.imageSize = CGSizeMake(SCREENWIDTH, 200*SCREENWIDTH/375);
        _cycleScroll.delegate =self;
        [_cycleScroll setIndex:0];
        
        _cycleScroll.autoScrollTimeInterval = 3.0;
        _cycleScroll.dotColor = [UIColor redColor];
    }
    return _cycleScroll;
}
-(UIImageView *)headimage{
    if (!_headimage) {
        _headimage = [[UIImageView alloc]init];
        [_headimage.layer setMasksToBounds:YES];
        [_headimage.layer setCornerRadius:6];
        
    }
    return _headimage;
}
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = [UIFont boldSystemFontOfSize:18];
        _titleLabel.textColor = DSColorFromHex(0x464646);
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}
-(UILabel *)dateLabel{
    if (!_dateLabel) {
        _dateLabel = [[UILabel alloc]init];
        _dateLabel.font = [UIFont boldSystemFontOfSize:16];
        _dateLabel.textColor = DSColorFromHex(0x464646);
        _dateLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _dateLabel;
}
-(UIButton *)moreBtn{
    if (!_moreBtn) {
        _moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_moreBtn setTitle:@"更多" forState:UIControlStateNormal];
        _moreBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [_moreBtn setTitleColor:DSColorFromHex(0x464646) forState:UIControlStateNormal];
    }
    return _moreBtn;
}
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.cycleScroll];
        [self addSubview:self.headimage];
        [self addSubview:self.titleLabel];
        [self addSubview:self.dateLabel];
        [self addSubview:self.moreBtn];
        [self addSubview:self.collectionView];
        
        __weak typeof(self)weakself = self;
        [self.cycleScroll setSelectedItemBlock:^(NSInteger index) {
            weakself.selected(index);
        }];
    }
    return self;
}
-(void)setModel:(SubjectCategoryModel *)model{
    _model = model;
    NSString*url = [NSString stringWithFormat:@"%@%@",IMAGEHOST,model.subjectCategoryImagePath];
    [self.headimage sd_setImageWithURL:[NSURL URLWithString:url]];
    self.titleLabel.text = model.subjectCategoryName;
}
-(void)setTimeModel:(TimeBuyModel *)timeModel{
    _timeModel = timeModel;
    NSString *endTime = [NSDate cStringFromTimestamp:timeModel.activityEndTime Formatter:@"YYYY-MM-dd HH:mm:ss"];
    endTime = [NSDate getCountDownStringWithEndTime:endTime];
    self.dateLabel.text = [NSString stringWithFormat:@"%@  %@",timeModel.activityName,endTime];
    NSTimer *timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
    
    [timer setFireDate:[NSDate distantPast]];
}
-(void)timerAction{
    NSString *endTime = [NSDate cStringFromTimestamp:_timeModel.activityEndTime Formatter:@"YYYY-MM-dd HH:mm:ss"];
    endTime = [NSDate getCountDownStringWithEndTime:endTime];
    self.dateLabel.text = [NSString stringWithFormat:@"%@  %@",_timeModel.activityName,endTime];
}
-(void)setTimeArr:(NSMutableArray *)timeArr{
    _timeArr = timeArr;
    if (timeArr.count>0) {
        [self.dateLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(20);
            make.top.equalTo(self).offset(200*SCREENWIDTH/375+120);
        }];
        [self.moreBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).offset(-20);
            make.centerY.equalTo(self.dateLabel);
        }];
        
        [self.headimage mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(20);
            make.right.equalTo(self).offset(-20);
            make.top.equalTo(self).offset(200*SCREENWIDTH/375+110+240);
            make.height.mas_equalTo(120*SCREENWIDTH/375);
        }];
        [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.top.equalTo(self.headimage.mas_bottom).offset(15);
        }];
        self.collectionView.frame =  CGRectMake(0,200*SCREENWIDTH/375+140, SCREENWIDTH, 210);
    }else{
        [self.headimage mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(20);
            make.right.equalTo(self).offset(-20);
            make.top.equalTo(self).offset(200*SCREENWIDTH/375+110);
            make.height.mas_equalTo(120*SCREENWIDTH/375);
        }];
        [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.top.equalTo(self.headimage.mas_bottom).offset(15);
        }];
        self.collectionView.frame =  CGRectMake(0,0, 0, 0);
    }
}

-(void)cycleScrollView:(ZSCycleScrollView *)cycleScrollView didSelectItemAtRow:(NSInteger)row{
    self.imageBlock(row);
}
-(UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.minimumLineSpacing = 2;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0,200*SCREENWIDTH/375+140, SCREENWIDTH, 200) collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.scrollsToTop = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        [_collectionView registerClass:[NextCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([NextCollectionViewCell class])];
        _collectionView.backgroundColor = [UIColor whiteColor];
        
    }
    return _collectionView;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.timeArr.count;
}
//设置每个item的UIEdgeInsets
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 15, 0, 0);
    
}

//设置每个item水平间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 15;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    return CGSizeMake(120, 210);
    
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NextCollectionViewCell *collectcell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([NextCollectionViewCell class]) forIndexPath:indexPath];
    TimeBuyModel *model = self.timeArr[indexPath.row];
    [collectcell setImageWidth:100];
    [collectcell setTimeModel:model];
    collectcell.addBtn.hidden = NO;
    [collectcell setAddBlock:^{
        [self addShopCountQuantity:@"1" productId:model.productId];
    }];
    return collectcell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    TimeBuyModel *model = self.timeArr[indexPath.row];
    self.collectBlock(model);
}
-(void)addShopCountQuantity:(NSString*)quantity productId:(NSInteger)productId{
    StairCategoryReq *req = [[StairCategoryReq alloc]init];
    req.appId = @"993335466657415169";
    req.timestamp = @"529675086";
    req.token = [UserCacheBean share].userInfo.token;
    req.version = @"1.0.0";
    req.platform = @"ios";
    req.couponType = @"allProduct";
    req.saleOrderStatus = @"0";
    req.userLongitude = [UserCacheBean share].userInfo.longitude;
    req.userLatitude = [UserCacheBean share].userInfo.latitude;
    req.productId =  productId ;
    req.pageIndex = 1;
    req.pageSize = @"10";
    req.productCategoryParentId = @"";
    req.saleOrderId = @"1013703405872041985";
    req.cityId = @"310100";
    req.cityName = @"上海市";
    req.productSkuId = @"";
    req.productQuantity = quantity;
    [[ShopServiceApi share]addShopCartCountWithParam:req response:^(id response) {
        
        if (response!= nil) {
            self.addBlock(response[@"message"]);
        }
        
    }];
}
@end
