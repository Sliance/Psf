//
//  FillEvaluateCell.h
//  Psf
//
//  Created by 燕来秋mac9 on 2018/8/6.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RatingView.h"
#import "UIPlaceHolderTextView.h"
#import "ZSConfig.h"
#import "TYUploadImageView.h"
#import "AgentImageBaseModel.h"
#import "TYImageAssetModel.h"
#import "UIImage+Resize.h"
#import "UIImageView+WebCache.h"
#import "TZImageManager.h"
#import "UploadImageTool.h"
#import "CartProductModel.h"

@interface FillEvaluateCell : UITableViewCell<FloatRatingViewDelegate,UIScrollViewDelegate,UIActionSheetDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property(nonatomic,strong)UIView *BGview;
@property(nonatomic,strong)UIImageView *headImage;
@property(nonatomic,strong)UILabel *nameLabel;
@property(nonatomic,strong)UILabel *countLabel;
@property(nonatomic,strong)UILabel *weightLabel;

@property(nonatomic,strong)UILabel *pingLabel;
@property(nonatomic,strong)UILabel *gradeLabel;
@property(nonatomic,strong)RatingView *ratingView;
@property(nonatomic,strong)UILabel *lineLabel;
@property(nonatomic,strong)UIPlaceHolderTextView *contentTXT;
@property (nonatomic, strong) TYUploadImageView * viewPhotoBgIDCard;
@property(nonatomic,strong)NSMutableArray <AgentImageBaseModel*>*imageArr;
@property(nonatomic,strong)NSMutableArray *imageurlArr;
@property (nonatomic, assign) BOOL upCancel;
@property(nonatomic,copy)void(^photoBlock)(CartProductModel*);
@property(nonatomic,strong)CartProductModel *model;


@end
