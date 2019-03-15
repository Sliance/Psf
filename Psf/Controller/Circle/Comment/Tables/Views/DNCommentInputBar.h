//
//  DNCommentInputBar.h
//  DnaerApp
//
//  Created by 燕来秋 on 2018/11/5.
//  Copyright © 2018 燕来秋. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DNCommentInputBar : UIView
@property (nonatomic, strong) UITextField *inputField;
@property (nonatomic, copy) void (^sendBlock)(NSString*);

@end

NS_ASSUME_NONNULL_END
