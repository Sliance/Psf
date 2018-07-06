//
//  AboutViewController.m
//  Psf
//
//  Created by 燕来秋mac9 on 2018/7/3.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "AboutViewController.h"

@interface AboutViewController ()
@property(nonatomic,strong)UIImageView *iconImage;
@property(nonatomic,strong)UIButton *evaluateBtn;
@property(nonatomic,strong)UIButton *privacyBtn;
@property(nonatomic,strong)UILabel *bottomLabel;
@end

@implementation AboutViewController
-(UIImageView *)iconImage{
    if (!_iconImage) {
        _iconImage = [[UIImageView alloc]init];
        _iconImage.image = [UIImage imageNamed:@"icon_about"];
    }
    return _iconImage;
}
-(UILabel *)bottomLabel{
    if (!_bottomLabel) {
        _bottomLabel = [[UILabel alloc]init];
        _bottomLabel.text = @"犁小农公司版权所有 © 2017-2018";
        _bottomLabel.font = [UIFont systemFontOfSize:12];
        _bottomLabel.textAlignment = NSTextAlignmentCenter;
        _bottomLabel.textColor = DSColorFromHex(0x323232);
    }
    return _bottomLabel;
}
-(UIButton *)privacyBtn{
    if (!_privacyBtn) {
        _privacyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_privacyBtn.layer setMasksToBounds:YES];
        [_privacyBtn.layer setCornerRadius:1];
        [_privacyBtn.layer setBorderColor:DSColorFromHex(0x464646).CGColor];
        [_privacyBtn.layer setBorderWidth:1];
        _privacyBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_privacyBtn setTitleColor:DSColorFromHex(0x323232) forState:UIControlStateNormal];
        [_privacyBtn setTitle:@"隐私申明" forState:UIControlStateNormal];
        
    }
    return _privacyBtn;
}
-(UIButton *)evaluateBtn{
    if (!_evaluateBtn) {
        _evaluateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_evaluateBtn.layer setMasksToBounds:YES];
        [_evaluateBtn.layer setCornerRadius:1];
        [_evaluateBtn.layer setBorderColor:DSColorFromHex(0x464646).CGColor];
        [_evaluateBtn.layer setBorderWidth:1];
        _evaluateBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_evaluateBtn setTitleColor:DSColorFromHex(0x323232) forState:UIControlStateNormal];
        [_evaluateBtn setTitle:@"评价我们" forState:UIControlStateNormal];
        
    }
    return _evaluateBtn;
}
-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.view.backgroundColor = [UIColor whiteColor];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.iconImage];
    [self.view addSubview:self.evaluateBtn];
    [self.view addSubview:self.privacyBtn];
    [self.view addSubview:self.bottomLabel];
    [self.iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(90);
        make.centerX.equalTo(self.view);
        make.centerY.equalTo(self.view).offset(-90);
    }];
    [self.bottomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-26);
    }];
    [self.privacyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(120);
        make.centerX.equalTo(self.view);
        make.height.mas_equalTo(36);
        make.bottom.equalTo(self.bottomLabel.mas_top).offset(-49);
    }];
    [self.evaluateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(120);
        make.centerX.equalTo(self.view);
        make.height.mas_equalTo(36);
        make.bottom.equalTo(self.privacyBtn.mas_top).offset(-20);
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
