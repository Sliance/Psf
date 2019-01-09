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
    }
    return _webview;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.webview];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://xcxb.lxnong.com/share/index.html#/signIn%@",[UserCacheBean share].userInfo.token]];//创建URL
    NSURLRequest* request = [NSURLRequest requestWithURL:url];//创建
    [self.webview loadRequest:request];//加载
}

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"签到";
    }
    return self;
}

@end
