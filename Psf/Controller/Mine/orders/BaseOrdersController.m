//
//  BaseOrdersController.m
//  Psf
//
//  Created by 燕来秋mac9 on 2018/6/27.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "BaseOrdersController.h"
#import "MenuInfo.h"
#import "AllOrdersController.h"
#import "WaitPaymentController.h"
#import "WaitDeliverController.h"
#import "WaitReceiveController.h"
#import "WaitEvaluateController.h"

@interface BaseOrdersController ()
@property (nonatomic, strong)  NSArray *menuList;
@property (nonatomic, assign)  BOOL autoSwitch;
@end

@implementation BaseOrdersController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    _autoSwitch = 0 != self.tabBarController.selectedIndex;
    self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.magicView.itemScale = 1;
    self.magicView.headerHeight = 30;
    self.magicView.navigationHeight = 30;
    self.magicView.againstStatusBar = NO;
    self.magicView.navigationInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.magicView.headerView.backgroundColor = [UIColor whiteColor];
    self.magicView.navigationColor = [UIColor whiteColor];
    self.magicView.layoutStyle = VTLayoutStyleDefault;
    self.magicView.sliderColor = DSColorMake(256, 76, 77);
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeAll;
    [self integrateComponents];
    [self configSeparatorView];
    
    [self addNotification];
    [self generateTestData];
    [self.magicView reloadData];
}
-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self setNavWithTitle:@"我的订单"];
       
    }
    return self;
}

-(void)setSelectedIndex:(NSInteger)selectedIndex{
    _selectedIndex = selectedIndex;
    [self.magicView reloadDataToPage:selectedIndex];
}
#pragma mark - NSNotification
- (void)addNotification {
    [self removeNotification];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(statusBarOrientationChange:)
                                                 name:UIApplicationDidChangeStatusBarOrientationNotification
                                               object:nil];
}

- (void)removeNotification {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];
}

- (void)statusBarOrientationChange:(NSNotification *)notification {
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:YES];
}

#pragma mark - VTMagicViewDataSource
- (NSArray<NSString *> *)menuTitlesForMagicView:(VTMagicView *)magicView {
    NSMutableArray *titleList = [NSMutableArray array];
    for (MenuInfo *menu in _menuList) {
        [titleList addObject:menu.title];
    }
    return titleList;
}

- (UIButton *)magicView:(VTMagicView *)magicView menuItemAtIndex:(NSUInteger)itemIndex {
    static NSString *itemIdentifier = @"itemIdentifier";
    
    UIButton *menuItem = [magicView dequeueReusableItemWithIdentifier:itemIdentifier];
    if (!menuItem) {
        menuItem = [UIButton buttonWithType:UIButtonTypeCustom];
        [menuItem setTitleColor:RGBCOLOR(69, 69, 69) forState:UIControlStateNormal];
        [menuItem setTitleColor:RGBCOLOR(256, 76, 77) forState:UIControlStateSelected];
        menuItem.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:15.f];
    }
    // 默认会自动完成赋值
    //    MenuInfo *menuInfo = _menuList[itemIndex];
    //    [menuItem setTitle:menuInfo.title forState:UIControlStateNormal];
    return menuItem;
}

- (UIViewController *)magicView:(VTMagicView *)magicView viewControllerAtPage:(NSUInteger)pageIndex {
   
   
    switch (pageIndex) {
        case 0:
        {
            
            static NSString *gridId = @"AllOrdersController";
            AllOrdersController *viewController = [magicView dequeueReusablePageWithIdentifier:gridId];
            if (!viewController) {
                viewController = [[AllOrdersController alloc] init];
            }
            [viewController setOrdertype:ORDERSTYPEAll];
            return viewController;
            
        }
            break;
        case 1:
        {
            static NSString *gridId = @"WaitPaymentController";
            WaitPaymentController *viewController = [magicView dequeueReusablePageWithIdentifier:gridId];
            if (!viewController) {
                viewController = [[WaitPaymentController alloc] init];
            }
             [viewController setOrdertype:ORDERSTYPEWaitPayment];
            return viewController;
            
        }
            break;
        case 2:
        {
            static NSString *gridId = @"WaitDeliverController";
            WaitDeliverController *viewController = [magicView dequeueReusablePageWithIdentifier:gridId];
            if (!viewController) {
                viewController = [[WaitDeliverController alloc] init];
            }
            [viewController setOrdertype:ORDERSTYPEWaitDeliver];
            return viewController;
        }
            break;
        case 3:
        {
            static NSString *gridId = @"WaitReceiveController";
            WaitReceiveController *viewController = [magicView dequeueReusablePageWithIdentifier:gridId];
            if (!viewController) {
                viewController = [[WaitReceiveController alloc] init];
            }
            [viewController setOrdertype:ORDERSTYPEWaitReceive];
            return viewController;
            
        }
            break;
       
        default:
            break;
    }
    static NSString *gridId = @"WaitEvaluateController";
    WaitEvaluateController *viewController = [magicView dequeueReusablePageWithIdentifier:gridId];
    if (!viewController) {
        viewController = [[WaitEvaluateController alloc] init];
    }
    [viewController setOrdertype:ORDERSTYPEWaitEvaluate];
    return viewController;
}

#pragma mark - VTMagicViewDelegate
- (void)magicView:(VTMagicView *)magicView viewDidAppear:(__kindof UIViewController *)viewController atPage:(NSUInteger)pageIndex {
    switch (pageIndex) {
        case 0:
        {
            
            [viewController setOrdertype:ORDERSTYPEAll];
            
        }
            break;
        case 1:
        {
            [viewController setOrdertype:ORDERSTYPEWaitPayment];
            
        }
            break;
        case 2:
        {
            
            [viewController setOrdertype:ORDERSTYPEWaitDeliver];
        }
            break;
        case 3:
        {
            [viewController setOrdertype:ORDERSTYPEWaitReceive];
            
        }
            break;
        case 4:
        {
            [viewController setOrdertype:ORDERSTYPEWaitEvaluate];
            
        }
            break;
        default:
            break;
    }
    
}

- (void)magicView:(VTMagicView *)magicView viewDidDisappear:(__kindof UIViewController *)viewController atPage:(NSUInteger)pageIndex {
    //    NSLog(@"index:%ld viewDidDisappear:%@", (long)pageIndex, viewController.view);
}

- (void)magicView:(VTMagicView *)magicView didSelectItemAtIndex:(NSUInteger)itemIndex {

    
}
- (void)switchToPage:(NSUInteger)pageIndex animated:(BOOL)animated {
    [self.magicView switchToPage:self.currentPage animated:animated];
}
#pragma mark - actions
- (void)subscribeAction {
    NSLog(@"subscribeAction");
    // against status bar or not
    //    self.magicView.againstStatusBar = !self.magicView.againstStatusBar;
    [self.magicView setHeaderHidden:!self.magicView.isHeaderHidden duration:0.35];
}

#pragma mark - functional methods
- (void)generateTestData {
    NSString *title = @"推荐";
    NSMutableArray *menuList = [[NSMutableArray alloc] initWithCapacity:24];
    [menuList addObject:[MenuInfo menuInfoWithTitl:title]];
    NSArray *arr = @[@"全部",@"待付款",@"待发货",@"待收货",@"待评价"];
    [menuList removeAllObjects];
    for (int index = 0; index < arr.count; index++) {
        title = arr[index];
        MenuInfo *menu = [MenuInfo menuInfoWithTitl:title];
        [menuList addObject:menu];
    }
    
    _menuList = menuList;
}

- (void)integrateComponents {
    UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
    [rightButton addTarget:self action:@selector(subscribeAction) forControlEvents:UIControlEventTouchUpInside];
    [rightButton setTitleColor:RGBCOLOR(256, 76, 77) forState:UIControlStateSelected];
    [rightButton setTitleColor:RGBCOLOR(256, 76, 77) forState:UIControlStateNormal];
    [rightButton setTitle:@">" forState:UIControlStateNormal];
    rightButton.titleLabel.font = [UIFont boldSystemFontOfSize:28];
    rightButton.center = self.view.center;
//    self.magicView.rightNavigatoinItem = rightButton;
    
}

- (void)configSeparatorView {
    //    UIImageView *separatorView = [[UIImageView alloc] init];
    //    [self.magicView setSeparatorView:separatorView];
    self.magicView.separatorHeight = 2.f;
    self.magicView.separatorColor = RGBCOLOR(256, 76, 77);
    self.magicView.navigationView.layer.shadowColor = [UIColor whiteColor].CGColor;
    self.magicView.navigationView.layer.shadowOffset = CGSizeMake(0, 0.5);
    self.magicView.navigationView.layer.shadowOpacity = 0.8;
    self.magicView.navigationView.clipsToBounds = NO;
    
    
}


- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
