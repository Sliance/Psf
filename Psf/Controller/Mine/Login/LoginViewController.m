//
//  LoginViewController.m
//  Psf
//
//  Created by 燕来秋mac9 on 2018/6/20.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginServiceApi.h"
#import "PassWordLoginController.h"
#import "SettingPassWordController.h"
#import <UMShare/UMShare.h>

#import "WXApi.h"
#import "BindMobileController.h"

@interface LoginViewController ()<UITextFieldDelegate>
@property(nonatomic,strong)UIImageView *headImage;
@property(nonatomic,strong)UITextField *phoneField;
@property(nonatomic,strong)UITextField *codeField;
@property(nonatomic,strong)UILabel *phoneLine;
@property(nonatomic,strong)UILabel *codelLine;
@property(nonatomic,strong)UIButton *sendCodeBtn;
@property(nonatomic,strong)UIButton *finishBtn;
@property(nonatomic,strong)UIButton *passLoginBtn;
@property(nonatomic,strong)UIButton *wechartBtn;
@property(nonatomic,strong)UIButton *qqBtn;
@property(nonatomic,strong)UIButton *weiboBtn;
@property(nonatomic,strong)UILabel* noticeLabel;
@property(nonatomic,strong)UILabel *loginLabel;

@property(nonatomic,strong)UILabel* leftLineLabel;
@property(nonatomic,strong)UILabel *rightlineLabel;
@end

@implementation LoginViewController
-(UIImageView *)headImage{
    if (!_headImage) {
        _headImage = [[UIImageView alloc]init];
        _headImage.image = [UIImage imageNamed:@"login_icon"];
    }
    return _headImage;
}
-(UITextField *)phoneField{
    if (!_phoneField) {
        _phoneField = [[UITextField alloc]init];
        _phoneField.placeholder = @"请输入手机号";
        _phoneField.delegate = self;
        _phoneField.font = [UIFont systemFontOfSize:12];
        _phoneField.borderStyle = UITextBorderStyleNone;
        _phoneField.keyboardType = UIKeyboardTypeNumberPad;
        _phoneField.maxLength =11;
        
    }
    return _phoneField;
}
-(UITextField *)codeField{
    if (!_codeField) {
        _codeField = [[UITextField alloc]init];
        _codeField.placeholder = @"短信验证码";
        _codeField.delegate = self;
        _codeField.font = [UIFont systemFontOfSize:12];
        _codeField.borderStyle = UITextBorderStyleNone;
        _codeField.keyboardType = UIKeyboardTypeNumberPad;
        _codeField.maxLength = 6;
    }
    return _codeField;
}
-(UILabel *)phoneLine{
    if (!_phoneLine) {
        _phoneLine = [[UILabel alloc]init];
        _phoneLine.backgroundColor = DSColorFromHex(0xDCDCDC);
    }
    return _phoneLine;
}
-(UILabel *)codelLine{
    if (!_codelLine) {
        _codelLine = [[UILabel alloc]init];
        _codelLine.backgroundColor = DSColorFromHex(0xDCDCDC);
    }
    return _codelLine;
}
-(UIButton *)sendCodeBtn{
    if (!_sendCodeBtn) {
        _sendCodeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        _sendCodeBtn.backgroundColor = DSColorFromHex(0xB4B4B4);
        [_sendCodeBtn setTitle:@"发送验证码" forState:UIControlStateNormal];
        [_sendCodeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _sendCodeBtn.titleLabel.font = [UIFont systemFontOfSize:10];
        [_sendCodeBtn addTarget:self action:@selector(pressCode:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sendCodeBtn;
    
}

-(UIButton *)finishBtn{
    if (!_finishBtn) {
        _finishBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_finishBtn setBackgroundImage:[UIImage imageNamed:@"shopping_submit"] forState:UIControlStateNormal];
        [_finishBtn setTitle:@"登录" forState:UIControlStateNormal];
        [_finishBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _finishBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_finishBtn addTarget:self action:@selector(pressFinishBtn:) forControlEvents:UIControlEventTouchUpInside];
        [_finishBtn.layer setCornerRadius:4];
        [_finishBtn.layer setMasksToBounds:YES];
    }
    return _finishBtn;
}
-(UIButton *)passLoginBtn{
    if (!_passLoginBtn) {
        _passLoginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_passLoginBtn setTitle:@"密码登录" forState:UIControlStateNormal];
        [_passLoginBtn setTitleColor:DSColorFromHex(0xFF4C4D) forState:UIControlStateNormal];
        _passLoginBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_passLoginBtn addTarget:self action:@selector(pressPassWord) forControlEvents:UIControlEventTouchUpInside];
        [_passLoginBtn.layer setBorderColor:DSColorFromHex(0xFF4C4D).CGColor];
        [_passLoginBtn.layer setBorderWidth:0.5];
        [_passLoginBtn.layer setCornerRadius:4];
        [_passLoginBtn.layer setMasksToBounds:YES];
    }
    return _passLoginBtn;
}
-(UIButton *)wechartBtn{
    if (!_wechartBtn) {
        _wechartBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_wechartBtn setImage:[UIImage imageNamed:@"wechart_login"] forState:UIControlStateNormal];
        [_wechartBtn addTarget:self action:@selector(getAuthWithUserInfoFromWechat) forControlEvents:UIControlEventTouchUpInside];
    }
    return _wechartBtn;
}
-(UIButton *)qqBtn{
    if (!_qqBtn) {
        _qqBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_qqBtn setImage:[UIImage imageNamed:@"qq_login"] forState:UIControlStateNormal];
//        [_qqBtn addTarget:self action:@selector(getAuthWithUserInfoFromQQ) forControlEvents:UIControlEventTouchUpInside];
    }
    return _qqBtn;
}
-(UIButton *)weiboBtn{
    if (!_weiboBtn) {
        _weiboBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_weiboBtn setImage:[UIImage imageNamed:@"weibo_login"] forState:UIControlStateNormal];
//        [_weiboBtn addTarget:self action:@selector(getAuthWithUserInfoFromSina) forControlEvents:UIControlEventTouchUpInside];
    }
    return _weiboBtn;
}
-(UILabel*)noticeLabel{
    if (!_noticeLabel) {
        _noticeLabel = [[UILabel alloc]init];
        _noticeLabel.text = @"首次登陆将自动注册";
        _noticeLabel.textColor = DSColorFromHex(0x222425);
        _noticeLabel.font = [UIFont systemFontOfSize:10];
    }
    return _noticeLabel;
}
-(UILabel *)loginLabel{
    if (!_loginLabel) {
        _loginLabel = [[UILabel alloc]init];
        _loginLabel.text = @"微信登录";
        _loginLabel.textAlignment = NSTextAlignmentCenter;
        _loginLabel.textColor = DSColorFromHex(0x787878);
        _loginLabel.font = [UIFont systemFontOfSize:10];
    }
    return _loginLabel;
}
-(UILabel *)leftLineLabel{
    if (!_leftLineLabel) {
        _leftLineLabel = [[UILabel alloc]init];
        _leftLineLabel.backgroundColor = DSColorFromHex(0xDCDCDC);
    }
    return _leftLineLabel;
}
-(UILabel *)rightlineLabel{
    if (!_rightlineLabel) {
        _rightlineLabel = [[UILabel alloc]init];
        _rightlineLabel.backgroundColor = DSColorFromHex(0xDCDCDC);
    }
    return _rightlineLabel;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.shadowImage = [[UIImage alloc]init];
//    [self setLeftButtonWithIcon:[UIImage imageNamed:@"date_dismiss"]];
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
    [self.view addSubview:self.phoneField];
    [self.view addSubview:self.codeField];
    [self.view addSubview:self.sendCodeBtn];
    [self.view addSubview:self.finishBtn];
    [self.view addSubview:self.passLoginBtn];
//    [self.view addSubview:self.weiboBtn];
    [self.view addSubview:self.wechartBtn];
//    [self.view addSubview:self.qqBtn];
    [self.view addSubview:self.noticeLabel];
    [self.phoneField addSubview:self.phoneLine];
    [self.codeField addSubview:self.codelLine];
    [self.view addSubview:self.loginLabel];
    [self.view addSubview:self.leftLineLabel];
    [self.view addSubview:self.rightlineLabel];
    [self.headImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(133);
        make.height.mas_equalTo(133);
        make.top.equalTo(self.view).offset([self navHeightWithHeight]+22);
        make.centerX.equalTo(self.view);
    }];
    [self.phoneField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(240);
        make.height.mas_equalTo(40);
        make.top.equalTo(self.headImage.mas_bottom).offset(41);
        make.centerX.equalTo(self.view);
    }];
    [self.codeField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(240);
        make.height.mas_equalTo(40);
        make.top.equalTo(self.phoneField.mas_bottom).offset(12);
        make.centerX.equalTo(self.view);
    }];
    [self.phoneLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(240);
        make.height.mas_equalTo(1);
        make.bottom.equalTo(self.phoneField.mas_bottom);
        make.centerX.equalTo(self.view);
    }];
    
    [self.codelLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(240);
        make.height.mas_equalTo(1);
        make.bottom.equalTo(self.codeField.mas_bottom);
        make.centerX.equalTo(self.view);
    }];
    [self.noticeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.codelLine.mas_left);
        make.top.equalTo(self.codelLine.mas_bottom).offset(10);
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
    [self.passLoginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(240);
        make.height.mas_equalTo(39);
        make.top.equalTo(self.finishBtn.mas_bottom).offset(15);
        make.centerX.equalTo(self.view);
    }];
    [self.loginLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       make.top.equalTo(self.passLoginBtn.mas_bottom).offset(30);
        make.width.mas_equalTo(70);
        make.centerX.equalTo(self.passLoginBtn);
    }];
    [self.leftLineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.loginLabel.mas_left);
        make.width.mas_equalTo(70);
        make.centerY.equalTo(self.loginLabel);
        make.height.mas_equalTo(0.5);
    }];
    [self.rightlineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.loginLabel.mas_right);
        make.width.mas_equalTo(70);
        make.centerY.equalTo(self.loginLabel);
        make.height.mas_equalTo(0.5);
    }];
//    [self.qqBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.width.mas_equalTo(40);
//        make.height.mas_equalTo(40);
//        make.top.equalTo(self.passLoginBtn.mas_bottom).offset(52);
//        make.centerX.equalTo(self.view);
//    }];

    [self.wechartBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(40);
        make.top.equalTo(self.passLoginBtn.mas_bottom).offset(62);
        make.centerX.equalTo(self.passLoginBtn);
    }];
//    [self.weiboBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.width.mas_equalTo(40);
//        make.height.mas_equalTo(40);
//        make.top.equalTo(self.passLoginBtn.mas_bottom).offset(52);
//        make.left.equalTo(self.qqBtn.mas_right).offset(27);
//    }];
//
    
       [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFiledTextChange:) name:UITextFieldTextDidChangeNotification object:nil];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]init];
    [tap addTarget:self action:@selector(pressTap)];
    [self.view addGestureRecognizer:tap];
   
    [ZSNotification addWeixinLoginResultNotification:self action:@selector(weChartLgin:)];
}

-(void)weChartLgin:(NSNotification *)noti{
    if ([UserCacheBean share].userInfo.memberMobile.length>0) {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        BindMobileController *bindVC = [[BindMobileController alloc]init];
        bindVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:bindVC animated:YES];
    }
    
}
-(void)pressTap{
    [_phoneField resignFirstResponder];
    [_codeField resignFirstResponder];
}
- (void)dealloc{
   
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
}
//
- (void)textFiledTextChange:(NSNotification *)noti{
    if (_phoneField.text.length>0) {
        [_sendCodeBtn setBackgroundImage:[UIImage imageNamed:@"login_sendcode"] forState:UIControlStateNormal];
    }else if (_phoneField.text.length==0) {
        [_sendCodeBtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        _sendCodeBtn.backgroundColor = DSColorFromHex(0xB4B4B4);
    }
}


-(void)sendCode{
    if (_phoneField.text.length<1) {
        [self showToast:@"请输入手机号码"];
        return;
    }
    LoginReq *req = [[LoginReq alloc]init];
    req.memberMobile = _phoneField.text;
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
    if (_phoneField.text.length<1) {
        [self showToast:@"请输入手机号码"];
        return;
    }
    if (_codeField.text.length<1) {
        [self showToast:@"请输入验证码"];
        return;
    }
    LoginReq *req = [[LoginReq alloc]init];
    req.memberMobile = _phoneField.text;
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
                [weakself.navigationController popViewControllerAnimated:YES];
            
        }else{
            [self showToast:response[@"message"]];
        }
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}
-(void)pressCode:(UIButton*)sender{
    [self sendCode];
}
-(void)pressFinishBtn:(UIButton*)sender{
    [self goToLogin];
}
-(void)pressPassWord{
    PassWordLoginController *passVC = [[PassWordLoginController alloc]init];
    passVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:passVC animated:YES];
    
}
- (void)getUserInfoForPlatform:(UMSocialPlatformType)platformType
{
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:platformType currentViewController:nil completion:^(id result, NSError *error) {
        UMSocialUserInfoResponse *resp = result;
        // 第三方登录数据(为空表示平台未提供)
        // 授权数据
        NSLog(@" uid: %@", resp.uid);
        NSLog(@" openid: %@", resp.openid);
        NSLog(@" accessToken: %@", resp.accessToken);
        NSLog(@" refreshToken: %@", resp.refreshToken);
        NSLog(@" expiration: %@", resp.expiration);
        // 用户数据
        NSLog(@" name: %@", resp.name);
        NSLog(@" iconurl: %@", resp.iconurl);
        NSLog(@" gender: %@", resp.unionGender);
        // 第三方平台SDK原始数据
        NSLog(@" originalResponse: %@", resp.originalResponse);
    }];
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
    req.state = @"Lxn";
    //第三方向微信终端发送一个SendAuthReq消息结构
    [WXApi sendReq:req];
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
