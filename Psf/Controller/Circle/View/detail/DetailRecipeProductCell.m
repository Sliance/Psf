//
//  DetailRecipeProductCell.m
//  Psf
//
//  Created by zhangshu on 2019/1/15.
//  Copyright © 2019 zhangshu. All rights reserved.
//

#import "DetailRecipeProductCell.h"
#import "ZSConfig.h"
#import "ShopServiceApi.h"

@implementation DetailRecipeProductCell

-(UIImageView *)headImage{
    if (!_headImage) {
        _headImage = [[UIImageView alloc]init];
    }
    return _headImage;
}
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textColor = DSColorFromHex(0x464646);
        _titleLabel.font = [UIFont systemFontOfSize:16];
    }
    return _titleLabel;
}
-(UILabel *)priceLabel{
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc]init];
        _priceLabel.textColor = DSColorFromHex(0xFF4C4D);
        _priceLabel.font = [UIFont systemFontOfSize:16];
    }
    return _priceLabel;
}
-(UIView *)bgView{
    if (!_bgView) {
        _bgView = [[UIView alloc]init];
        _bgView.backgroundColor = [UIColor whiteColor];
        [_bgView.layer setCornerRadius:6];
        [_bgView.layer setMasksToBounds:YES];
        [_bgView.layer setBorderColor:DSColorFromHex(0xDCDCDC).CGColor];
        [_bgView.layer setBorderWidth:0.5];
    }
    return _bgView;
}
-(UIButton *)addBtn{
    if (!_addBtn) {
        _addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_addBtn setImage:[UIImage imageNamed:@"add_sort"] forState:UIControlStateNormal];
        [_addBtn setImage:[UIImage imageNamed:@"add_sort"] forState:UIControlStateSelected];
        [_addBtn addTarget:self action:@selector(pressAdd) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addBtn;
}
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.bgView];
        [self.bgView addSubview:self.titleLabel];
        [self.bgView addSubview:self.headImage];
        [self.bgView addSubview:self.priceLabel];
        [self.bgView addSubview:self.addBtn];
        [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self);
            make.top.equalTo(self);
            make.width.mas_equalTo(290);
            make.height.mas_equalTo(80);
        }];
        [self.headImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.bgView);
            make.top.equalTo(self.bgView);
            make.width.mas_equalTo(80);
            make.height.mas_equalTo(80);
        }];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.headImage.mas_right).offset(10);
            make.top.equalTo(self.bgView).offset(15);
            
        }];
        [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.headImage.mas_right).offset(10);
            make.bottom.equalTo(self.bgView).offset(-15);
        }];
        [self.addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.bgView).offset(-15);
            make.bottom.equalTo(self.bgView).offset(-15);
        }];
    }
    return self;
}
-(void)setModel:(CartProductModel *)model{
    _model = model;
    NSString *url = [NSString stringWithFormat:@"%@%@",IMAGEHOST,model.productImagePath];
    [self.headImage sd_setImageWithURL:[NSURL URLWithString:url]];
    self.titleLabel.text = model.productName;
    self.priceLabel.text = [NSString stringWithFormat:@"￥%@",model.productStorePrice];
}
-(void)pressAdd{
    [self addShopCountQuantity:@"1" productId:self.model.productId];
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
    __weak typeof(self)weakself = self;
    [[ShopServiceApi share]addShopCartCountWithParam:req response:^(id response) {
        
        if (response!= nil) {
            UIWindow * window = [[UIApplication sharedApplication] keyWindow];
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:window animated:YES];
            hud.mode = MBProgressHUDModeText;
            hud.userInteractionEnabled = NO;
            hud.label.text = response[@"message"];
            hud.yOffset = -85;
            [hud hide:YES afterDelay:3];
        }
        
    }];
}
@end
