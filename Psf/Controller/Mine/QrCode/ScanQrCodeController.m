//
//  ScanQrCodeController.m
//  Psf
//
//  Created by 燕来秋mac9 on 2018/8/21.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "ScanQrCodeController.h"
#import <AVFoundation/AVFoundation.h>
#import <SVProgressHUD.h>
#import "OrderDetailViewController.h"

@interface ScanQrCodeController ()<AVCaptureMetadataOutputObjectsDelegate,CALayerDelegate>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scanViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scanViewWidth;
/** 扫描二维码范围的view */
@property (weak, nonatomic) IBOutlet UIView *scanView;
/** 存放扫描结果的label */
@property (weak, nonatomic) IBOutlet UILabel *scanResult;

/** 扫描的线 */
@property (nonatomic,strong) UIImageView *scanImageView;

@property ( strong , nonatomic ) AVCaptureDevice * device;

@property ( strong , nonatomic ) AVCaptureDeviceInput * input;

@property ( strong , nonatomic ) AVCaptureMetadataOutput * output;

@property ( strong , nonatomic ) AVCaptureSession * session;

@property ( strong , nonatomic ) AVCaptureVideoPreviewLayer * preview;

/** 非扫描区域的蒙版 */
@property (nonatomic,strong) CALayer *maskLayer;

@end

@implementation ScanQrCodeController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置扫描二维码
    [self setupScanQRCode];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // 添加扫描线以及开启扫描线的动画
    [self startAnimate];
    
    // 开启二维码扫描
    [_session startRunning];
}

- (void)dealloc{
    // 删除预览图层
    if (_preview) {
        [_preview removeFromSuperlayer];
    }
    if (self.maskLayer) {
        self.maskLayer.delegate = nil;
    }
}
#pragma mark - <lazy - 懒加载>
/**
 *  懒加载设备
 */
- (AVCaptureDevice *)device {
    if (!_device) {
        _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    }
    return _device;
}

/**
 *  懒加输入源
 */
- (AVCaptureDeviceInput *)input {
    if (!_input) {
        _input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:nil];
    }
    return _input;
}

/**
 *  懒加载输出源
 */
- (AVCaptureMetadataOutput *)output {
    if (!_output) {
        _output = [[AVCaptureMetadataOutput alloc] init];
        [_output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
        
    }
    return _output;
}

/**
 *  添加扫描线以及开启扫描线的动画
 */
- (void)startAnimate {
    CGFloat scanImageViewX = self.scanView.frame.origin.x;
    CGFloat scanImageViewY = self.scanView.frame.origin.y;
    CGFloat scanImageViewW = self.scanViewWidth.constant;
    CGFloat scanImageViewH = 7;
    
    _scanImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"scanLine"]];
    _scanImageView.frame = CGRectMake(scanImageViewX, scanImageViewY, scanImageViewW, scanImageViewH);
    [self.view addSubview:_scanImageView];
    __weak typeof(self)weakself = self;
    [UIView animateWithDuration:2.0 delay:0 options:UIViewAnimationOptionRepeat animations:^{
        weakself.scanImageView.frame = CGRectMake(scanImageViewX, scanImageViewY + self.scanViewHeight.constant, scanImageViewW, scanImageViewH);
    } completion:nil];
}

/**
 *  设置扫描二维码
 */
- (void)setupScanQRCode {
    // 1、创建设备会话对象，用来设置设备数据输入
    _session = [[AVCaptureSession alloc] init];
    [_session setSessionPreset: AVCaptureSessionPresetHigh];    //高质量采集
    
    if ([_session canAddInput:self.input]) {
        [_session addInput:self.input];
    }
    if ([_session canAddOutput:self.output]) {
        [_session addOutput:self.output];
    }
    // 设置条码类型为二维码
    [self.output setMetadataObjectTypes:self.output.availableMetadataObjectTypes];
    
    // 设置扫描范围
    [self setOutputInterest];
    
    // 3、实时获取摄像头原始数据显示在屏幕上
    _preview = [AVCaptureVideoPreviewLayer layerWithSession:_session];
    _preview.videoGravity = AVLayerVideoGravityResizeAspectFill;
    _preview.frame = self.view.layer.bounds;
    self.view.layer.backgroundColor = [[UIColor blackColor] CGColor];
    [self.view.layer insertSublayer:_preview atIndex:0];
    
    self.maskLayer = [[CALayer alloc]init];
    self.maskLayer.frame = self.view.layer.bounds;
    self.maskLayer.delegate = self;
    [self.view.layer insertSublayer:self.maskLayer above:_preview];
    [self.maskLayer setNeedsDisplay];
}

/**
 *  设置二维码的扫描范围
 */
- (void)setOutputInterest {
    CGSize size = self.view.bounds.size;
    CGFloat scanViewWidth = 240;
    CGFloat scanViewHeight = 240;
    CGFloat scanViewX = (size.width - scanViewWidth) / 2;
    CGFloat scanViewY = (size.height - scanViewHeight) / 2;
    CGFloat p1 = size.height/size.width;
    CGFloat p2 = 1920./1080.; //使用了1080p的图像输出
    if (p1 < p2) {
        CGFloat fixHeight = self.view.bounds.size.width * 1920. / 1080.;
        CGFloat fixPadding = (fixHeight - size.height)/2;
        _output.rectOfInterest = CGRectMake((scanViewY + fixPadding) / fixHeight,
                                            scanViewX / size.width,
                                            scanViewHeight / fixHeight,
                                            scanViewWidth / size.width);
    } else {
        CGFloat fixWidth = self.view.bounds.size.height * 1080. / 1920.;
        CGFloat fixPadding = (fixWidth - size.width)/2;
        _output.rectOfInterest = CGRectMake(scanViewY / size.height,
                                            (scanViewX + fixPadding) / fixWidth,
                                            scanViewHeight / size.height,
                                            scanViewWidth / fixWidth);
    }
}

#pragma mark - <AVCaptureMetadataOutputObjectsDelegate - 扫描二维码的回调方法>
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection {
    NSString *stringValue;
    
    // 显示遮盖
    [SVProgressHUD show];
    
    if ([metadataObjects count ] > 0 ) {
        // 当扫描到数据时，停止扫描
        [ _session stopRunning ];
        
        // 将扫描的线从父控件中移除
        [_scanImageView removeFromSuperview];
        
        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex : 0 ];
        
        stringValue = metadataObject. stringValue ;
    }
    // 当前延迟1.0秒
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 隐藏遮盖
        [SVProgressHUD dismiss];
        
        // 将扫描后的结果显示在label上
        self.scanResult.text = stringValue;
        NSMutableDictionary *result = [stringValue mj_JSONObject];
        OrderListRes *model = [[OrderListRes alloc]init];
        model.saleOrderId = result[@"saleOrderId"];
        OrderDetailViewController *orderVC = [[OrderDetailViewController alloc]init];
        [orderVC setModel:model];
        [self.navigationController pushViewController:orderVC animated:YES];
    });
}

#pragma mark - <CALayerDelegate - 图层的代理方法>
/**
 *   蒙板生成,需设置代理，并在退出页面时取消代理
 */
-(void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx{
    if (layer == self.maskLayer) {
        UIGraphicsBeginImageContextWithOptions(self.maskLayer.frame.size, NO, 1.0);
        CGContextSetFillColorWithColor(ctx, [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6].CGColor);
        CGContextFillRect(ctx, self.maskLayer.frame);
        CGRect scanFrame = [self.view convertRect:self.scanView.frame fromView:self.scanView.superview];
        CGContextClearRect(ctx, scanFrame);
    }
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
