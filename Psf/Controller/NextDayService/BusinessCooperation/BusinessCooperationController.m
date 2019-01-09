//
//  BusinessCooperationController.m
//  Psf
//
//  Created by 燕来秋mac9 on 2018/8/23.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "BusinessCooperationController.h"
#import "NextServiceApi.h"

@interface BusinessCooperationController ()<UIScrollViewDelegate>
@property(nonatomic,strong)UIImageView *imageView;
@property(nonatomic,strong)UIScrollView *bgscrollow;
@end

@implementation BusinessCooperationController
-(UIScrollView *)bgscrollow{
    if (!_bgscrollow) {
        _bgscrollow = [[UIScrollView alloc]init];
        _bgscrollow.delegate = self;
        _bgscrollow.frame = CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT);
        _bgscrollow.showsHorizontalScrollIndicator = NO;
        _bgscrollow.showsVerticalScrollIndicator = NO;
    }
    return _bgscrollow;
}
-(UIImageView *)imageView{
    if (!_imageView) {
        _imageView  = [[UIImageView alloc]init];
       
    }
    return _imageView;
}
-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self setTitle:@"企业合作"];
        
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.bgscrollow];
    [self.bgscrollow addSubview:self.imageView];
    [self requestData];
}
-(void)requestData{
    StairCategoryReq * req = [[StairCategoryReq alloc]init];
    req.appId = @"993335466657415169";
    req.timestamp = @"529675086";
    req.token = [UserCacheBean share].userInfo.token;
    req.version = @"1.0.0";
    req.platform = @"ios";
    [[NextServiceApi share]businessCooperationWithParam:req response:^(id response) {
        if ([response[@"code"]integerValue] ==200) {
            NSDictionary *dic = [response[@"data"][@"list"] firstObject];
            NSString *url = [NSString stringWithFormat:@"%@%@",IMAGEHOST,dic[@"companyLogoImagePath"]];
            
             [self.imageView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@""] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                 CGSize size = image.size;
                 
                 CGFloat w = size.width;
                 
                 CGFloat H = size.height;
                 self.imageView.frame = CGRectMake(0, 0, SCREENWIDTH, H*SCREENWIDTH/w);
                 self.bgscrollow.contentSize = CGSizeMake(SCREENWIDTH, H*SCREENWIDTH/w);
             }];
            
        }else{
            [self showToast:response[@"message"]];
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
