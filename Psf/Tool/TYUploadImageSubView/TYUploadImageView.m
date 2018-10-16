//
//  TYUploadImageView.m
//  TZImagePickerController
//
//  Created by 安天洋 on 2017/4/21.
//  Copyright © 2017年 谭真. All rights reserved.
//

#import "TYUploadImageView.h"
#import "TZImagePickerController.h"
#import "UIView+Layout.h"
#import "TZTestCell.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <Photos/Photos.h>
#import "TZImageManager.h"
#import "TYimageModel.h"
#import "TYImageAssetModel.h"
#import "AgentImageBaseModel.h"
#import "ZSConfig.h"
#import "UIImage+Resize.h"

#define  ColumnsNumbers      4
//#define  SumImageNumbers      20
#define SCREENWIDTH [[UIScreen mainScreen] bounds].size.width
#define SCREENHEIGHT [[UIScreen mainScreen] bounds].size.height

@interface TYUploadImageView () <TZImagePickerControllerDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UIAlertViewDelegate,UINavigationControllerDelegate>
{
    BOOL _isSelectOriginalPhoto;
    CGFloat _itemWH;
    CGFloat _margin;
    NSString * placeholder_Image_Name;
}

@property (nonatomic, strong) NSMutableArray<TYimageModel *> *selectedPhotos;
@property (nonatomic, strong) NSMutableArray<TYImageAssetModel *> *selectedAssets;
@property (nonatomic, strong) UIImagePickerController *imagePickerVc;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, assign) BOOL allowTakePicture;
@end

@implementation TYUploadImageView

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
- (UIImagePickerController *)imagePickerVc {
    if (_imagePickerVc == nil) {
        _imagePickerVc = [[UIImagePickerController alloc] init];
        _imagePickerVc.delegate = self;
        // set appearance / 改变相册选择页的导航栏外观
        _imagePickerVc.navigationBar.barTintColor = self.superViewController.navigationController.navigationBar.barTintColor;
        _imagePickerVc.navigationBar.tintColor = self.superViewController.navigationController.navigationBar.tintColor;;
        UIBarButtonItem *tzBarItem, *BarItem;
        if (iOS9Later) {
            tzBarItem = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[TZImagePickerController class]]];
            BarItem = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[UIImagePickerController class]]];
        } else {
            tzBarItem = [UIBarButtonItem appearanceWhenContainedIn:[TZImagePickerController class], nil];
            BarItem = [UIBarButtonItem appearanceWhenContainedIn:[UIImagePickerController class], nil];
        }
        NSDictionary *titleTextAttributes = [tzBarItem titleTextAttributesForState:UIControlStateNormal];
        [BarItem setTitleTextAttributes:titleTextAttributes forState:UIControlStateNormal];
    }
    return _imagePickerVc;
}
//多张图片选择器的实例化
- (id)initWithFrame:(CGRect)frame withType:(UPLOADIMAGETYPE)type withMaxImagesCount:(NSInteger)maxCount{
    if (self = [super initWithFrame:frame]) {
        self.uploadImageType = type;
        self.maxImagesCount = maxCount;
        self.allowTakePicture = NO;
        [self initData];
        self.clipsToBounds = YES;
    }
    return self;
}
//单张图片选择器的实例化
- (id)initWithFrame:(CGRect)frame withPlaceholderName:(NSString *)placeholderStr{
    if (self = [super initWithFrame:frame]) {
        self.maxImagesCount = 1;
        self.allowTakePicture = NO;
        [self initData];
        placeholder_Image_Name = placeholderStr;
        self.clipsToBounds = YES;
    }
    return self;
}

-(void) initData{
    _selectedPhotos = [NSMutableArray array];
    _selectedAssets = [NSMutableArray array];
    [self configCollectionView];
    switch (self.uploadImageType) {
        case UPLOADIMAGETYPECONTRACT: // 合同及其他资料
             placeholder_Image_Name = @"upload_image";
            break;
        case 1://动检证照片
             placeholder_Image_Name = @"upload_image";
            break;
        case 2://发票照片
             placeholder_Image_Name = @"upload_image";
            break;
        default:
            break;
    }
}
- (BOOL)prefersStatusBarHidden {
    return NO;
}
- (void)configCollectionView {
    // 如不需要长按排序效果，将LxGridViewFlowLayout类改成UICollectionViewFlowLayout即可
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    _margin = 4;
    float Spacing = 0.0f;
    float liftSpacing = 0.0f;
    float width = 0.0f;
    UIColor * borderColor = [UIColor clearColor];
    _itemWH = (self.tz_width - _margin * 5) / 4 - 15;
    if (self.maxImagesCount == 1) {
       layout.itemSize = CGSizeMake(self.frame.size.width, self.frame.size.height);
        Spacing = 0.0f;
        liftSpacing = 0.0f;
        width = self.frame.size.width;
        borderColor = [UIColor whiteColor];
    }else{
        layout.itemSize = CGSizeMake(_itemWH, _itemWH);
        layout.minimumInteritemSpacing = 10;
        layout.minimumLineSpacing = 10;
        Spacing = 2.0f;
        liftSpacing = 10.0f;
        width = SCREENWIDTH - 20;
        borderColor = [UIColor clearColor];
    }
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(liftSpacing, 0, width, self.frame.size.height) collectionViewLayout:layout];
    _collectionView.alwaysBounceVertical = YES;
    _collectionView.backgroundColor = [UIColor clearColor];
    _collectionView.contentInset = UIEdgeInsetsMake(Spacing, Spacing, Spacing, Spacing);
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.scrollEnabled = NO;
    _collectionView.layer.masksToBounds=YES;
    _collectionView.layer.cornerRadius=0.0;
    _collectionView.layer.borderWidth=0.5;
    _collectionView.layer.borderColor=[borderColor CGColor];
    _collectionView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    [self addSubview:_collectionView];
    [_collectionView registerClass:[TZTestCell class] forCellWithReuseIdentifier:@"TZTestCell"];
}

#pragma mark UICollectionView
// 如果选择的照片数量和最大可选择数量一致时就不显示添加图片的按钮
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSInteger rowsNumber;
    if (_selectedPhotos.count < _maxImagesCount) {
        rowsNumber = _selectedPhotos.count + 1;
    }else{
        rowsNumber = _selectedPhotos.count;
    }
    return   rowsNumber;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TZTestCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TZTestCell" forIndexPath:indexPath];
    cell.videoImageView.hidden = YES;
    if (indexPath.row == _selectedPhotos.count) {
        cell.imageView.image = [UIImage imageNamed:placeholder_Image_Name];
        cell.imageView.contentMode = UIViewContentModeCenter;
        cell.gifLable.hidden = YES;
    } else {
        [cell setImageWithImageModel:_selectedPhotos[indexPath.row]];
        cell.imageView.contentMode = UIViewContentModeScaleToFill;
        cell.asset = _selectedAssets[indexPath.row].asset;
    }
    cell.gifLable.hidden = YES;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == _selectedPhotos.count) {
        UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"去相册选择", nil];
        [sheet showInView:self.superViewController.view];
    } else { // preview photos or video / 预览照片或者视频
        // preview photos / 预览照片
        TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithSelectedAssets:_selectedAssets selectedPhotos:_selectedPhotos index:indexPath.row];
        imagePickerVc.maxImagesCount = _maxImagesCount;
        imagePickerVc.allowPickingOriginalPhoto = YES; // 是否允许选择原片
        imagePickerVc.isSelectOriginalPhoto = _isSelectOriginalPhoto;
        [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<TYimageModel *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
            
            _selectedPhotos = [NSMutableArray arrayWithArray:photos];
            _selectedAssets = [NSMutableArray arrayWithArray:assets];
            _isSelectOriginalPhoto = isSelectOriginalPhoto;
            [self TYUpLoadImageViewReloadWithSeleterAssetsArray:_selectedAssets andSelterPhotoArr:_selectedPhotos];
            _collectionView.contentSize = CGSizeMake(0, ((_selectedPhotos.count + 2) / 4 ) * (_margin + _itemWH));
        }];
        [self.superViewController presentViewController:imagePickerVc animated:YES completion:nil];
        //        }
    }
}

#pragma mark - TZImagePickerController
- (void)pushImagePickerController {
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc]
                                              initWithMaxImagesCount:_maxImagesCount //最多可选择照片数
                                              columnNumber:4  //每行可显示照片数
                                              delegate:self
                                              pushPhotoPickerVc:YES];
#pragma mark - 四类个性化设置，这些参数都可以不传，此时会走默认设置
    imagePickerVc.isSelectOriginalPhoto = _isSelectOriginalPhoto;
    // 1.设置目前已经选中的图片数组
    imagePickerVc.selectedAssets = _selectedAssets; // 目前已经选中的图片数组
    imagePickerVc.allowTakePicture =self.allowTakePicture;//显示内部拍照按钮
    // 2. Set the appearance
    // 2. 在这里设置imagePickerVc的外观
     imagePickerVc.navigationBar.barTintColor = DSColorFromHex(0xB4B4B4);
     imagePickerVc.oKButtonTitleColorDisabled = DSColorFromHex(0xB4B4B4);
     imagePickerVc.oKButtonTitleColorNormal = DSColorFromHex(0xB4B4B4);
     imagePickerVc.navigationBar.translucent = NO;
    
    // 3. 设置是否可以选择视频/图片/原图
    imagePickerVc.allowPickingVideo = NO; // 是否允许选择视频
    imagePickerVc.allowPickingImage = YES; //是否允许选择图片
    imagePickerVc.allowPickingOriginalPhoto = YES;// 是否允许选择原片
    imagePickerVc.allowPickingGif = NO;  //是否允许选择GIF
    //    self.allowPickingGifSwitch.isOn;
    // 4. 照片排列按修改时间升序
    imagePickerVc.sortAscendingByModificationDate = NO;
    imagePickerVc.showSelectBtn = NO;
    imagePickerVc.needCircleCrop = NO;
    imagePickerVc.circleCropRadius = 100;
#pragma mark - 到这里为止
    [self.superViewController presentViewController:imagePickerVc animated:YES completion:nil];
}

#pragma mark - UIImagePickerController

- (void)takePhoto {
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if ((authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied) && iOS7Later) {
        // 无相机权限 做一个友好的提示
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"无法使用相机" message:@"请在iPhone的""设置-隐私-相机""中允许访问相机" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"设置", nil];
        [alert show];
        // 拍照之前还需要检查相册权限
    } else if ([TZImageManager authorizationStatus] == 2) { // 已被拒绝，没有相册权限，将无法保存拍的照片
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"无法访问相册" message:@"请在iPhone的""设置-隐私-相册""中允许访问相册" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"设置", nil];
        alert.tag = 1;
        [alert show];
    } else if ([TZImageManager authorizationStatus] == 0) { // 正在弹框询问用户是否允许访问相册，监听权限状态
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            return [self takePhoto];
        });
    } else { // 调用相机
        UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
        if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
            self.imagePickerVc.sourceType = sourceType;
            if(iOS8Later) {
                _imagePickerVc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
            }
            [self.superViewController presentViewController:_imagePickerVc animated:YES completion:nil];
        } else {
            NSLog(@"模拟器中无法打开照相机,请在真机中使用");
        }
    }
}
- (void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    if ([type isEqualToString:@"public.image"]) {
        TZImagePickerController *tzImagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:self];
        tzImagePickerVc.sortAscendingByModificationDate = NO; // 照片排序是否为升序
        //        self.sortAscendingSwitch.isOn;
        [tzImagePickerVc showProgressHUD];
        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
        // save photo and get asset / 保存图片，获取到asset
        [[TZImageManager manager] savePhotoWithImage:image completion:^(NSError *error){
            if (error) {
                [tzImagePickerVc hideProgressHUD];
                NSLog(@"图片保存失败 %@",error);
            } else {
                [[TZImageManager manager] getCameraRollAlbum:NO allowPickingImage:YES completion:^(TZAlbumModel *model) {
                    [[TZImageManager manager] getAssetsFromFetchResult:model.result allowPickingVideo:NO allowPickingImage:YES completion:^(NSArray<TZAssetModel *> *models) {
                        [tzImagePickerVc hideProgressHUD];
                        TZAssetModel *assetModel = [models firstObject];
                        if (tzImagePickerVc.sortAscendingByModificationDate) {
                            assetModel = [models lastObject];
                        }
                        
                        [self refreshCollectionViewWithAddedAsset:assetModel.asset image:image];
                    }];
                }];
            }
        }];
    }
}

- (void)refreshCollectionViewWithAddedAsset:(id)asset image:(UIImage *)image {
    TYimageModel * imageModel = [[TYimageModel alloc] init];
    imageModel.image = image;
    [_selectedPhotos addObject:imageModel];
    TYImageAssetModel * assetModel = [[TYImageAssetModel alloc] init];
    assetModel.asset = asset;
    [_selectedAssets addObject:assetModel];
    [self TYUpLoadImageViewReloadWithSeleterAssetsArray:_selectedAssets andSelterPhotoArr:_selectedPhotos];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    if ([picker isKindOfClass:[UIImagePickerController class]]) {
        [picker dismissViewControllerAnimated:YES completion:nil];
    }
}
#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) { // take photo / 去拍照
        [self takePhoto];
    } else if (buttonIndex == 1) {
        [self pushImagePickerController];
    }
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) { // 去设置界面，开启相机访问权限
        if (iOS8Later) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
        } else {
            
        }
    }
}

#pragma mark - TZImagePickerControllerDelegate

/// User click cancel button
/// 用户点击了取消
- (void)tz_imagePickerControllerDidCancel:(TZImagePickerController *)picker {
    // NSLog(@"cancel");
}
//相册选图之后的回调
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto {
    
    [_selectedPhotos removeAllObjects];
    for (id photo in photos) {
        TYimageModel * imageModel = [[TYimageModel alloc] init];
        if ([photo isKindOfClass:[UIImage class]]) {
            imageModel.image = photo;
        }
        [_selectedPhotos  addObject:imageModel];
    }
    
    [_selectedAssets removeAllObjects];
    
    for (int index = 0; index < [assets count]; index ++) {
        TZAssetModel * asset = assets[index];
//    }
//    for (TZAssetModel * asset in assets) {
        TYImageAssetModel * assetModel = [[TYImageAssetModel alloc] init];
        if ([asset isKindOfClass:[NSNumber class]]) {
            NSLog(@"这里有问题");
            [_selectedPhotos removeObjectAtIndex:index];
        }else{
            assetModel.asset = asset.asset;
            assetModel.imageUrl = asset.imageUrl;
            [_selectedAssets addObject:assetModel];
        }
    }
    _isSelectOriginalPhoto = isSelectOriginalPhoto;
    [self TYUpLoadImageViewReloadWithSeleterAssetsArray:_selectedAssets andSelterPhotoArr:_selectedPhotos];
    // _collectionView.contentSize = CGSizeMake(0, ((_selectedPhotos.count + 2) / 3 ) * (_margin + _itemWH));
    // 1.打印图片名字
    [self printAssetsName:assets];
}


#pragma mark - Click Event

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self endEditing:YES];
}

#pragma mark - Private

/// 打印图片名字
- (void)printAssetsName:(NSArray *)assets {
    NSString *fileName;
    for (id asset in assets) {
        if ([asset isKindOfClass:[PHAsset class]]) {
            PHAsset *phAsset = (PHAsset *)asset;
            fileName = [phAsset valueForKey:@"filename"];
        } else if ([asset isKindOfClass:[ALAsset class]]) {
            ALAsset *alAsset = (ALAsset *)asset;
            fileName = alAsset.defaultRepresentation.filename;;
        }
        NSLog(@"图片名字:%@",fileName);
    }
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}


-(void) TYUpLoadImageViewReloadWithSeleterAssetsArray:(NSArray *)selterAssetsArr andSelterPhotoArr:(NSArray *)selterPhotoArr{
    [_collectionView reloadData];
    if (self.returnimageBlock != nil) {
        self.returnimageBlock(selterAssetsArr, @[]);
    }
}

- (void)returnimages:(TYUpImageBlock)block{
    self.returnimageBlock = block;
}

/**
 写入图片
 ///  根据需要显示的图片数量来返回 该SubView 的高度
 ///  当显示的数量和该Type 下可以添加的最多照片书一样的 则少返回
 @param arrayImage 需要显示的图片
 @return SubView 的高度
 */
-(float)configViewWithData:(NSArray *)arrayImage{
    
    [_selectedAssets removeAllObjects];
    [_selectedPhotos removeAllObjects];
    
    for (AgentImageBaseModel * agentimageModel in arrayImage) {
        TYImageAssetModel * assetModel = [[TYImageAssetModel alloc] init];
        if (agentimageModel.url.length > 7) {
           assetModel.imageUrl = agentimageModel.url;
        }else{
            assetModel.asset = agentimageModel.asset;
        }
        [_selectedAssets addObject:assetModel];
        
        TYimageModel * imageModel = [[TYimageModel alloc] init];
        if ([agentimageModel.url length] > 7){
            imageModel.imageUrl = agentimageModel.url;
        }else if(agentimageModel.asset){
            imageModel.image =[self imagewithphAsset:agentimageModel.asset];
        }
        [_selectedPhotos addObject:imageModel];
    }
    NSInteger rowNumber ;
    if (arrayImage.count == _maxImagesCount) {
        if (arrayImage.count % 4 == 0) {
            rowNumber = arrayImage.count/4;
        }else{
            rowNumber = arrayImage.count/4 + 1;
        }
    }else{
        rowNumber = arrayImage.count/4 + 1;
    }
    [_collectionView reloadData];
//    NSLog(@">>>>>>%f>>>>>%ld>>>>>>>>%f",_itemWH,(long)rowNumber,(_itemWH + 4) * rowNumber);
    return (_itemWH + 10) * rowNumber;
}

-(UIImage *)imagewithphAsset:(PHAsset *)asset{
    dispatch_group_t group = dispatch_group_create();
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(1);
    __block UIImage * image = [[UIImage alloc] init];
    if (asset) {
        
        if ([asset isKindOfClass:[NSString class]]) {
            return [UIImage new];
        }        
        PHImageRequestOptions *option = [[PHImageRequestOptions alloc]init];
        option.synchronous = NO;
        option.networkAccessAllowed = NO;
        [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:CGSizeMake(300, 300)
                                                  contentMode:PHImageContentModeAspectFit options:option resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
                                                      image = [result resizedImageWithContentMode:UIViewContentModeScaleAspectFit bounds:CGSizeMake(50, 50) interpolationQuality:kCGInterpolationMedium];
                                                  }];
        dispatch_semaphore_signal(semaphore);
    }else{
        dispatch_semaphore_signal(semaphore);
        image = nil;
    }
    dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
    return image;
}
@end
