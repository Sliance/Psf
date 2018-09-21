//
//  MembershipCardController.m
//  Psf
//
//  Created by 燕来秋mac9 on 2018/9/20.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "MembershipCardController.h"
#import "CardHeadView.h"
#import "PaymentCardView.h"
#import "MineServiceApi.h"
#import "PaySuccessController.h"

@interface MembershipCardController ()
@property(nonatomic,strong)UIImageView *bgImage;
@property(nonatomic,strong)CardHeadView *headView;
@property(nonatomic,strong)PaymentCardView *payView;
@property(nonatomic,strong)NSTimer *timer;
@end

@implementation MembershipCardController
-(UIImageView *)bgImage{
    if (!_bgImage) {
        _bgImage = [[UIImageView alloc]init];
        _bgImage.image = [UIImage imageNamed:@"car_bg_icon"];
        _bgImage.frame = CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT);
        _bgImage.userInteractionEnabled = YES;
    }
    return _bgImage;
}
-(CardHeadView *)headView{
    if (!_headView) {
        _headView = [[CardHeadView alloc]init];
        _headView.backgroundColor = DSColorFromHex(0xEFEFEF);
        _headView.frame = CGRectMake(15, 10+[self navHeightWithHeight], SCREENWIDTH-30, 308);
        [_headView.layer setCornerRadius:2];
        _headView.userInteractionEnabled = YES;
        [_headView.layer setMasksToBounds:YES];
    }
    return _headView;
}
-(PaymentCardView *)payView{
    if (!_payView) {
        _payView = [[PaymentCardView alloc]init];
        _payView.frame = CGRectMake(15, 328+[self navHeightWithHeight], SCREENWIDTH-30, 358);
        _payView.backgroundColor = [UIColor whiteColor];
        [_payView.layer setCornerRadius:2];
        _payView.userInteractionEnabled = YES;
        [_payView.layer setMasksToBounds:YES];
    }
    return _payView;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    [self requestData];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.bgImage];
    [self.bgImage addSubview:self.headView];
    [self.bgImage addSubview:self.payView];
   UISwipeGestureRecognizer *swipeUp =[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeAction:)];
    swipeUp.direction =UISwipeGestureRecognizerDirectionUp;
    [self.payView addGestureRecognizer:swipeUp];
    UISwipeGestureRecognizer *swipeDown =[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeDownAction:)];
    swipeDown.direction =UISwipeGestureRecognizerDirectionDown;
    [self.payView addGestureRecognizer:swipeDown];
    
    
}
-(void)setErpCustomerNo:(NSString *)erpCustomerNo{
    _erpCustomerNo = erpCustomerNo;
    [self.headView setErpCustomerNo:erpCustomerNo];
}
-(void)obserceResult{
    StairCategoryReq *req = [[StairCategoryReq alloc]init];
    req.appId = @"993335466657415169";
    req.timestamp = @"529675086";
    req.token = [UserCacheBean share].userInfo.token;
    req.version = @"1.0.0";
    req.platform = @"ios";
    req.erpCustomerNo = _erpCustomerNo;
    __weak typeof(self)weakself = self;
    [[MineServiceApi share]observePayStatusWithParam:req response:^(id response) {
       
        if ([response count]>0) {
        
            PaySuccessController *successVC = [[PaySuccessController alloc]init];
            PlaceOrderRes *model = [[PlaceOrderRes alloc]init];
            model.saleOrderId = response[@"saleOrderId"];
            successVC.result = model;;
                [weakself.navigationController pushViewController:successVC animated:YES];
        
        }
    }];
}
-(void)timerAction{
    [self obserceResult];
}
-(void)requestData{
     StairCategoryReq *req = [[StairCategoryReq alloc]init];
    req.appId = @"993335466657415169";
    req.timestamp = @"529675086";
    req.token = [UserCacheBean share].userInfo.token;
    req.version = @"1.0.0";
    req.platform = @"ios";
    req.cityId = @"310100";
    req.cityName = @"上海市";
    __weak typeof(self)weakself = self;
    [[MineServiceApi share]paymentCodeWithParam:req response:^(id response) {
        if (response) {
            NSString *code = response[@"data"][@"payCode"];
            [weakself.payView setPayCode:code];
            [weakself.payView setMoney:response[@"data"][@"memberBalance"]];
        }
//        weakself.timer= [NSTimer timerWithTimeInterval:1 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
//        [[NSRunLoop mainRunLoop] addTimer:weakself.timer forMode:NSDefaultRunLoopMode];
//        [weakself.timer setFireDate:[NSDate distantPast]];
        [self obserceResult];
       
    }];
}
-(void)swipeAction:(UISwipeGestureRecognizer *)swipe
{

    [UIView transitionWithView:self.view
                      duration:0.5
                       options:UIViewAnimationOptionTransitionNone
                    animations:^{
                        self.headView.frame = CGRectMake(30, 30+[self navHeightWithHeight], SCREENWIDTH-60, 308);
                        self.payView.frame = CGRectMake(15, 70+[self navHeightWithHeight], SCREENWIDTH-30, 358);
                        
                    } completion:^(BOOL finished) {
                        self.headView.yinView.hidden = NO;
                    }];
    
}
-(void)swipeDownAction:(UISwipeGestureRecognizer *)swipe{

 
    [UIView transitionWithView:self.view
                      duration:0.5
                       options:UIViewAnimationOptionTransitionNone
                    animations:^{
                        self.headView.frame = CGRectMake(15, 10+[self navHeightWithHeight], SCREENWIDTH-30, 308);
                        self.payView.frame = CGRectMake(15, 328+[self navHeightWithHeight], SCREENWIDTH-30, 358);
                        self.headView.yinView.hidden = YES;
                    } completion:^(BOOL finished) {
                        
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
