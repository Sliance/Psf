//
//  ServiceViewController.m
//  Psf
//
//  Created by 燕来秋mac9 on 2018/8/20.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "ServiceViewController.h"

@interface ServiceViewController ()<UIWebViewDelegate>
@property(nonatomic,strong)UIWebView *webview;

@end

@implementation ServiceViewController
-(UIWebView *)webview{
    if (!_webview) {
        _webview = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
        _webview.delegate = self;
    }
    return _webview;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.webview];
    NSURL *url = [NSURL URLWithString:@"https://www.sobot.com/chat/h5/index.html?sysNum=54494af958d2440a985e6b42c1eb15d6&source=2"];//创建URL
    NSURLRequest* request = [NSURLRequest requestWithURL:url];//创建
    [self.webview loadRequest:request];//加载
    
   
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
