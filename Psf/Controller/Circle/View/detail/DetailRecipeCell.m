//
//  DetailRecipeCell.m
//  Psf
//
//  Created by zhangshu on 2019/1/15.
//  Copyright © 2019 zhangshu. All rights reserved.
//

#import "DetailRecipeCell.h"
#import "DetailRecipeProductCell.h"
static NSString *cellId = @"DetailRecipeProductCell";
@implementation DetailRecipeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 0,SCREENWIDTH-30, 40)];
        _titleLabel.textColor = DSColorFromHex(0x464646);
        _titleLabel.font = [UIFont systemFontOfSize:16];
        
    }
    return _titleLabel;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.titleLabel];
        [self addSubview:self.collectionView];
    }
    return self;
}
-(UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.minimumLineSpacing = 2;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0,40, SCREENWIDTH, 80) collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.scrollsToTop = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        [_collectionView registerClass:[DetailRecipeProductCell class] forCellWithReuseIdentifier:cellId];
        
        _collectionView.backgroundColor = [UIColor whiteColor];
        
    }
    return _collectionView;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.model.epicureMobileV1ProductWrapper.count;
}
//设置每个item的UIEdgeInsets
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 15, 0, 10);
    
}

//设置每个item水平间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 20;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    return CGSizeMake(300, 80);
    
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DetailRecipeProductCell *collectcell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    CartProductModel *model = self.model.epicureMobileV1ProductWrapper[indexPath.row];
    [collectcell setModel:model];
    return collectcell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    CartProductModel *model = self.model.epicureMobileV1ProductWrapper[indexPath.row];
    if (model.productIsOnSale ==YES) {
         self.selectedCollect(model);
    }
}
-(void)setDataArr:(NSMutableArray *)dataArr{
    _dataArr = dataArr;
    
}
-(void)setModel:(EpicureProductModel *)model{
    _model = model;
    self.titleLabel.text = [NSString stringWithFormat:@"- %@",model.ingredientsCategoryName];
    for (CartProductModel *models in model.epicureMobileV1ProductWrapper) {
        if (models.productIsOnSale ==NO) {
            [model.epicureMobileV1ProductWrapper removeObject:models];
        }
    }
    [self.collectionView reloadData];
}

@end
