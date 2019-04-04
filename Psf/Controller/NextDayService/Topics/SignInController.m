//
//  SignInController.m
//  Psf
//
//  Created by zhangshu on 2018/12/29.
//  Copyright © 2018 zhangshu. All rights reserved.
//

#import "SignInController.h"

@interface SignInController ()<UIWebViewDelegate>
@property(nonatomic,strong)UIWebView *webview;

@end

@implementation SignInController
-(UIWebView *)webview{
    if (!_webview) {
        _webview = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
        _webview.delegate = self;
        _webview.scrollView.showsHorizontalScrollIndicator = NO;
        _webview.scrollView.showsVerticalScrollIndicator = NO;
        _webview.backgroundColor = [UIColor whiteColor];
    }
    return _webview;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.webview];
    
    
}

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.view.backgroundColor = [UIColor whiteColor];
    }
    return self;
}
-(void)setType:(NSInteger)type{
    _type = type;
    if (_type == 0) {
        self.title = @"签到";
    }else if (_type ==1){
        self.title = @"积分明细";
    }
    [self loadUI];
}
-(void)loadUI{
    NSURL *url;
    if (self.type ==0) {
        url = [NSURL URLWithString:[NSString stringWithFormat:@"http://xcxb.lxnong.com/share/index.html#/signIn%@",[UserCacheBean share].userInfo.token]];
    }else if (self.type ==1){
        url = [NSURL URLWithString:[NSString stringWithFormat:@"http://xcxb.lxnong.com/share/index.html#/IntegralDetails%@",[UserCacheBean share].userInfo.token]];
    }
    NSURLRequest* request = [NSURLRequest requestWithURL:url];//创建
    [self.webview loadRequest:request];//加载
}

@end
