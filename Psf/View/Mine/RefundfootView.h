//
//  RefundfootView.h
//  Psf
//
//  Created by 燕来秋mac9 on 2018/8/8.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "BaseView.h"
#import "TYUploadImageView.h"
#import "AgentImageBaseModel.h"
#import "TYImageAssetModel.h"
#import "UIImage+Resize.h"
#import "UIImageView+WebCache.h"
#import "TZImageManager.h"
#import "UploadImageTool.h"
#import "CartProductModel.h"
@interface RefundfootView : BaseView<UIActionSheetDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (nonatomic, strong) TYUploadImageView * viewPhotoBgIDCard;
@property(nonatomic,strong)NSMutableArray <AgentImageBaseModel*>*imageArr;
@property(nonatomic,strong)NSMutableArray *imageurlArr;
@property(nonatomic,strong)UIView *BGview;
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,copy)void (^photoBlock)(NSMutableArray*);

@end
