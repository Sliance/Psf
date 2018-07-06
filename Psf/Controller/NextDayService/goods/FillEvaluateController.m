//
//  FillEvaluateController.m
//  Psf
//
//  Created by 燕来秋mac9 on 2018/7/5.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "FillEvaluateController.h"
#import "FillEvaluateHwadView.h"
@interface FillEvaluateController ()<UIScrollViewDelegate>
@property(nonatomic,strong)UIScrollView *bgscrollow;
@property(nonatomic,strong)FillEvaluateHwadView *headView;
@end

@implementation FillEvaluateController
-(UIScrollView *)bgscrollow{
    if (!_bgscrollow) {
        _bgscrollow = [[UIScrollView alloc]init];
        _bgscrollow.delegate = self;
        _bgscrollow.frame = CGRectMake(0, [self navHeightWithHeight], SCREENWIDTH, SCREENHEIGHT);
        _bgscrollow.backgroundColor = DSColorFromHex(0xF0F0F0);
    }
    return _bgscrollow;
}
-(FillEvaluateHwadView *)headView{
    if (!_headView) {
        _headView = [[FillEvaluateHwadView alloc]initWithFrame:CGRectMake(0, 5, SCREENWIDTH, 260)];
        
    }
    return _headView;
    
}
-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self setNavWithTitle:@"评价"];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.bgscrollow];
    [self.bgscrollow addSubview:self.headView];
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
