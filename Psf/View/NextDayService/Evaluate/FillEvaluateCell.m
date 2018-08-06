//
//  FillEvaluateCell.m
//  Psf
//
//  Created by 燕来秋mac9 on 2018/8/6.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "FillEvaluateCell.h"

@implementation FillEvaluateCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = DSColorFromHex(0xF0F0F0);
        self.imageArr = [NSMutableArray array];
        self.imageurlArr= [NSMutableArray array];
        [self setContentLayout];
    }
    return self;
}

-(void)setContentLayout{
    
    [self addSubview:self.BGview];
    [self.BGview addSubview:self.headImage];
    [self.BGview addSubview:self.nameLabel];
    [self.BGview addSubview:self.countLabel];
    [self.BGview addSubview:self.weightLabel];
    [self.BGview addSubview:self.pingLabel];
    [self.BGview addSubview:self.ratingView];
    [self.BGview addSubview:self.gradeLabel];

    [self.BGview addSubview:self.contentTXT];
    [self.BGview addSubview:self.viewPhotoBgIDCard];
    self.BGview.frame = CGRectMake(0, 5, SCREENWIDTH, 344);
    [self.headImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(75);
        make.top.equalTo(self.BGview).offset(17);
        make.left.equalTo(self.BGview).offset(15);
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headImage.mas_top);
        make.left.equalTo(self.headImage.mas_right).offset(11);
        make.right.equalTo(self.BGview).offset(-15);
    }];
    [self.countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameLabel.mas_bottom).offset(10);
        make.left.equalTo(self.headImage.mas_right).offset(11);
    }];
    [self.weightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameLabel.mas_bottom).offset(10);
        make.left.equalTo(self.countLabel.mas_right).offset(5);
    }];
    [self.pingLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headImage.mas_bottom).offset(17);
        make.left.equalTo(self.BGview).offset(15);
    }];
    [self.ratingView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.pingLabel);
        make.left.equalTo(self.pingLabel.mas_right).offset(10);
        make.width.mas_equalTo(113);
        make.height.mas_equalTo(16);
    }];
    [self.gradeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headImage.mas_bottom).offset(17);
        make.left.equalTo(self.ratingView.mas_right).offset(10);
    }];
   
    [self.contentTXT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.pingLabel.mas_bottom).offset(20);
        make.width.mas_equalTo(SCREENWIDTH-30);
        make.height.mas_equalTo(92);
    }];
}
-(RatingView *)ratingView{
    if (!_ratingView) {
        _ratingView = [[RatingView alloc] init];
        self.ratingView.minRating = 0;
        self.ratingView.maxRating = 5;
        self.ratingView.emptySelectedImage = [UIImage imageNamed:@"evalustel_empty"];
        self.ratingView.fullSelectedImage = [UIImage imageNamed:@"evalustel_full"];
        self.ratingView.rating = 5; // 默认5星
        self.ratingView.editable = YES;
        self.ratingView.delegate = self;
    }
    return _ratingView;
}
-(UIImageView *)headImage{
    if (!_headImage) {
        _headImage = [[UIImageView alloc]init];
        _headImage.image = [UIImage imageNamed:@"niu"];
        [_headImage.layer setMasksToBounds:YES];
        [_headImage.layer setCornerRadius:4];
        _headImage.layer.borderWidth = 0.5;
        _headImage.layer.borderColor = [UIColor colorWithRed:127.5/255.0 green:127.5/255.0 blue:127.5/255.0 alpha:0.3].CGColor;
    }
    return _headImage;
}
-(UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]init];
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        _nameLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:15];
        _nameLabel.textColor = [UIColor colorWithRed:70/255.0 green:70/255.0 blue:70/255.0 alpha:1];
        _nameLabel.text = @"";
    }
    return _nameLabel;
}

-(UILabel *)weightLabel{
    if (!_weightLabel) {
        _weightLabel = [[UILabel alloc]init];
        _weightLabel.textAlignment = NSTextAlignmentLeft;
        _weightLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:12];
        _weightLabel.textColor = [UIColor colorWithRed:120/255.0 green:120/255.0 blue:120/255.0 alpha:1];
        _weightLabel.text = @"";
    }
    return _weightLabel;
}
-(UILabel *)countLabel{
    if (!_countLabel) {
        _countLabel = [[UILabel alloc]init];
        _countLabel.textAlignment = NSTextAlignmentLeft;
        _countLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:12];
        _countLabel.textColor = [UIColor colorWithRed:120/255.0 green:120/255.0 blue:120/255.0 alpha:1];
        _countLabel.text = @"";
    }
    return _countLabel;
}
-(UILabel *)pingLabel{
    if (!_pingLabel) {
        _pingLabel = [[UILabel alloc]init];
        _pingLabel.textAlignment = NSTextAlignmentLeft;
        _pingLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:15];
        _pingLabel.textColor = DSColorFromHex(0x474747);
        _pingLabel.text = @"评分";
    }
    return _pingLabel;
}
-(UILabel *)gradeLabel{
    if (!_gradeLabel) {
        _gradeLabel = [[UILabel alloc]init];
        _gradeLabel.textAlignment = NSTextAlignmentLeft;
        _gradeLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:15];
        _gradeLabel.textColor = DSColorFromHex(0x474747);
        _gradeLabel.text = @"非常满意";
    }
    return _gradeLabel;
}

-(UIView *)BGview{
    if (!_BGview) {
        _BGview = [[UIView alloc]init];
        _BGview.backgroundColor = [UIColor whiteColor];
    }
    return _BGview;
}
-(UIPlaceHolderTextView *)contentTXT{
    if (!_contentTXT) {
        _contentTXT = [[UIPlaceHolderTextView alloc]init];
        _contentTXT.placeholder = @"您对本商品还有什么建议，可以告诉我们哦";
        _contentTXT.placeHolderLabel.font = [UIFont systemFontOfSize:15];
        _contentTXT.placeholderColor = DSColorFromHex(0xDDDDDD);
        _contentTXT.font =  [UIFont systemFontOfSize:15];
    }
    return _contentTXT;
}

-(TYUploadImageView *)viewPhotoBgIDCard{
    if (!_viewPhotoBgIDCard) {
        _viewPhotoBgIDCard = [[TYUploadImageView alloc] initWithFrame:CGRectMake(0, 260, SCREENWIDTH, SCREENHEIGHT) withType:UPLOADIMAGETYPECONTRACT withMaxImagesCount:9];
//        _viewPhotoBgIDCard.superViewController = self;
        __weak typeof(self)weakself = self;
        [_viewPhotoBgIDCard returnimages:^(NSArray *images, NSArray *photoArr){
            
            [self.imageArr removeAllObjects];
            weakself.upCancel = YES;
            for (int index = 0; index < images.count; index ++) {
                TYImageAssetModel  * assetModel = [images objectAtIndex:index];
                AgentImageBaseModel * agentModel = [[AgentImageBaseModel alloc] init];
                if (assetModel.imageUrl) {
                    agentModel.url = assetModel.imageUrl;
                }else{
                    agentModel.asset =assetModel.asset;
                    UIImage *image = [self readImagewithPHAsset:assetModel.asset];
                    NSData *data = UIImageJPEGRepresentation(image, 1.0);
                    NSString *dataStr = [data base64EncodedStringWithOptions:0];
                    NSString * fileName = [NSString stringWithFormat:@"data:image/jpg;base64,%@",dataStr];
                    agentModel.base64String = fileName;
                }
                [weakself.imageArr addObject:agentModel];
            }
            [self reloadView];
            
            
        }];
    }
    return _viewPhotoBgIDCard;
}
-(void)reloadView{
    [self.viewPhotoBgIDCard configViewWithData:self.imageArr];
    self.BGview.frame = CGRectMake(0, 5, SCREENWIDTH, [self.viewPhotoBgIDCard configViewWithData:self.imageArr]+260);
    _model.cellH = [self.viewPhotoBgIDCard configViewWithData:self.imageArr]+265;
    self.photoBlock(_model);
    [self uploadImagewithImageArr:self.imageArr];

}
-(void)setModel:(CartProductModel *)model{
    _model = model;
    NSString *url = [NSString stringWithFormat:@"%@%@",IMAGEHOST,model.productImagePath];
    [self.headImage sd_setImageWithURL:[NSURL URLWithString:url]];
    self.nameLabel.text = model.productName;
    self.countLabel.text = model.productUnit;
    
}
-(UIImage *)readImagewithPHAsset:(PHAsset *)asset{
    dispatch_group_t group = dispatch_group_create();
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(1);
    __block UIImage * image = [[UIImage alloc] init];
    if (asset) {
        PHImageRequestOptions *option = [[PHImageRequestOptions alloc]init];
        option.synchronous = YES;
        option.networkAccessAllowed = NO;
        [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:CGSizeMake(600, 600)
                                                  contentMode:PHImageContentModeAspectFit options:option resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
                                                      image = [result resizedImageWithContentMode:UIViewContentModeScaleAspectFit bounds:CGSizeMake(600, 600) interpolationQuality:kCGInterpolationMedium];
                                                  }];
        dispatch_semaphore_signal(semaphore);
    }else{
        image = nil;
        dispatch_semaphore_signal(semaphore);
        
    }
    dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
    if (image) {
        return image;
    }else{
        return nil;
    }
}
-(void)uploadImagewithImageArr:(NSMutableArray <AgentImageBaseModel *>*) imageArr{
    if (imageArr.count <1) {
        return;
    }
    
    
    NSMutableArray * imageMutArr = [NSMutableArray array];
    for (AgentImageBaseModel *model in imageArr) {
        if (model.base64String) {
            [imageMutArr addObject:model.base64String];
        }
    }
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
    __weak typeof(self)weakself = self;
    [[UploadImageTool share]getQiniuUploadWithImages:imageMutArr Token:^(NSArray *imageArr) {
        [weakself.imageurlArr removeAllObjects];
        [weakself.imageurlArr addObjectsFromArray:imageArr];
        hud.hidden = YES;
    } failure:^{
        
    }];
}
-(void)floatRatingView:(RatingView *)ratingView continuousRating:(CGFloat)rating{
    NSLog(@"%f",rating);
    if (rating ==5) {
        _gradeLabel.text = @"非常满意";
    }else if (rating ==4){
        _gradeLabel.text = @"满意";
    }else if (rating ==3){
        _gradeLabel.text = @"一般";
    }else if (rating ==2){
        _gradeLabel.text = @"差";
    }else if (rating ==1){
        _gradeLabel.text = @"非常差";
    }
}
@end
