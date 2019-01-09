//
//  OrderRuleController.m
//  Psf
//
//  Created by zhangshu on 2019/1/9.
//  Copyright © 2019 zhangshu. All rights reserved.
//

#import "OrderRuleController.h"

@interface OrderRuleController ()<UIWebViewDelegate>
@property(nonatomic,strong)UIWebView *webView;
@end

@implementation OrderRuleController
-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
       
        
    }
    return self;
}
-(UIWebView *)webView{
    if (!_webView) {
        _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
        _webView.delegate = self;
        _webView.backgroundColor = [UIColor whiteColor];
        _webView.scrollView.showsHorizontalScrollIndicator = NO;
        _webView.scrollView.showsVerticalScrollIndicator = NO;
    }
    return _webView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.webView];
   
}

-(void)setType:(NSInteger)type{
    
    if (type == 0) {
         [self setTitle:@"订单规则"];
        NSURL *url = [NSURL URLWithString:@"http://xcxb.lxnong.com/share/index.html#/rulesorder_rule"];//创建URL
        NSURLRequest* request = [NSURLRequest requestWithURL:url];//创建
        [self.webView loadRequest:request];//加载
        
    }else if (type == 1){
         [self setTitle:@"退换货标准"];
        NSURL *url = [NSURL URLWithString:@"http://xcxb.lxnong.com/share/index.html#/rulesreturn_and_exchange_standard_rule"];//创建URL
        NSURLRequest* request = [NSURLRequest requestWithURL:url];//创建
        [self.webView loadRequest:request];//加载
    }
}

@end
