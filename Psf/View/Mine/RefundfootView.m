//
//  RefundfootView.m
//  Psf
//
//  Created by 燕来秋mac9 on 2018/8/8.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "RefundfootView.h"

@implementation RefundfootView
-(instancetype)init{
    self = [super init];
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
    [self.BGview addSubview:self.titleLabel];
    [self.BGview addSubview:self.viewPhotoBgIDCard];
    [self reloadView ];
}
-(UIView *)BGview{
    if (!_BGview) {
        _BGview = [[UIView alloc]init];
        _BGview.backgroundColor = [UIColor whiteColor];
    }
    return _BGview;
}
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = [UIFont systemFontOfSize:15];
        _titleLabel.textColor = DSColorFromHex(0x464646);
        _titleLabel.text = @"上传凭证（最多6张）";
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.frame = CGRectMake(15, 0, SCREENWIDTH-30, 45);
    }
    return _titleLabel;
}
-(TYUploadImageView *)viewPhotoBgIDCard{
    if (!_viewPhotoBgIDCard) {
        _viewPhotoBgIDCard = [[TYUploadImageView alloc] initWithFrame:CGRectMake(0, 45, SCREENWIDTH, SCREENHEIGHT) withType:UPLOADIMAGETYPECONTRACT withMaxImagesCount:6];
        //        _viewPhotoBgIDCard.superViewController = self;
        __weak typeof(self)weakself = self;
        [_viewPhotoBgIDCard returnimages:^(NSArray *images, NSArray *photoArr){
            
            [self.imageArr removeAllObjects];
//            weakself.upCancel = YES;
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
    self.BGview.frame = CGRectMake(0, 5, SCREENWIDTH, [self.viewPhotoBgIDCard configViewWithData:self.imageArr]+45);
//    _model.cellH = [self.viewPhotoBgIDCard configViewWithData:self.imageArr]+45;
//    self.photoBlock(_model);
    [self uploadImagewithImageArr:self.imageArr];
    
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
    
    __weak typeof(self)weakself = self;
    [[UploadImageTool share]getQiniuUploadWithImages:imageMutArr Token:^(NSArray *imageArr) {
        [weakself.imageurlArr removeAllObjects];
        
        for (ImageModel *model in imageArr) {
            if (model.fileId) {
                ImageModel *imagemodel = [[ImageModel alloc]init];
                imagemodel.saleOrderProductCommentImageId = model.fileId;
                imagemodel.saleOrderProductCommentImagePath = model.fileOriginalPath;
                [weakself.imageurlArr addObject:imagemodel];
            }
        }

        weakself.photoBlock(weakself.imageurlArr);
        
    } failure:^{
        
    }];
}
@end
