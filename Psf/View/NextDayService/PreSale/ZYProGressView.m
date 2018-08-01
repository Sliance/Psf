//
//  ZYProGressView.m
//  ProgressBar
//
//  Created by Apple on 2017/4/12.
//  Copyright © 2017年 Apple. All rights reserved.
//

#import "ZYProGressView.h"

@interface ZYProGressView()
{
    UIView *viewTop;
    UIView *viewBottom;
    
}

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

- (void)buildUI
{
    
    viewBottom = [[UIView alloc]initWithFrame:CGRectMake(self.bounds.origin.x, self.bounds.size.height/4, self.bounds.size.width, self.bounds.size.height/2)];
    viewBottom.backgroundColor = [UIColor grayColor];
    viewBottom.layer.cornerRadius = 3;
    viewBottom.layer.masksToBounds = YES;
    [self addSubview:viewBottom];
    
    
    viewTop = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, viewBottom.frame.size.height)];
    viewTop.backgroundColor = [UIColor redColor];
    viewTop.layer.cornerRadius = 3;
    viewTop.layer.masksToBounds = YES;
    [viewBottom addSubview:viewTop];
    
    _percentView =[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 0, self.bounds.size.height)];
    _percentView.backgroundColor = [UIColor redColor];
    _percentView.layer.cornerRadius = 9;
    _percentView.textAlignment = NSTextAlignmentCenter;
    _percentView.textColor = [UIColor whiteColor];
    _percentView.font = [UIFont systemFontOfSize:12];
    _percentView.layer.masksToBounds = YES;
    [self addSubview:_percentView];
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
        viewTop.frame = CGRectMake(viewTop.frame.origin.x,0, viewBottom.frame.size.width*[progressValue floatValue], viewTop.frame.size.height);
        weakself.percentView.frame = CGRectMake(viewBottom.frame.size.width*[progressValue floatValue]-45,  0, 45, weakself.bounds.size.height);
    }];
}


-(void)setBottomColor:(UIColor *)bottomColor
{
    _bottomColor = bottomColor;
    viewBottom.backgroundColor = bottomColor;
}

-(void)setProgressColor:(UIColor *)progressColor
{
    _progressColor = progressColor;
    viewTop.backgroundColor = progressColor;
    _percentView.backgroundColor = progressColor;
}












@end
