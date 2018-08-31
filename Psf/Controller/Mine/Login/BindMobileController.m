//
//  BindMobileController.m
//  Psf
//
//  Created by 燕来秋mac9 on 2018/8/22.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "BindMobileController.h"
#import "LoginServiceApi.h"
#import "MineViewController.h"

@interface BindMobileController ()
<UITextFieldDelegate>
@property(nonatomic,strong)UIImageView *headImage;
@property(nonatomic,strong)UITextField *phoneField;
@property(nonatomic,strong)UITextField *codeField;
@property(nonatomic,strong)UILabel *phoneLine;
@property(nonatomic,strong)UILabel *codelLine;
@property(nonatomic,strong)UIButton *sendCodeBtn;
@property(nonatomic,strong)UIButton *finishBtn;
@end

@implementation BindMobileController
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
        [_finishBtn setTitle:@"绑定手机号" forState:UIControlStateNormal];
        [_finishBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _finishBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_finishBtn addTarget:self action:@selector(pressNext) forControlEvents:UIControlEventTouchUpInside];
        [_finishBtn.layer setCornerRadius:4];
        [_finishBtn.layer setMasksToBounds:YES];
    }
    return _finishBtn;
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
    
    
    [self.view addSubview:self.headImage];
    [self.view addSubview:self.phoneField];
    [self.view addSubview:self.codeField];
    [self.view addSubview:self.sendCodeBtn];
    [self.view addSubview:self.finishBtn];
    [self.phoneField addSubview:self.phoneLine];
    [self.codeField addSubview:self.codelLine];
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
    [self.sendCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(64);
        make.height.mas_equalTo(24);
        make.bottom.equalTo(self.codeField.mas_bottom).offset(-9);
        make.right.equalTo(self.codeField.mas_right);
    }];
    [self.finishBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(240);
        make.height.mas_equalTo(39);
        make.top.equalTo(self.codeField.mas_bottom).offset(33);
        make.centerX.equalTo(self.view);
    }];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFiledTextChange:) name:UITextFieldTextDidChangeNotification object:nil];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]init];
    [tap addTarget:self action:@selector(pressTap)];
    [self.view addGestureRecognizer:tap];
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
-(void)pressNext{
    LoginReq *req = [[LoginReq alloc]init];
    req.token = [UserCacheBean share].userInfo.token;
    req.timestamp = @"0";
    req.version = @"1.0.0";
    req.appId = @"993335466657415169";
    req.platform = @"ios";
    req.smsCaptchaCode = _codeField.text;
    req.memberMobile = _phoneField.text;
    __weak typeof(self)weakself = self;
    [[LoginServiceApi share]validVerCodeWithParam:req response:^(id response) {
        if ([response[@"code"] integerValue] == 200) {
            [UserCacheBean share].userInfo.memberMobile = weakself.phoneField.text;
            for (UIViewController *controller in self.navigationController.viewControllers) {
                if ([controller isKindOfClass:[MineViewController class]]) {
                    [self.navigationController popToViewController:controller animated:YES];
                }
            }
           
        }else{
            [weakself showToast:response[@"message"]];
        }
    }];
    
}
-(void)pressCode:(UIButton*)sender{
    [self sendCode];
}
-(void)sendCode{
    if (_phoneField.text.length<1) {
        [self showToast:@"请输入手机号码"];
        return;
    }
    LoginReq *req = [[LoginReq alloc]init];
    req.memberMobile = _phoneField.text;
    req.token = [UserCacheBean share].userInfo.token;
    req.timestamp = @"0";
    req.version = @"1.0.0";
    req.appId = @"993335466657415169";
    req.platform = @"ios";
    __weak typeof(self)weakself = self;
    [[LoginServiceApi share]bindPhoneWithParam:req response:^(id response) {
        if (response) {
            if ([response[@"code"] integerValue] == 200) {
                [weakself showToast:@"发送验证码成功"];
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
