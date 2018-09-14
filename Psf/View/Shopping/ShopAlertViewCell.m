//
//  ShopAlertViewCell.m
//  Psf
//
//  Created by 燕来秋mac9 on 2018/9/14.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "ShopAlertViewCell.h"
#import "GoodCollectionViewCell.h"

@implementation ShopAlertViewCell
static NSString *cellId = @"GoodCollectionViewCell";
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (UILabel *)dateLabel{
    if (!_dateLabel) {
        _dateLabel = [[UILabel alloc]init];
        _dateLabel.font = [UIFont systemFontOfSize:15];
        _dateLabel.textColor = DSColorFromHex(0x464646);
        _dateLabel.textAlignment = NSTextAlignmentLeft;
        _dateLabel.text = @"预售商品 最快明天送达";
    }
    return _dateLabel;
}
-(UILabel *)totalLabel{
    if (!_totalLabel) {
        _totalLabel = [[UILabel alloc]init];
        _totalLabel.font = [UIFont systemFontOfSize:15];
        _totalLabel.textColor = DSColorFromHex(0x464646);
        _totalLabel.textAlignment = NSTextAlignmentLeft;
        _totalLabel.text = @"共1件，商品金额";
    }
    return _totalLabel;
}
-(UILabel *)priceLabel{
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc]init];
        _priceLabel.font = [UIFont systemFontOfSize:15];
        _priceLabel.textColor = DSColorFromHex(0x464646);
        _priceLabel.textAlignment = NSTextAlignmentLeft;
        _priceLabel.text = @"￥65";
    }
    return _priceLabel;
}
-(UIImageView *)headImage{
    if (!_headImage) {
        _headImage = [[UIImageView alloc]init];
        [_headImage.layer setContentsScale:4];
        [_headImage.layer setMasksToBounds:YES];
        [_headImage.layer setBorderWidth:0.5];
        [_headImage.layer setBorderColor:DSColorFromHex(0xF0F0F0).CGColor];
    }
    return _headImage;
}
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = [UIFont systemFontOfSize:15];
        _titleLabel.textColor = DSColorFromHex(0x474747);
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.text = @"个头饱满 淡淡桂花香广东桂味荔枝";
    }
    return _titleLabel;
}
-(UILabel *)weightLabel{
    if (!_weightLabel) {
        _weightLabel = [[UILabel alloc]init];
        _weightLabel.font = [UIFont systemFontOfSize:15];
        _weightLabel.textColor = DSColorFromHex(0x474747);
        _weightLabel.textAlignment = NSTextAlignmentLeft;
        _weightLabel.text = @"2.5kg";
    }
    return _weightLabel;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.dateLabel];
        [self addSubview:self.totalLabel];
        [self addSubview:self.titleLabel];
        [self addSubview:self.priceLabel];
        [self addSubview:self.headImage];
        [self addSubview:self.titleLabel];
        [self addSubview:self.weightLabel];
        [self addSubview:self.collectionView];
    }
    return self;
}

-(void)setLayout{
    
    self.dateLabel.frame = CGRectMake(15, 15, SCREENWIDTH-30, 15);
    CGRect rect = [@"共1件，商品金额" boundingRectWithSize:CGSizeMake(MAXFLOAT, 15) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil];
   
    self.totalLabel.frame = CGRectMake(15, 15+self.dateLabel.ctBottom,rect.size.width, 15);
    self.headImage.frame = CGRectMake(15, self.totalLabel.ctBottom+15, 90, 90);
    self.titleLabel.frame = CGRectMake(self.headImage.ctRight+10, self.headImage.ctTop+20, SCREENWIDTH-130, 15);
    self.weightLabel.frame = CGRectMake(self.headImage.ctRight+10, self.titleLabel.ctBottom+10, SCREENWIDTH-130, 15);
}

-(void)setMoreLayout{
    
    self.dateLabel.frame = CGRectMake(15, 15, SCREENWIDTH-30, 15);
    self.totalLabel.frame = CGRectMake(15, 15+self.dateLabel.ctBottom, 100, 15);
    
}

-(void)setProductType:(NSInteger)productType{
    _productType = productType;
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
    
    return CGSizeMake(134, 90);
    
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    GoodCollectionViewCell *collectcell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
//    GoodDetailRes *model = _dataArr[indexPath.row];
//    [collectcell setModel:model];
    return collectcell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}


-(void)setModel:(CartProductModel *)model{
    _model = model;
}
-(void)setDataArr:(NSArray *)dataArr{
    _dataArr = dataArr;
    if (dataArr.count ==1) {
        [self setLayout];
    }else if (dataArr.count>1){
        [self setMoreLayout];
    }
    
}
@end
