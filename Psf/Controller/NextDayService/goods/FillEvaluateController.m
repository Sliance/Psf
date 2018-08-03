//
//  FillEvaluateController.m
//  Psf
//
//  Created by 燕来秋mac9 on 2018/7/5.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "FillEvaluateController.h"
#import "FillEvaluateHwadView.h"
#import "TYUploadImageView.h"
#import "AgentImageBaseModel.h"
#import "TYImageAssetModel.h"
#import "UIImage+Resize.h"
#import "UIImageView+WebCache.h"
#import "TZImageManager.h"
#import "UploadImageTool.h"


@interface FillEvaluateController ()<UIScrollViewDelegate>
@property(nonatomic,strong)UIScrollView *bgscrollow;
@property(nonatomic,strong)FillEvaluateHwadView *headView;
@property (nonatomic, strong) TYUploadImageView * viewPhotoBgIDCard;
@property(nonatomic,strong)NSMutableArray <AgentImageBaseModel*>*imageArr;
@property (nonatomic, assign) BOOL upCancel;
@property (nonatomic, assign) NSInteger requestid;
@property (nonatomic, strong) NSOperationQueue *queue;

@end

@implementation FillEvaluateController

-(TYUploadImageView *)viewPhotoBgIDCard{
    if (_viewPhotoBgIDCard == nil) {
        _viewPhotoBgIDCard = [[TYUploadImageView alloc] initWithFrame:CGRectMake(15, self.headView.ctBottom, 75, 75) withPlaceholderName:@"upload_image"];
        _viewPhotoBgIDCard.superViewController = self;
        [_viewPhotoBgIDCard returnimages:^(NSArray *images, NSArray *photoArr) {
            [self.imageArr removeAllObjects];
            for (int index = 0; index < images.count; index ++) {
                TYImageAssetModel  * assetModel = [images objectAtIndex:index];
                AgentImageBaseModel * agentModel = [[AgentImageBaseModel alloc] init];
                if (assetModel.imageUrl) {
                    agentModel.url = assetModel.imageUrl;
                }else{
                    agentModel.asset =assetModel.asset;
                }
                [self.imageArr addObject:agentModel];
            }
//            [self uploadImagewithImageArr:self.imageArr];
        }];
    }
    return _viewPhotoBgIDCard;
}
-(UIScrollView *)bgscrollow{
    if (!_bgscrollow) {
        _bgscrollow = [[UIScrollView alloc]init];
        _bgscrollow.delegate = self;
        _bgscrollow.frame = CGRectMake(0, [self navHeightWithHeight], SCREENWIDTH, SCREENHEIGHT);
        _bgscrollow.backgroundColor = DSColorFromHex(0xF0F0F0);
    }
    return _bgscrollow;
}
-(FillEvaluateHwadView *)headView{
    if (!_headView) {
        _headView = [[FillEvaluateHwadView alloc]initWithFrame:CGRectMake(0, 5, SCREENWIDTH, 260)];
        
    }
    return _headView;
    
}
-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self setNavWithTitle:@"评价"];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.bgscrollow];
    [self.bgscrollow addSubview:self.headView];
    [self.bgscrollow addSubview:self.viewPhotoBgIDCard];
    [self.viewPhotoBgIDCard configViewWithData:self.imageArr];
    
}
-(void)setModel:(OrderListRes *)model{
    _model = model;
}
-(void)uploadImagewithImageArr:(NSMutableArray <AgentImageBaseModel *>*) imageArr{
    if (imageArr.count <1) {
        return;
    }
    _upCancel = NO;
    __block NSMutableArray * imageMutArr = [[NSMutableArray alloc] initWithArray:imageArr];
    [self showLoadingwithtitle:@"" andActivity:YES];
    
    [[UploadImageTool share] getQiniuUploadWithImages:imageArr Token:^(NSArray *uploadDic) {
        for (int index = 0; index < [imageMutArr count]; index ++ ) {
            AgentImageBaseModel *dicImage = imageMutArr[index];
            if ([self checkImagewithArr:imageMutArr]) {
                [self hideLoadWithAnimated:YES];
                return ;
            }else{
                if ([dicImage.url length] < 7 ) {
                    [self preuploadImage:dicImage andIndex:index andImageArr:imageMutArr];
                }
            }
        }
        if ([imageMutArr count] == 0 ) {
            dispatch_sync(dispatch_get_main_queue(), ^(){
                [self hideLoadWithAnimated:YES];
            });
        }
    } failure:^{
        
    }];
}

- (void)preuploadImage:(AgentImageBaseModel *)imageModel andIndex:(NSInteger) index andImageArr:(NSMutableArray *)mutArr{
    dispatch_group_t group = dispatch_group_create();
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(1);
    dispatch_queue_t queue= dispatch_queue_create("test.queue", DISPATCH_QUEUE_CONCURRENT);
    AgentImageBaseModel *dicImage = imageModel;
    dispatch_sync(queue, ^{
        NSInteger requestid = 0;
        if (dicImage.asset != nil) {
            requestid = [self sendImageRequest:dicImage.asset andIndex:index andImageArr:mutArr];
            if (requestid == -1) {
                return ;
            }
            dispatch_semaphore_signal(semaphore);
        } else if (dicImage.url.length > 7){
            requestid = [dicImage.id integerValue];
            dispatch_semaphore_signal(semaphore);
        }
    });
    dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
}
- (NSInteger)sendImageRequest:(PHAsset *)asset andIndex:(NSInteger)index andImageArr:(NSMutableArray *)mutArr
{
    if (_upCancel) {
        return -1;
    }
    if ([asset isKindOfClass:[NSString class]]) {
        return -1;
    }
    __block UIImage * image = [self readImagewithPHAsset:asset];
    NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
        self.requestid = [[UploadImageTool share] uploadImage:image progress:^(NSString *key, float percent) {
            NSLog(@">>>>>>>>>>>>>>>>>>>>>>%f",percent);
        } cancleRequest:^BOOL{
            return _upCancel;
        } success:^(NSString *url,NSInteger requestID) {
            image = nil;
            AgentImageBaseModel *dicImage = mutArr[index];
            dicImage.url = url;
            [mutArr replaceObjectAtIndex:index withObject:dicImage];
            
            NSInteger isReqeustOver = 0;
            for (NSInteger i = 0; i < mutArr.count; i ++) {
                AgentImageBaseModel * imageModel = mutArr[i];
                if (imageModel.url.length > 7) {
                    isReqeustOver ++;
                }
            }
            if (isReqeustOver == mutArr.count) {
                [self hideLoadWithAnimated:YES];
                if ([self checkImagewithArr:mutArr]) {
                    return ;
                }
            }
        } failure:^{
            image = nil;
            [self hideLoadWithAnimated:YES];
            if (!_upCancel) {
                [self showInfoDetail:@"有图片上传失败，点击下一步重新上传"];
            }else{
            }
            return ;
        }];
    }];
    [_queue addOperation:operation];
    return self.requestid;
}

- (BOOL)checkImagewithArr:(NSArray *)imageArr {
    NSMutableArray * allImageMutArr = [[NSMutableArray alloc] init];
    [allImageMutArr addObjectsFromArray:imageArr];
    for (AgentImageBaseModel*dicImage in allImageMutArr) {
        if (dicImage.url) {
            if ([dicImage.url length] < 7 ) {
                return NO;
            }
        }else{
            return NO;
        }
    }
    return YES;
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
