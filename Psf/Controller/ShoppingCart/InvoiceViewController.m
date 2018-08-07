//
//  InvoiceViewController.m
//  Psf
//
//  Created by 燕来秋mac9 on 2018/8/6.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "InvoiceViewController.h"

@interface InvoiceViewController ()<UIScrollViewDelegate>
@property(nonatomic,strong)UIScrollView *bgscrollow;
@property(nonatomic,strong)UIView *bgview;
@property(nonatomic,assign)NSInteger type;

@end

@implementation InvoiceViewController
-(UIScrollView *)bgscrollow{
    if (!_bgscrollow) {
        _bgscrollow = [[UIScrollView alloc]init];
        _bgscrollow.delegate =self;
        _bgscrollow.frame = CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT);
    }
    return _bgscrollow;
}
-(UIView *)bgview{
    if (!_bgview) {
        _bgview = [[UIView alloc]init];
        _bgview.frame = CGRectMake(0, 0, SCREENWIDTH, 132);
    }
    return _bgview;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.bgscrollow];
    [self.bgscrollow addSubview:self.bgview];
   
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
