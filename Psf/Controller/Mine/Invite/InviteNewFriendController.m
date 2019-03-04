//
//  InviteNewFriendController.m
//  Psf
//
//  Created by zhangshu on 2019/2/26.
//  Copyright © 2019 zhangshu. All rights reserved.
//

#import "InviteNewFriendController.h"
#import "WXApiObject.h"
#import "WXApi.h"
#import "CustomJSObject.h"
@interface InviteNewFriendController ()<UIWebViewDelegate,JSProtocol>
@property(nonatomic,strong)UIWebView *webView;
@property (nonatomic, strong) JSContext *context;

@end

@implementation InviteNewFriendController


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
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://xcxb.lxnong.com/share/index.html#/coupon%@",[UserCacheBean share].userInfo.token]];//创建URL
    NSURLRequest* request = [NSURLRequest requestWithURL:url];//创建
    [self.webView loadRequest:request];//加载
    NSString *str = [self.webView stringByEvaluatingJavaScriptFromString:@"canvasdom"];
    NSLog(@"######%@",str);
}
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    NSString *str = [self.webView stringByEvaluatingJavaScriptFromString:@"canvasdom"];
    NSLog(@"######%@",str);
    //2.iOS监听vue的函数
    JSContext *context = [self.webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    //定义好JS要调用的方法, share就是调用的share方法名
    context[@"share"] = ^() {
        dispatch_async(dispatch_get_main_queue(), ^{
            WXMediaMessage *message = [WXMediaMessage message];
            message.title = @"邀请新人领优惠券";
            NSData *data = [NSData dataWithHexString:@"11111"];
            message.thumbData = data;
            message.description = @"";
            [message setThumbImage:[UIImage imageNamed:@"qr_icon"]];
            WXWebpageObject *webpage = [WXWebpageObject object];
            NSString*url =[NSString stringWithFormat:@"http://xcxb.lxnong.com/share/index.html#/memberCoupon%@",[UserCacheBean share].userInfo.token];
            webpage.webpageUrl = url;
            message.mediaObject = webpage;
            SendMessageToWXReq *req = [[SendMessageToWXReq alloc]init];
            req.bText = NO;
            req.message = message;
            req.scene = WXSceneSession;
            [WXApi sendReq:req];
        });
    };
    context[@"shareCircle"] = ^() {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            WXMediaMessage *message = [WXMediaMessage message];
            message.title = @"邀请新人领取优惠券";
            NSData *data = [NSData dataWithHexString:@"11111"];
            message.thumbData = data;
            message.description = @"";
            [message setThumbImage:[UIImage imageNamed:@"qr_icon"]];
            WXWebpageObject *webpage = [WXWebpageObject object];
            NSString*url =[NSString stringWithFormat:@"http://xcxb.lxnong.com/share/index.html#/memberCoupon%@",[UserCacheBean share].userInfo.token];
            webpage.webpageUrl = url;
            message.mediaObject = webpage;
            SendMessageToWXReq *req = [[SendMessageToWXReq alloc]init];
            req.bText = NO;
            req.message = message;
            req.scene = WXSceneTimeline;
            [WXApi sendReq:req];
        });
    };
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
  NSString *str = [self.webView stringByEvaluatingJavaScriptFromString:@"canvasdom"];
    NSLog(@"######%@",str);
    NSLog(@"urlString---%@",request.URL.absoluteString);
    NSLog(@"urlScheme---%@",request.URL.scheme);
    return YES;
}

#pragma mark - js
-(void)testJS{
    NSLog(@"%s,%zd",__FUNCTION__,__LINE__);
}

-(void)shareTitle:(NSString *)title Desc:(NSString *)desc{
    NSLog(@"title--%@--desc---%@",title,desc);
}
@end
