//
//  LoginNextViewController.m
//  Psf
//
//  Created by zhangshu on 2019/4/12.
//  Copyright © 2019 zhangshu. All rights reserved.
//

#import "LoginNextViewController.h"
#import "LoginServiceApi.h"
#import "PassWordLoginController.h"
#import "SettingPassWordController.h"
#import "NextServiceApi.h"

#import "WXApi.h"
#import "BindMobileController.h"
#import "MineViewController.h"

@interface LoginNextViewController ()
<UITextFieldDelegate>
@property(nonatomic,strong)UIImageView *headImage;
@property(nonatomic,strong)UITextField *codeField;
@property(nonatomic,strong)UIButton *sendCodeBtn;
@property(nonatomic,strong)UIButton *finishBtn;

@property(nonatomic,strong)NSTimer* timer;
@property(nonatomic,assign)NSInteger count;
@end

@implementation LoginNextViewController

-(UIImageView *)headImage{
    if (!_headImage) {
        _headImage = [[UIImageView alloc]init];
        _headImage.image = [UIImage imageNamed:@"login_icon"];
    }
    return _headImage;
}

-(UITextField *)codeField{
    if (!_codeField) {
        _codeField = [[UITextField alloc]init];
        _codeField.placeholder = @"请输入短信验证码";
        _codeField.delegate = self;
        _codeField.font = [UIFont systemFontOfSize:12];
        _codeField.borderStyle = UITextBorderStyleNone;
        _codeField.keyboardType = UIKeyboardTypeNumberPad;
        _codeField.maxLength = 6;
        _codeField.backgroundColor = DSColorFromHex(0xFAFAFA);
        [_codeField.layer setCornerRadius:3];
        [_codeField.layer setMasksToBounds:YES];
        [self setTextFieldLeftView:_codeField :@"请输入短信验证码" :10];
    }
    return _codeField;
}

-(UIButton *)sendCodeBtn{
    if (!_sendCodeBtn) {
        _sendCodeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _sendCodeBtn.enabled = NO;
        _sendCodeBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [_sendCodeBtn addTarget:self action:@selector(pressCode:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sendCodeBtn;
    
}

-(UIButton *)finishBtn{
    if (!_finishBtn) {
        _finishBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_finishBtn setBackgroundImage:[UIImage imageNamed:@"shopping_submit"] forState:UIControlStateNormal];
        [_finishBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_finishBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _finishBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_finishBtn addTarget:self action:@selector(pressFinishBtn:) forControlEvents:UIControlEventTouchUpInside];
        [_finishBtn.layer setCornerRadius:4];
        [_finishBtn.layer setMasksToBounds:YES];
    }
    return _finishBtn;
}



-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.shadowImage = [[UIImage alloc]init];
    if ([UserCacheBean share].userInfo.token.length==0) {
        [UserCacheBean share].userInfo.token = @"0";
    }
    
    [self setTitle:@""];
    
}
-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.view.backgroundColor = [UIColor whiteColor];
        self.navigationController.navigationBar.shadowImage = [[UIImage alloc]init];
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setLeftButtonWithIcon:[UIImage imageNamed:@""]];
    [self.view addSubview:self.headImage];
    [self.view addSubview:self.codeField];
    [self.view addSubview:self.sendCodeBtn];
    [self.view addSubview:self.finishBtn];
    [self.headImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(133);
        make.height.mas_equalTo(133);
        make.top.equalTo(self.view).offset([self navHeightWithHeight]+22);
        make.centerX.equalTo(self.view);
    }];
    [self.codeField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(240);
        make.height.mas_equalTo(40);
        make.top.equalTo(self.headImage.mas_bottom).offset(56);
        make.centerX.equalTo(self.view);
    }];
    [self.sendCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(64);
        make.height.mas_equalTo(24);
        make.bottom.equalTo(self.codeField.mas_bottom).offset(-9);
        make.right.equalTo(self.codeField.mas_right);
    }];
    [self.finishBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(240);
        make.height.mas_equalTo(39);
        make.top.equalTo(self.codeField.mas_bottom).offset(40);
        make.centerX.equalTo(self.view);
    }];

    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]init];
    [tap addTarget:self action:@selector(pressTap)];
    [self.view addGestureRecognizer:tap];
    
    [ZSNotification addWeixinLoginResultNotification:self action:@selector(weChartLgin:)];
    self.count = 60;
    self.sendCodeBtn.enabled = NO;
    // 加1个定时器
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeDown) userInfo: nil repeats:YES];
}
-(void)didRightClick{
    [self pressPassWord];
}

-(void)weChartLgin:(NSNotification *)noti{
    NSDictionary *userInfo = [noti userInfo];
    if ([[userInfo objectForKey:@"type"] isEqualToString:@"login"]) {
        
        if ([UserCacheBean share].userInfo.memberMobile.length>0) {
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            BindMobileController *bindVC = [[BindMobileController alloc]init];
            bindVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:bindVC animated:YES];
        }
    }
}
-(void)pressTap{
    [_codeField resignFirstResponder];
}

-(void)sendCode{
    LoginReq *req = [[LoginReq alloc]init];
    req.memberMobile = self.phone;
    req.token = @"";
    req.timestamp = @"0";
    req.version = @"1.0.0";
    req.appId = @"993335466657415169";
    req.platform = @"ios";
    __weak typeof(self)weakself = self;
    [[LoginServiceApi share]sendVerCodeWithParam:req response:^(id response) {
        if (response) {
            if ([response[@"code"] integerValue] == 200) {
                [weakself showToast:@"发送验证码成功"];
            }
        }
    }];
}
-(void)goToLogin{
    
    if (_codeField.text.length<1) {
        [self showToast:@"请输入验证码"];
        return;
    }
    LoginReq *req = [[LoginReq alloc]init];
    req.memberMobile = self.phone;
    req.smsCaptchaCode = _codeField.text;
    req.token = @"";
    req.timestamp = @"0";
    req.version = @"1.0.0";
    req.appId = @"993335466657415169";
    req.platform = @"ios";
    __weak typeof(self)weakself = self;
    [[LoginServiceApi share]requestLoginWithParam:req response:^(id response) {
        if ([response[@"code"]integerValue] ==200 ) {
            NSError *error = nil;
            UserBaseInfoModel *userInfoModel = [MTLJSONAdapter modelOfClass:UserBaseInfoModel.class fromJSONDictionary:response[@"data"] error:&error];
            [UserCacheBean share].userInfo = userInfoModel;
            [ZSNotification postRefreshLocationResultNotification:nil];
            for (UIViewController *viewcontroller in self.navigationController.viewControllers) {
                if ([viewcontroller isKindOfClass:[MineViewController class]]) {
                    [weakself.navigationController popToViewController:viewcontroller animated:YES];
                }
            }
        }else{
            [self showToast:response[@"message"]];
        }
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
-(void)pressCode:(UIButton*)sender{
    self.count = 60;
    self.sendCodeBtn.enabled = NO;
    // 加1个定时器
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeDown) userInfo: nil repeats:YES];
    [self sendCode];
}
-(void)pressFinishBtn:(UIButton*)sender{
    [self goToLogin];
}
- (void)timeDown
{
    if (self.count != 1){
        
        self.count -=1;
        self.sendCodeBtn.enabled = NO;
        
        [self.sendCodeBtn setTitle:[NSString stringWithFormat:@"%ld", (long)self.count] forState:UIControlStateNormal];
        [self.sendCodeBtn setTitleColor:DSColorFromHex(0xB4B4B4) forState:UIControlStateNormal];
    } else {
        
        self.sendCodeBtn.enabled = YES;
        self.sendCodeBtn.backgroundColor = [UIColor clearColor];
        [self.sendCodeBtn setTitleColor:DSColorFromHex(0xFF4E4D) forState:UIControlStateNormal];
        [self.sendCodeBtn setTitle:@"重发" forState:UIControlStateNormal];
        [self.timer invalidate];
    }
    
}

-(void)pressPassWord{
    PassWordLoginController *passVC = [[PassWordLoginController alloc]init];
    passVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:passVC animated:YES];
    
}

- (void)getAuthWithUserInfoFromWechat
{
    //    [[WXApiManager sharedManager] sendAuthRequestWithController:self
    //                                                       delegate:self];
    [self sendAuthRequest];
}

-(void)sendAuthRequest
{
    //构造SendAuthReq结构体
    SendAuthReq* req =[[SendAuthReq alloc]init];
    req.scope = @"snsapi_userinfo";
    req.state = @"LxnScheme";
    //第三方向微信终端发送一个SendAuthReq消息结构
    [WXApi sendReq:req];
}

@end
