//
//  ChangePasswordController.m
//  Psf
//
//  Created by 燕来秋mac9 on 2018/8/2.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "ChangePasswordController.h"
#import "ResetPassFirstController.h"
#import "SettingPassWordController.h"
#import "LoginServiceApi.h"

@interface ChangePasswordController ()<UITextFieldDelegate>
@property(nonatomic,strong)UIImageView *headImage;

@property(nonatomic,strong)UITextField *codeField;

@property(nonatomic,strong)UILabel *codelLine;
@property(nonatomic,strong)UIButton *sendCodeBtn;
@property(nonatomic,strong)UIButton *finishBtn;


@end

@implementation ChangePasswordController

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
        _codeField.placeholder = @"请输入现有密码";
        _codeField.delegate = self;
        _codeField.font = [UIFont systemFontOfSize:12];
        _codeField.borderStyle = UITextBorderStyleNone;
        _codeField.keyboardType = UIKeyboardTypeNumberPad;
    }
    return _codeField;
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
        
        [_sendCodeBtn setTitle:@"忘记密码" forState:UIControlStateNormal];
        [_sendCodeBtn setTitleColor:DSColorFromHex(0xFF4D4D) forState:UIControlStateNormal];
        _sendCodeBtn.titleLabel.font = [UIFont systemFontOfSize:10];
        [_sendCodeBtn addTarget:self action:@selector(forgetPass) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sendCodeBtn;
    
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
    [self.view addSubview:self.codeField];
    [self.view addSubview:self.sendCodeBtn];
    [self.view addSubview:self.finishBtn];
    
    [self.codeField addSubview:self.codelLine];
    [self.headImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(133);
        make.height.mas_equalTo(133);
        make.top.equalTo(self.view).offset([self navHeightWithHeight]+22);
        make.centerX.equalTo(self.view);
    }];
    
    [self.codelLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(240);
        make.height.mas_equalTo(1);
        make.bottom.equalTo(self.headImage.mas_bottom).offset(106);
        make.centerX.equalTo(self.view);
    }];
    [self.codeField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(240);
        make.height.mas_equalTo(40);
        make.bottom.equalTo(self.codelLine.mas_top);
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
}
-(void)pressTap{
    
    [_codeField resignFirstResponder];
}
-(void)forgetPass{
    ResetPassFirstController *resetVC = [[ResetPassFirstController alloc]init];
    [self.navigationController pushViewController:resetVC animated:YES];
}
-(void)pressFinishBtn:(UIButton*)sender{
    LoginReq *req = [[LoginReq alloc]init];
    req.token = @"";
    req.timestamp = @"0";
    req.version = @"1.0.0";
    req.appId = @"993335466657415169";
    req.platform = @"ios";
    req.memberPassword = _codeField.text;
    req.memberMobile = [UserCacheBean share].userInfo.memberMobile;
    __weak typeof(self)weakself = self;
    [[LoginServiceApi share]passWordLoginWithParam:req response:^(id response) {
        if (response) {
//            NSError *error = nil;
//            UserBaseInfoModel *userInfoModel = [MTLJSONAdapter modelOfClass:UserBaseInfoModel.class fromJSONDictionary:response[@"data"] error:&error];
//            [UserCacheBean share].userInfo = userInfoModel;
//
//            [weakself.navigationController popViewControllerAnimated:YES];
            SettingPassWordController *setVC = [[SettingPassWordController alloc]init];
            [self.navigationController pushViewController:setVC animated:YES];
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
