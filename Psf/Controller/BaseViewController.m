//
//  BaseViewController.m
//  Psf
//
//  Created by 燕来秋mac9 on 2018/6/14.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()
@property (nonatomic, strong) UIControl *controlPopBottom;
@property (nonatomic, strong) UIControl *controlPop;
@property (nonatomic, strong) UIView *suspensionView;//悬浮窗背景
@property (nonatomic, copy) refreshListBlock refreshMsg;
@property (nonatomic, copy) scrollToTopBlcok scrollMsg;

@end

@implementation BaseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        
        self.view.backgroundColor = DSColorFromHex(0xF0F0F0);
        
        [self adjustNavigationUI:self.navigationController];
        
    }
    return self;
}


-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    [self adjustNavigationUI:self.navigationController];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initBaseUI];
    //获取通知中心单例对象
    NSNotificationCenter * center = [NSNotificationCenter defaultCenter];
    //添加当前类对象为一个观察者，name和object设置为nil，表示接收一切通知
//    [center addObserver:self selector:@selector(loginOutSelector) name:LogOutNotificationCenter object:nil];
    
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self adjustNavigationUI:self.navigationController];
    [self setLeftButtonWithIcon:[UIImage imageNamed:@"icon_back"]];
   
    
//    self.navigationController.navigationBar.translucent = YES;
}

- (void)adjustNavigationUI:(UINavigationController *) nav {
    [[UINavigationBar appearance] setBarTintColor:DSNavi];
    [[UINavigationBar appearance] setTintColor:[UIColor blackColor]];
    [[UINavigationBar appearance] setBackIndicatorImage:[UIImage imageNamed:@"icon_back"]];
    [[UINavigationBar appearance] setBackIndicatorTransitionMaskImage:[UIImage imageNamed:@"icon_back"]];
    NSShadow *shadow = [[NSShadow alloc] init];
    [[UINavigationBar appearance] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:
                                                           DSColorFromHex(0x474747), NSForegroundColorAttributeName,
                                                           shadow, NSShadowAttributeName,
                                                           [UIFont systemFontOfSize:18], NSFontAttributeName, nil]];
    //去掉返回按钮上的字
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, 0)
                                                         forBarMetrics:UIBarMetricsDefault];
    [UIBarButtonItem appearance].tintColor = [UIColor lightGrayColor];
    NSArray *viewControllerArray = [self.navigationController viewControllers];
    long previousViewControllerIndex = [viewControllerArray indexOfObject:self] - 1;
    UIViewController *previous;
    if (previousViewControllerIndex >= 0&&previousViewControllerIndex<= viewControllerArray.count) {
        previous            = [viewControllerArray objectAtIndex:previousViewControllerIndex];
        previous.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]
                                                     initWithTitle:@" "
                                                     style:UIBarButtonItemStylePlain
                                                     target:self
                                                     action:nil];
    }
    [self.navigationController.navigationBar setBackgroundImage:[self imageWithColor:[UIColor whiteColor] size:CGSizeMake(SCREENWIDTH, [self navHeightWithHeight])] forBarMetrics:UIBarMetricsDefault];
   
    [[UINavigationBar appearance] setShadowImage:[self imageWithColor:DSColorFromHex(0xF0F0F0) size:CGSizeMake([UIScreen mainScreen].bounds.size.width, 0.5)]];
    
  
    
}
#pragma mark - public methods
- (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size {
    if (!color || size.width <= 0 || size.height <= 0) return nil;
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


- (void)showToast:(NSString *)info {
    [self showInfo:info];
}
/**
 显示提示
 */
- (void)showInfo:(NSString *)info{
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:window animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.userInteractionEnabled = NO;
    hud.label.text = info;
    hud.yOffset = -85;
    [hud hide:YES afterDelay:3];
}



- (void)initBaseUI {
    [self setTitle:@"犁小农"];
}
-(void)setNavWithTitle:(NSString *)navtitle{
    UILabel *navlabel = [[UILabel alloc]init];
    navlabel.textAlignment = NSTextAlignmentCenter;
    navlabel.textColor = DSColorFromHex(0x474747);
    navlabel.font = [UIFont systemFontOfSize:18];
    navlabel.text = navtitle;
//     self.navigationItem.titleView = navlabel;
}
- (void)setRightButtonWithTitle:(NSString *) title  {
    UIBarButtonItem *rightBar = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStylePlain target:self action:@selector(didRightClick)];
    [rightBar setTintColor:[UIColor whiteColor]];
    [rightBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} forState:UIControlStateNormal];
    [rightBar setTitlePositionAdjustment:UIOffsetMake(-10, 0) forBarMetrics:UIBarMetricsDefault];
    [self.navigationItem setRightBarButtonItem:rightBar];
    [self adjustNavigationUI:self.navigationController];
}

- (void)setRightButtonWithIcon:(UIImage *) image {
    UIBarButtonItem *rightBar = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStyleDone target:self action:@selector(didRightClick)];
    [self.navigationItem setRightBarButtonItem:rightBar];
    [self adjustNavigationUI:self.navigationController];
    
}

- (void)setLeftButtonWithIcon:(UIImage *) image {
    UIBarButtonItem *leftBar = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStyleDone target:self action:@selector(didLeftClick)];
    [self.navigationItem setLeftBarButtonItem:leftBar];
    [leftBar setTintColor:[UIColor lightGrayColor]];
    [self adjustNavigationUI:self.navigationController];
}

- (void)setLeftButtonWithTitle:(NSString *) title  {
    UIBarButtonItem *leftBar = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStylePlain target:self action:@selector(didLeftClick)];
    [leftBar setTintColor:[UIColor grayColor]];
    [leftBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} forState:UIControlStateNormal];
    [leftBar setTitlePositionAdjustment:UIOffsetMake(10, 0) forBarMetrics:UIBarMetricsDefault];
    [self.navigationItem setLeftBarButtonItem:leftBar];
    [self adjustNavigationUI:self.navigationController];
}

- (void)didRightClick {
    
}

- (void)didLeftClick {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)doLogin {
//    LoginViewController *controller = [[LoginViewController alloc] init];
//    [self.navigationController pushViewController:controller animated:YES];
}

- (void)doCheckLogin:(LoginComplited) complited {
//    if ([[UserCacheBean share] isLogin]) {
//        if (complited) {
//            complited();
//        }
//        return;
//    }
//    LoginViewController *controller = [[LoginViewController alloc] init];
//    controller.loginComplitedBlock = complited;
//    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:controller];
//    [self presentViewController:nav animated:YES completion:nil];
}

- (void)doCheckSupplier:(LoginComplited) complited {
//    if ([[UserCacheBean share] isSupplier]) {
//        if (complited) {
//            complited();
//        }
//        return;
//    }
//    ChechAgentEnterViewController *controller = [[ChechAgentEnterViewController alloc] init];
//    controller.loginComplitedBlock = complited;
//    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:controller];
//    [self presentViewController:nav animated:YES completion:nil];
}

- (void)showViewBottom:(UIView *) view {
//    view.frame = CGRectMake(0, SCREENHEIGHT, SCREENWIDTH, view.ctHeight);
//    self.controlPopBottom = [[UIControl alloc] initWithFrame:[UIScreen mainScreen].bounds];
//    self.controlPopBottom.backgroundColor = DSColorAlphaMake(0, 0, 0, 0.2);
//    [self.controlPopBottom addTarget:self action:@selector(didClickCancel:) forControlEvents:UIControlEventTouchDown];
//    [self.controlPopBottom addSubview:view];
//    NSDictionary *dic = @{@"view":view, @"type":@1};
//    [self.controlPopBottom setObjectDSValue:dic];
//    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
//    [window addSubview:self.controlPopBottom];
//
//    [UIView animateWithDuration:0.3 animations:^{
//        view.frame = CGRectMake(0, SCREENHEIGHT - view.ctHeight, SCREENWIDTH, view.ctHeight);
//    } completion:^(BOOL finished) {
//
//    }];
}

- (void)hiddenBottomView {
//    NSDictionary *dicView = self.controlPopBottom.objectDSValue;
//    UIView *view = dicView[@"view"];
//    [UIView animateWithDuration:0.3 animations:^{
//        view.frame = CGRectMake(0, SCREENHEIGHT , view.ctWidth, view.ctHeight);
//    } completion:^(BOOL finished) {
//        [view removeFromSuperview];
//        [view.layer removeAllAnimations];
//        self.controlPopBottom.backgroundColor = [UIColor clearColor];
//        [self.controlPopBottom removeFromSuperview];
//        self.controlPopBottom = nil;
//    }];
}


- (void)popView:(UIView *)view withOffset:(CGFloat) offset {
//    self.controlPop = [[UIControl alloc] initWithFrame:[UIScreen mainScreen].bounds];
//    self.controlPop.backgroundColor = DSColorAlphaMake(0, 0, 0, 0.5);
//    [self.controlPop addTarget:self action:@selector(didClickCancel:) forControlEvents:UIControlEventTouchDown];
//    [self.controlPop addSubview:view];
//    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
//    [window addSubview:self.controlPop];
//
//    CGRect frame = CGRectMake((SCREENWIDTH - view.ctWidth) / 2, (SCREENHEIGHT - view.ctHeight)/2 - offset, view.ctWidth, view.ctHeight);
//    //    view.frame = CGRectMake(0, 0, SCREENWIDTH, 0);
//    POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
//    anim.fromValue = [NSValue valueWithCGRect:frame];
//    anim.toValue = [NSValue valueWithCGRect:frame];
//    [view.layer pop_addAnimation:anim forKey:@"size"];
//    //传递数据
//    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
//    [dic setValue:anim.toValue forKey:@"toValue"];
//    [dic setValue:anim.fromValue forKey:@"fromValue"];
//    [dic setValue:view forKey:@"view"];
//    [dic setValue:@2 forKey:@"type"];
//    [self.controlPop setObjectDSValue:dic];
}

- (void)hidPopView {
//    NSDictionary *dic = (NSDictionary *)self.controlPop.objectDSValue;
//    if ([dic[@"type"] integerValue] == 1) {
//        UIView *view = dic[@"view"];
//        [UIView animateWithDuration:0.3 animations:^{
//            view.frame = CGRectMake(0, SCREENHEIGHT , view.ctWidth, view.ctHeight);
//        } completion:^(BOOL finished) {
//            [view removeFromSuperview];
//            [view.layer removeAllAnimations];
//            self.controlPop.backgroundColor = [UIColor clearColor];
//            [self.controlPop removeFromSuperview];
//            self.controlPop = nil;
//        }];
//    } else {
//        UIView *view = dic[@"view"];
//        [view.layer removeAllAnimations];
//        self.controlPop.backgroundColor = [UIColor clearColor];
//        [self.controlPop removeFromSuperview];
//        self.controlPop = nil;
//    }
}

- (void)didClickCancel:(UIControl *)control {
    if (self.controlPop != nil) {
        [self hiddenPopViewWithDoOtherThing];
        [self hidPopView];
    } else {
        [self hiddenBottomView];
    }
}

- (void)hiddenPopViewWithDoOtherThing{
    
}

- (UIView *)suspensionView{
    if (_suspensionView == nil) {
        _suspensionView = [[UIView alloc] init];
        UIButton *refeshButton = [UIButton buttonWithType:UIButtonTypeCustom];
        refeshButton.frame = CGRectMake(0, 0, 36, 36);
        [refeshButton setImage:[UIImage imageNamed:@"icon_suspension_refresh"] forState:UIControlStateNormal];
        [refeshButton addTarget:self action:@selector(refreshList) forControlEvents:UIControlEventTouchUpInside];
        [_suspensionView addSubview:refeshButton];
        
        UIButton *scrollButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [scrollButton setImage:[UIImage imageNamed:@"icon_suspension_toTop"] forState:UIControlStateNormal];
        scrollButton.tag = 100;
        scrollButton.hidden = YES;
        [scrollButton addTarget:self action:@selector(scrollToTop) forControlEvents:UIControlEventTouchUpInside];
        scrollButton.frame = CGRectMake(0, 46, 36, 36);
        [_suspensionView addSubview:scrollButton];
        _suspensionView.hidden = YES;
    }
    return _suspensionView;
}

- (void)refreshList{
    if (self.refreshMsg) {
        self.refreshMsg();
    }
}

- (void)scrollToTop{
    if (self.scrollMsg) {
        self.scrollMsg();
    }
}

- (void)showSuspension:(refreshListBlock)refreshBlock and:(scrollToTopBlcok)scrollToTopBlck{
    [self.view addSubview:self.suspensionView];
    self.suspensionView.hidden = YES;
    //    self.suspensionView.frame = CGRectMake(SCREENWIDTH - 20 - 36, SCREENHEIGHT - 300, 36, 82);
    float suspensionHeght = -60;
    if (SCREENHEIGHT > 800) {
        suspensionHeght = -100;
    }
    
//    [self.suspensionView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo (self.view.mas_right).offset(-20);
//        make.bottom. equalTo (self.view.mas_bottom).offset(suspensionHeght);
//        make.width. equalTo (@(36));
//        make.height. equalTo (@(82));
//    }];
    [self.view bringSubviewToFront:self.suspensionView];
    self.refreshMsg = refreshBlock;
    self.scrollMsg = scrollToTopBlck;
}

- (void)showToTopButtonWith:(CGPoint)contentOffset{
    
    UIButton * toTopBtn = (UIButton *)[self.suspensionView viewWithTag:100];
    if (contentOffset.y > 0) {
        toTopBtn.hidden = NO;
    } else {
        toTopBtn.hidden = YES;
    }
    CATransition *transition = [CATransition animation];
    transition.duration = 0.5f;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [transition setType:kCATransitionFade];
    [toTopBtn.layer addAnimation:transition forKey:nil];
}
//退出登录的通知方法
-(void)loginOutSelector{
    NSLog(@">>>>>>>>>>>>>退出成功<<<<<<<<<<<<<");
}

- (void)reloginApp{
    AppDelegate *appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    NSInteger index = appDelegate.mainTabController.selectedIndex;
    appDelegate.mainTabController = nil;
    appDelegate.mainTabController = [[PsfTabBarController alloc] init];
    appDelegate.mainTabController.selectedIndex = index;
    appDelegate.window.rootViewController = appDelegate.mainTabController;
}

-(CGFloat)navHeightWithHeight{
    if(SCREENHEIGHT == 812){
        return  88
        ;
    }else{
        return 64;
    }
}
-(CGFloat)tabBarHeight{
    if(SCREENHEIGHT == 812){
        return  83;
    }else{
        return 49;
    }
}
-(void)setTextFieldLeftView:(UITextField *)textField :(NSString *)imgStr :(NSInteger)width{
    UIImageView *LeftViewNum = [[UIImageView alloc]initWithImage:[UIImage imageNamed:imgStr]];
    //图片的显示模式
    LeftViewNum.contentMode= UIViewContentModeCenter;
    //图片的位置和大小
    LeftViewNum.frame= CGRectMake(10,0,width,30);
    //左视图默认是不显示的 设置为始终显示
    textField.leftViewMode= UITextFieldViewModeAlways;
    textField.leftView= LeftViewNum;
    
}
@end
