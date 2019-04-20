//
//  FeedbackController.m
//  Psf
//
//  Created by 燕来秋mac9 on 2018/8/10.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "FeedbackController.h"
#import "RefundfootView.h"
#import "BottomView.h"
#import "UIPlaceHolderTextView.h"
#import "FeedbackTypeView.h"
#import "MineServiceApi.h"

@interface FeedbackController ()<UIScrollViewDelegate>
@property(nonatomic,strong)UIScrollView *bgscrollow;
@property(nonatomic,strong)RefundfootView *footView;
@property(nonatomic,strong)BottomView *bottomView;
//@property(nonatomic,strong)UITextField *phoneField;
@property(nonatomic,strong)UIPlaceHolderTextView *contentTXT;
//@property(nonatomic,strong)UILabel *titleLabel;
//@property(nonatomic,strong)UIImageView *titleimage;
@property(nonatomic,strong)UIButton *titlebtn;
//@property(nonatomic,strong)FeedbackTypeView *feedView;
@property(nonatomic,assign)NSInteger index;
@property(nonatomic,strong)NSMutableArray *imageArr;
@end

@implementation FeedbackController
-(BottomView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[BottomView alloc]init];
        _bottomView.frame = CGRectMake(0, SCREENHEIGHT-[self tabBarHeight], SCREENWIDTH, [self tabBarHeight]);
        [_bottomView.bottomBtn setTitle:@"提交" forState:UIControlStateNormal];
        [_bottomView.bottomBtn addTarget:self action:@selector(pressBottom) forControlEvents:UIControlEventTouchUpInside];
    }
    return _bottomView;
}
//-(FeedbackTypeView *)feedView{
//    if (!_feedView) {
//        _feedView = [[FeedbackTypeView alloc]init];
//        [_feedView setHeight:[self tabBarHeight]];
//        _feedView.hidden = YES;
//        _feedView.frame = CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT);
//    }
//    return _feedView;
//}
-(RefundfootView *)footView{
    if (!_footView) {
        _footView = [[RefundfootView alloc]init];
        _footView.viewPhotoBgIDCard.superViewController = self;
//        _footView.frame = CGRectMake(0, 65, SCREENWIDTH, 135);
        _footView.backgroundColor = DSColorFromHex(0xF0F0F0);
    }
    return _footView;
}
-(UIScrollView *)bgscrollow{
    if (!_bgscrollow) {
        _bgscrollow  = [[UIScrollView alloc]init];
        _bgscrollow.delegate = self;
        _bgscrollow.backgroundColor = DSColorFromHex(0xF0F0F0);
        _bgscrollow.frame = CGRectMake(0, [self navHeightWithHeight], SCREENWIDTH, SCREENHEIGHT-[self tabBarHeight]);
    }
    return _bgscrollow;
}
//-(UITextField *)phoneField{
//    if (!_phoneField) {
//        _phoneField = [[UITextField alloc]init];
//
//        _phoneField.backgroundColor = [UIColor whiteColor];
//        _phoneField.font = [UIFont systemFontOfSize:15];
//        _phoneField.placeholder = @"请填写手机号码，方便我们与你联系";
//    }
//    return _phoneField;
//}
-(UIPlaceHolderTextView *)contentTXT{
    if (!_contentTXT) {
        _contentTXT = [[UIPlaceHolderTextView alloc]init];
        _contentTXT.placeholder = @"对我们的网站、商品、服务，您还有什么建议？";
        
    }
    return _contentTXT;
}
//-(UILabel *)titleLabel{
//    if (!_titleLabel) {
//        _titleLabel = [[UILabel alloc]init];
//        _titleLabel.textColor = DSColorFromHex(0x464646);
//        _titleLabel.font = [UIFont systemFontOfSize:15];
//        _titleLabel.textAlignment = NSTextAlignmentLeft;
//        _titleLabel.text = @"   请选择反馈类型（售后）";
//        _titleLabel.backgroundColor = [UIColor whiteColor];
//        _titleLabel.userInteractionEnabled = YES;
//    }
//    return _titleLabel;
//}
//-(UIImageView *)titleimage{
//    if (!_titleimage) {
//        _titleimage = [[UIImageView alloc]init];
//        _titleimage.image = [UIImage imageNamed:@"down_icon"];
//
//    }
//    return _titleimage;
//}
-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self setTitle:@"设置"];
        self.view.backgroundColor = DSColorFromHex(0xF0F0F0);
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    if (@available(iOS 11.0, *)) {
        _bgscrollow.contentInsetAdjustmentBehavior = NO;
    } else {
        self.navigationController.navigationBar.translucent = NO;
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    _imageArr = [NSMutableArray array];
    [self.view addSubview:self.bgscrollow];
    [self.view addSubview:self.bottomView];
//    [self.view addSubview:self.feedView];
    [self.bgscrollow addSubview:self.footView];
//    [self.bgscrollow addSubview:self.phoneField];
    [self.bgscrollow addSubview:self.contentTXT];
    
//    [self.bgscrollow addSubview:self.titleLabel];
//    [self.bgscrollow addSubview:self.titleimage];
//    [self setTextFieldLeftView:self.phoneField :@"" :15];
//    self.titleimage.frame = CGRectMake(SCREENWIDTH-30, 23, 14, 8);
//    self.titleLabel.frame = CGRectMake(0, 5, SCREENWIDTH, 44);
    
//    self.phoneField.frame = CGRectMake(0, self.titleLabel.ctBottom+5, SCREENWIDTH, 44);
    self.contentTXT.frame = CGRectMake(0, 0, SCREENWIDTH, 180);
    self.footView.frame = CGRectMake(0, self.contentTXT.ctBottom+5, SCREENWIDTH, 135);
    __weak typeof(self)weakself = self;
    [self.footView setPhotoBlock:^(NSMutableArray *arr) {
        weakself.imageArr = arr;
    }];
//    [self.feedView setIndex:_index];
//
//    [self.feedView setSelectedBlock:^(NSInteger index,NSString *text) {
//        weakself.index = index;
//        [weakself.feedView setIndex:weakself.index];
//        weakself.feedView.hidden = YES;
//        weakself.titleLabel.text = [NSString stringWithFormat:@"   请选择反馈类型（%@）",text];
//    }];
//    [self.feedView setYinBlock:^{
//         weakself.feedView.hidden = YES;
//    }];
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(presstap)];
//    [self.titleLabel addGestureRecognizer:tap];
}
-(void)presstap{
//    self.feedView.hidden = NO;
}
-(void)pressBottom{
    FeetbackReq *req = [[FeetbackReq alloc]init];
//    req.memberFeedbackType = @"";
    req.memberFeedbackContent = _contentTXT.text;
    req.memberFeedbackImage = self.imageArr;
    req.appId = @"993335466657415169";
    req.timestamp = @"529675086";
    req.token = [UserCacheBean share].userInfo.token;
    req.platform = @"ios";
    [[MineServiceApi share]feedBackWithParam:req response:^(id response) {
        if (response) {
            if ([response[@"code"] integerValue] == 200) {
                [self showToast:@"反馈成功"];
                [self.navigationController popViewControllerAnimated:YES];
            }
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
