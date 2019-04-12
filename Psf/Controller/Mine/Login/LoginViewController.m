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
#import "NextServiceApi.h"

#import "WXApi.h"
#import "BindMobileController.h"
#import "LoginNextViewController.h"

@interface LoginViewController ()<UITextFieldDelegate>
@property(nonatomic,strong)UIImageView *headImage;
@property(nonatomic,strong)UITextField *phoneField;
@property(nonatomic,strong)UIButton *finishBtn;
@property(nonatomic,strong)UIButton *wechartBtn;
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
        _phoneField.backgroundColor = DSColorFromHex(0xFAFAFA);
        [_phoneField.layer setCornerRadius:3];
        [_phoneField.layer setMasksToBounds:YES];
        [self setTextFieldLeftView:_phoneField :@"请输入手机号" :10];
    }
    return _phoneField;
}
-(UIButton *)finishBtn{
    if (!_finishBtn) {
        _finishBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_finishBtn setBackgroundImage:[UIImage imageNamed:@"shopping_submit"] forState:UIControlStateNormal];
        [_finishBtn setTitle:@"下一步" forState:UIControlStateNormal];
        [_finishBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _finishBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_finishBtn addTarget:self action:@selector(pressFinishBtn:) forControlEvents:UIControlEventTouchUpInside];
        [_finishBtn.layer setCornerRadius:4];
        [_finishBtn.layer setMasksToBounds:YES];
    }
    return _finishBtn;
}
-(UIButton *)wechartBtn{
    if (!_wechartBtn) {
        _wechartBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_wechartBtn setImage:[UIImage imageNamed:@"wechart_login"] forState:UIControlStateNormal];
        [_wechartBtn addTarget:self action:@selector(getAuthWithUserInfoFromWechat) forControlEvents:UIControlEventTouchUpInside];
        _wechartBtn.hidden = YES;
    }
    return _wechartBtn;
}

-(UILabel *)loginLabel{
    if (!_loginLabel) {
        _loginLabel = [[UILabel alloc]init];
        _loginLabel.text = @"微信登录";
        _loginLabel.textAlignment = NSTextAlignmentCenter;
        _loginLabel.textColor = DSColorFromHex(0x787878);
        _loginLabel.font = [UIFont systemFontOfSize:10];
        _loginLabel.hidden = YES;
    }
    return _loginLabel;
}
-(UILabel *)leftLineLabel{
    if (!_leftLineLabel) {
        _leftLineLabel = [[UILabel alloc]init];
        _leftLineLabel.backgroundColor = DSColorFromHex(0xDCDCDC);
        _leftLineLabel.hidden = YES;
    }
    return _leftLineLabel;
}
-(UILabel *)rightlineLabel{
    if (!_rightlineLabel) {
        _rightlineLabel = [[UILabel alloc]init];
        _rightlineLabel.backgroundColor = DSColorFromHex(0xDCDCDC);
        _rightlineLabel.hidden = YES;
    }
    return _rightlineLabel;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.shadowImage = [[UIImage alloc]init];
    if ([UserCacheBean share].userInfo.token.length==0) {
         [UserCacheBean share].userInfo.token = @"0";
    }
    [self setTitle:@""];
    [self iswechart];
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
    [self setRightButtonWithTitle:@"密码登录    "];
    [self.view addSubview:self.headImage];
    [self.view addSubview:self.phoneField];
    [self.view addSubview:self.finishBtn];
    [self.view addSubview:self.wechartBtn];
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
        make.top.equalTo(self.headImage.mas_bottom).offset(56);
        make.centerX.equalTo(self.view);
    }];
    [self.finishBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(240);
        make.height.mas_equalTo(39);
        make.top.equalTo(self.phoneField.mas_bottom).offset(40);
        make.centerX.equalTo(self.view);
    }];
    [self.loginLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       make.top.equalTo(self.finishBtn.mas_bottom).offset(30);
        make.width.mas_equalTo(70);
        make.centerX.equalTo(self.finishBtn);
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
    [self.wechartBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(40);
        make.top.equalTo(self.finishBtn.mas_bottom).offset(62);
        make.centerX.equalTo(self.finishBtn);
    }];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]init];
    [tap addTarget:self action:@selector(pressTap)];
    [self.view addGestureRecognizer:tap];
    [ZSNotification addWeixinLoginResultNotification:self action:@selector(weChartLgin:)];
}
-(void)iswechart{
    StairCategoryReq *req = [[StairCategoryReq alloc]init];
    req.appId = @"993335466657415169";
    req.timestamp = @"529675086";
    req.token = @"";
    req.version = @"";
    req.platform = @"ios";
    req.businessParamKey = @"loginIsWebchat";
    __weak typeof(self)weakself = self;
    [[NextServiceApi share]getDefaultWeightWithParam:req response:^(id response) {
        if (response) {
            NSInteger  isopen= [response[@"data"][@"businessParamValue"] integerValue];
            if (isopen ==0) {
                weakself.wechartBtn.hidden = YES;
                weakself.loginLabel.hidden = YES;
                weakself.leftLineLabel.hidden = YES;
                weakself.rightlineLabel.hidden = YES;
            }else{
                weakself.wechartBtn.hidden = NO;
                weakself.loginLabel.hidden = NO;
                weakself.leftLineLabel.hidden = NO;
                weakself.rightlineLabel.hidden = NO;
            }
            
        }
    }];
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
    [_phoneField resignFirstResponder];
}
-(void)sendCode{
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
                LoginNextViewController *nextVC = [[LoginNextViewController alloc]init];
                nextVC.phone = weakself.phoneField.text;
                [weakself.navigationController pushViewController:nextVC animated:YES];
            }
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)pressFinishBtn:(UIButton*)sender{
    if (_phoneField.text.length !=11) {
        [self showInfo:@"请输入正确的手机号"];
        return;
    }
    [self sendCode];
}


-(void)pressPassWord{
    PassWordLoginController *passVC = [[PassWordLoginController alloc]init];
    passVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:passVC animated:YES];
    
}

- (void)getAuthWithUserInfoFromWechat
{
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
