//
//  IntegralRulesController.m
//  Psf
//
//  Created by dnaer7 on 2018/10/23.
//  Copyright © 2018 zhangshu. All rights reserved.
//

#import "IntegralRulesController.h"
#import "GroupServiceApi.h"

@interface IntegralRulesController ()<UIScrollViewDelegate>
@property(nonatomic,strong)UIImageView *headImage;
@property(nonatomic,strong)UIScrollView *bgscrollow;
@end

@implementation IntegralRulesController
-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self setTitle:@"积分规则"];
    }
    return self;
}
-(UIScrollView *)bgscrollow{
    if (!_bgscrollow) {
        _bgscrollow = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
        _bgscrollow.delegate = self;
    }
    return _bgscrollow;
}
-(UIImageView *)headImage{
    if (!_headImage) {
         _headImage = [[UIImageView alloc]init];
    }
    return _headImage;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.headImage];
    [self getBanner];
}
-(void)getBanner{
    GroupModelReq *req = [[GroupModelReq alloc]init];
    req.appId = @"993335466657415169";
    req.timestamp = @"529675086";
    req.token = [UserCacheBean share].userInfo.token;
    req.version = @"1.0.0";
    req.platform = @"ios";
    req.cityName = @"上海市";
    req.productBannerPosition = @"point_rule";
    __weak typeof(self)weakself = self;
    [[GroupServiceApi share]getPreAndGroupBannerWithParam:req response:^(id response) {
        if (response!= nil) {
            GroupBannerModel *model = [response firstObject];
            
            [weakself.headImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEHOST,model.productBannerImagePath]] placeholderImage:nil options:SDWebImageRetryFailed completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                
                weakself.headImage.frame = CGRectMake(0, 0, SCREENWIDTH, SCREENWIDTH/image.size.width*image.size.height);
                weakself.bgscrollow.contentSize = CGSizeMake(SCREENWIDTH, SCREENWIDTH/image.size.width*image.size.height);
            }];
        }
    }];
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
