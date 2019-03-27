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
        _dateLabel.text = @"";
    }
    return _dateLabel;
}
-(UILabel *)totalLabel{
    if (!_totalLabel) {
        _totalLabel = [[UILabel alloc]init];
        _totalLabel.font = [UIFont systemFontOfSize:15];
        _totalLabel.textColor = DSColorFromHex(0x464646);
        _totalLabel.textAlignment = NSTextAlignmentLeft;
        _totalLabel.text = @"";
    }
    return _totalLabel;
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
        _titleLabel.text = @"";
        _titleLabel.numberOfLines =0;
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

-(UIButton *)submitBtn{
    if (!_submitBtn) {
        _submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_submitBtn setTitle:@"结算" forState:UIControlStateNormal];
        [_submitBtn setTitleColor:DSColorFromHex(0xFF4C4D) forState:UIControlStateNormal];
        _submitBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_submitBtn.layer setBorderColor:DSColorFromHex(0xFF4C4D).CGColor];
        [_submitBtn.layer setBorderWidth:0.5];
        [_submitBtn.layer setCornerRadius:2];
        [_submitBtn addTarget:self action:@selector(pressSubmit) forControlEvents:UIControlEventTouchUpInside];
    }
    return _submitBtn;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.dateLabel];
        [self addSubview:self.totalLabel];
        [self addSubview:self.titleLabel];
       
        [self addSubview:self.headImage];
        [self addSubview:self.titleLabel];
        [self addSubview:self.weightLabel];
        [self addSubview:self.submitBtn];
        [self addSubview:self.collectionView];
         self.dateLabel.frame = CGRectMake(15, 15, SCREENWIDTH-30, 15);
        self.submitBtn.frame = CGRectMake(SCREENWIDTH-80, 29, 65, 24);
         self.totalLabel.frame = CGRectMake(15, 15+self.dateLabel.ctBottom,SCREENWIDTH-80, 15);
    }
    return self;
}

-(void)setLayout{
    
    self.collectionView.hidden = YES;
    self.headImage.hidden = NO;
    self.titleLabel.hidden = NO;
    self.weightLabel.hidden = NO;
   
    CartProductModel *model = [self.dataArr firstObject];
    NSString *url = [NSString stringWithFormat:@"%@%@",IMAGEHOST,model.productImagePath];
    [self.headImage sd_setImageWithURL:[NSURL URLWithString:url]];
    self.titleLabel.text = model.productName;
    self.weightLabel.text = model.productUnit;
    NSString *price ;
//    if (model.productStyle ==1) {
//        price= [NSString stringWithFormat:@"￥%.2f",[model.productStorePrice doubleValue]*[model.productQuantity doubleValue]*[[UserCacheBean share].userInfo.productDefaultWeight doubleValue]];
//    }else{
        price= [NSString stringWithFormat:@"￥%.2f",[model.productStorePrice doubleValue]*[model.productQuantity doubleValue]];
//    }
    
    NSString *string = [NSString stringWithFormat:@"共%@件，商品金额%@",model.productQuantity,price];
    NSRange rang = [string rangeOfString:price];
    NSMutableAttributedString *attributStr = [[NSMutableAttributedString alloc]initWithString:string];
    [attributStr addAttribute:NSForegroundColorAttributeName value:DSColorFromHex(0xFF4C4D) range:rang];
    self.totalLabel.attributedText = attributStr;
   
    self.headImage.frame = CGRectMake(15, self.totalLabel.ctBottom+15, 90, 90);
    self.titleLabel.frame = CGRectMake(self.headImage.ctRight+10, self.headImage.ctTop, SCREENWIDTH-130, 90);
//    self.weightLabel.frame = CGRectMake(self.headImage.ctRight+10, self.titleLabel.ctBottom+5, SCREENWIDTH-130, 15);
}

-(void)setMoreLayout{
    self.headImage.hidden = YES;
    self.titleLabel.hidden = YES;
    self.weightLabel.hidden = YES;
    self.collectionView.hidden = NO;
    CGFloat totalprice= 0.00;
    NSInteger count = 0;
    for (CartProductModel *model in _dataArr) {
        if (model.activityName.length>0&&model.productLimitedQuantity>0) {
            if ([model.productQuantity integerValue]< model.productLimitedQuantity+1) {
                totalprice = totalprice+[model.productActivityPrice doubleValue]*[model.productQuantity integerValue];
            }else{
                totalprice = totalprice+[model.productStorePrice doubleValue]*([model.productQuantity integerValue]- model.productLimitedQuantity)+[model.productActivityPrice doubleValue]*model.productLimitedQuantity;
            }
        }else{
//        if (model.productStyle ==1) {
//             totalprice = totalprice+[model.productStorePrice doubleValue]*[model.productQuantity doubleValue]*[[UserCacheBean share].userInfo.productDefaultWeight doubleValue];
//        }else{
            totalprice = totalprice+[model.productStorePrice doubleValue]*[model.productQuantity doubleValue];
//        }
    }
        count = count+[model.productQuantity doubleValue];
    }
    
    NSString *price = [NSString stringWithFormat:@"￥%.2f",totalprice];
    NSString *string = [NSString stringWithFormat:@"共%ld件，商品金额%@",(long)count,price];
    NSRange rang = [string rangeOfString:price];
    NSMutableAttributedString *attributStr = [[NSMutableAttributedString alloc]initWithString:string];
    [attributStr addAttribute:NSForegroundColorAttributeName value:DSColorFromHex(0xFF4C4D) range:rang];
    self.totalLabel.attributedText = attributStr;
    
}

-(void)setProductType:(NSInteger)productType{
    _productType = productType;
}
-(UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.minimumLineSpacing = 2;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0,60, SCREENWIDTH, 110) collectionViewLayout:layout];
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
    return UIEdgeInsetsMake(0, 0, 0, 0);
    
}

//设置每个item水平间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    return CGSizeMake(100, 100);
    
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    GoodCollectionViewCell *collectcell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    CartProductModel *model = _dataArr[indexPath.row];
    [collectcell setWidth:90];
    [collectcell setCarmodel:model];
    return collectcell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}

-(void)pressSubmit{
    self.sureBlock(_dataArr,_time);
}
-(void)setModel:(CartProductModel *)model{
    _model = model;
}
-(void)setTime:(NSString *)time{
    _time = time;
}
-(void)setDataArr:(NSArray *)dataArr{
    _dataArr = dataArr;
    for (id dic in dataArr) {
        if ([dic isKindOfClass:[NSDictionary class]]) {
             _dataArr = [CartProductModel mj_objectArrayWithKeyValuesArray:dataArr];
        }
       
    }
    if (_productType==0) {
        _dateLabel.text = @"普通商品";
    }else if (_productType==1){
        _dateLabel.text = [NSString stringWithFormat:@"预售商品 最快%@送达",_time];
    }else if (_productType==2){
        _dateLabel.text = @"次日达商品";
    }
    if (dataArr.count ==1) {
        [self setLayout];
    }else if (dataArr.count>1){
        [self setMoreLayout];
        [_collectionView reloadData];
    }
    
}
@end
