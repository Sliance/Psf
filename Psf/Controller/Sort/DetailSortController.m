//
//  DetailSortController.m
//  Psf
//
//  Created by 燕来秋mac9 on 2018/6/28.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "DetailSortController.h"
#import "BaseDetailSortController.h"
#import "MenuInfo.h"
#import "StairCategoryRes.h"

@interface DetailSortController ()
@property (nonatomic, strong)  NSArray *menuList;
@property (nonatomic, assign)  BOOL autoSwitch;

@end

@implementation DetailSortController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    _autoSwitch = 0 != self.tabBarController.selectedIndex;
        self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
}
-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self setNavWithTitle:@"推荐"];
        
    }
    return self;
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
    static NSString *gridId = @"AllOrdersController";
    BaseDetailSortController *viewController;
    
        viewController = [magicView dequeueReusablePageWithIdentifier:gridId];
        if (!viewController) {
            viewController = [[BaseDetailSortController alloc] init];
        }
            return viewController;
}

#pragma mark - VTMagicViewDelegate
- (void)magicView:(VTMagicView *)magicView viewDidAppear:(__kindof UIViewController *)viewController atPage:(NSUInteger)pageIndex {
    _selectedIndex = pageIndex;
    StairCategoryRes *model = _dataArr[pageIndex];
    [viewController setModel:model];
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
-(void)setDataArr:(NSMutableArray *)dataArr{
    _dataArr = dataArr;
    StairCategoryRes *model = dataArr[_selectedIndex];
    [self setNavWithTitle:model.productCategoryName];
    [self generateTestData];
    [self.magicView reloadDataToPage:_selectedIndex];
}
#pragma mark - functional methods
- (void)generateTestData {
    NSString *title = @"推荐";
    NSMutableArray *menuList = [[NSMutableArray alloc] initWithCapacity:24];
    [menuList addObject:[MenuInfo menuInfoWithTitl:title]];
   
    [menuList removeAllObjects];
    for (int index = 0; index < _dataArr.count; index++) {
        StairCategoryRes *model = _dataArr[index];
        MenuInfo *menu = [MenuInfo menuInfoWithTitl:model.productCategoryName];
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
