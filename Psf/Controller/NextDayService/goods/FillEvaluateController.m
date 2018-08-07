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
#import "FillEvaluateCell.h"
#import "CartProductModel.h"
#import "NextServiceApi.h"
#import "EvaluateListModel.h"
@interface FillEvaluateController ()<UIScrollViewDelegate,UIActionSheetDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate,UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)NSMutableArray <AgentImageBaseModel*>*imageArr;
@property(nonatomic,strong)NSMutableArray *imageurlArr;
@property(nonatomic,strong)NSMutableArray *dataArr;
@property(nonatomic,strong)NSMutableArray *reqArr;
@property(nonatomic,strong)UIButton *sumitBtn;
@property(nonatomic,strong)UITableView *tableview;

@end

@implementation FillEvaluateController


-(UIButton *)sumitBtn{
    if (!_sumitBtn) {
        _sumitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_sumitBtn setTitle:@"提交" forState:UIControlStateNormal];
        [_sumitBtn.layer setBorderColor:DSColorFromHex(0x464646).CGColor];
        [_sumitBtn.layer setBorderWidth:0.5];
        [_sumitBtn setTitleColor:DSColorFromHex(0x454545) forState:UIControlStateNormal];
        _sumitBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_sumitBtn.layer setCornerRadius:2];
        [_sumitBtn.layer setMasksToBounds:YES];
        _sumitBtn.frame = CGRectMake(SCREENWIDTH-105, 6, 90, 34);
        [_sumitBtn addTarget:self action:@selector(pressSubmit) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sumitBtn;
}

-(UITableView *)tableview{
    if (!_tableview) {
        _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT) style:UITableViewStylePlain];
        _tableview.separatorColor = [UIColor clearColor];
        _tableview.delegate = self;
        _tableview.dataSource = self;
    }
    return _tableview;
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
    self.imageArr = [NSMutableArray array];
    self.imageurlArr = [NSMutableArray array];
    [self.view addSubview:self.tableview];
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 46)];
    [headView addSubview:self.sumitBtn];
    self.tableview.tableFooterView = headView;
    
}

-(void)setModel:(OrderListRes *)model{
    _model = model;
    _dataArr = [NSMutableArray array];
    _reqArr = [NSMutableArray array];
    EvaluateListModel *evamodel = [[EvaluateListModel alloc]init];
    [_dataArr addObjectsFromArray:model.saleOrderProductList];
    for (CartProductModel *models in _dataArr) {
        if (models.productId) {
            evamodel.saleOrderId = [_model.saleOrderId integerValue];
            [_reqArr addObject:evamodel];
        }
    }
    [self.tableview reloadData];
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
    [self showLoadingwithtitle:@"" andActivity:YES];
    __weak typeof(self)weakself = self;
    [[UploadImageTool share]getQiniuUploadWithImages:imageMutArr Token:^(NSArray *imageArr) {
        [weakself.imageurlArr removeAllObjects];
        [weakself.imageurlArr addObjectsFromArray:imageArr];
                [weakself hideLoadWithAnimated:YES];
    } failure:^{
        
    }];
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
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CartProductModel *model = self.dataArr[indexPath.row];
    if (model.cellH>0) {
        return model.cellH;
    }
    return 350;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.model.saleOrderProductList.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identify = @"FillEvaluateCell";
    FillEvaluateCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell) {
        cell = [[FillEvaluateCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    __weak typeof(self)weakself = self;
    [cell setPhotoBlock:^(CartProductModel *model) {
        [weakself.dataArr replaceObjectAtIndex:model.index withObject:model];
        [weakself.tableview reloadData];
    }];
    [cell setContentBlock:^(EvaluateListModel *model) {
        [weakself.reqArr replaceObjectAtIndex:model.index withObject:model];
    }];
    CartProductModel *model = self.model.saleOrderProductList[indexPath.row];
    model.index = indexPath.row;
    [cell setModel:model];
    EvaluateListModel *evamodel = self.reqArr[indexPath.row];
    evamodel.index = indexPath.row;
    [cell setEvamodel:evamodel];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.viewPhotoBgIDCard.superViewController = self;
    return cell;
}

-(void)pressSubmit{
    FillEvaluateReq *req = [[FillEvaluateReq alloc]init];
    req.appId = @"993335466657415169";
    req.timestamp = @"529675086";
    req.token = [UserCacheBean share].userInfo.token;
    req.platform = @"ios";
    req.commentList = self.reqArr;
    [[NextServiceApi share]fillEvaluatetWithParam:req response:^(id response) {
        if ([response[@"code"] integerValue] ==200) {
            [self showToast:@"评论成功"];
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
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
