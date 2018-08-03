//
//  ZYProGressView.m
//  ProgressBar
//
//  Created by Apple on 2017/4/12.
//  Copyright © 2017年 Apple. All rights reserved.
//

#import "ZYProGressView.h"

@interface ZYProGressView()

@property(nonatomic,strong)UIView *viewTop;
@property(nonatomic,strong)UIView *viewBottom;
@end
@implementation ZYProGressView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        
        [self buildUI];
        
    }
    return self;
}
-(UIView *)viewBottom{
    if (!_viewBottom) {
        _viewBottom = [[UIView alloc]initWithFrame:CGRectMake(self.bounds.origin.x, self.bounds.size.height/4, self.bounds.size.width, self.bounds.size.height/2)];
        _viewBottom.backgroundColor = [UIColor grayColor];
        _viewBottom.layer.cornerRadius = 3;
        _viewBottom.layer.masksToBounds = YES;
    }
    return _viewBottom;
}
-(UIView *)viewTop{
    if (!_viewTop) {
        _viewTop = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, self.viewBottom.frame.size.height)];
        _viewTop.backgroundColor = [UIColor redColor];
        _viewTop.layer.cornerRadius = 3;
        _viewTop.layer.masksToBounds = YES;
    }
    return _viewTop;
}
-(UILabel *)percentView{
    if (!_percentView) {
        _percentView =[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 45, 18)];
        _percentView.backgroundColor = [UIColor redColor];
        _percentView.layer.cornerRadius = 9;
        _percentView.textAlignment = NSTextAlignmentCenter;
        _percentView.textColor = [UIColor whiteColor];
        _percentView.font = [UIFont systemFontOfSize:12];
        _percentView.layer.masksToBounds = YES;
    }
    return _percentView;
}
- (void)buildUI
{
    
    [self addSubview:self.viewBottom];
    [self.viewBottom addSubview:self.viewTop];
    [self addSubview:self.percentView];
}


-(void)setTime:(float)time
{
    _time = time;
}
-(void)setProgressValue:(NSString *)progressValue
{
    if (!_time) {
        _time = 3.0f;
    }
    _progressValue = progressValue;
    self.percentView.text = [NSString stringWithFormat:@"%.0f%%",progressValue.floatValue*100];
    __weak typeof(self)weakself = self;
    [UIView animateWithDuration:_time animations:^{
        self.viewTop.frame = CGRectMake(self.viewTop.frame.origin.x,0, self.viewBottom.frame.size.width*[progressValue floatValue], self.viewTop.frame.size.height);
        if ([progressValue floatValue]>1) {
            weakself.percentView.frame = CGRectMake(self.viewBottom.frame.size.width-45,  0, 45, 18);
        }else if(self.viewBottom.frame.size.width*[progressValue floatValue]<45){
          weakself.percentView.frame = CGRectMake(0,0, 45, 18);
        }else{
            weakself.percentView.frame = CGRectMake(self.viewBottom.frame.size.width*[progressValue floatValue]-45,  0, 45, 18);
        }
    }];
}


-(void)setBottomColor:(UIColor *)bottomColor
{
    _bottomColor = bottomColor;
    self.viewBottom.backgroundColor = bottomColor;
}

-(void)setProgressColor:(UIColor *)progressColor
{
    _progressColor = progressColor;
    self.viewTop.backgroundColor = progressColor;
    _percentView.backgroundColor = progressColor;
}












@end
