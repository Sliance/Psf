//
//  BaseViewController.h
//  Psf
//
//  Created by 燕来秋mac9 on 2018/6/14.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZSConfig.h"
#import "AppDelegate.h"
#import "NavgationView.h"
#import "UIViewController+Loading.h"

typedef void (^LoginComplited) (void);
typedef void(^refreshListBlock)(void);
typedef void(^scrollToTopBlcok)(void);

@interface BaseViewController : UIViewController<NavgationViewDelegate>
@property (nonatomic, strong) LoginComplited loginComplitedBlock;
- (void)adjustNavigationUI:(UINavigationController *) nav;
- (void)doLogin;
- (void)showToast:(NSString *)info;

- (void)setRightButtonWithTitle:(NSString *) title;
- (void)setNavWithTitle:(NSString *) navtitle;
- (void)setRightButtonWithIcon:(UIImage *) image;
- (void)setLeftButtonWithIcon:(UIImage *) image;
- (void)setLeftButtonWithTitle:(NSString *) title;
- (void)didRightClick;
- (void)didLeftClick;

- (void)showViewBottom:(UIView *) view;
- (void)hiddenBottomView;

/**在屏幕中央弹出一个view*/
- (void)popView:(UIView *)view withOffset:(CGFloat) offset;
- (void)hidPopView;

- (void)doCheckLogin:(LoginComplited) complited;
- (void)doCheckSupplier:(LoginComplited) complited;

//点击弹出框背景消失 需要做的逻辑处理 子类实现此方法
- (void)hiddenPopViewWithDoOtherThing;

- (void)showSuspension:(refreshListBlock)refreshBlock and:(scrollToTopBlcok)scrollToTopBlck;//列表添加悬浮窗

- (void)showToTopButtonWith:(CGPoint)contentOffset;

-(void)loginOutSelector;

//重新设置app数据
- (void)reloginApp;

@property(nonatomic,strong)NavgationView *navView;
@property(nonatomic,strong)UIButton *backBtn;
-(void)setTextFieldLeftView:(UITextField *)textField :(NSString *)imgStr :(NSInteger)width;

-(CGFloat)navHeightWithHeight;
-(CGFloat)tabBarHeight;

@end
