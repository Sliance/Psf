//
//  NavgationView.h
//  TheWorker
//
//  Created by apple on 2018/4/26.
//  Copyright © 2018年 huying. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseView.h"
@protocol NavgationViewDelegate<NSObject>
-(void)pressBackBtn;

@end

@interface NavgationView : BaseView
@property(nonatomic,weak)id<NavgationViewDelegate>delegate;

@property(nonatomic,strong)UIImageView *bgView;
@property(nonatomic,strong)UIButton *backBtn;
@property(nonatomic,strong)UILabel *titleLabel;

@end
