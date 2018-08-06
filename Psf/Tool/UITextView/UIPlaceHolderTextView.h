//
//  UIPlaceHolderTextView.h
//  Pinche
//
//  Created by haole on 12-3-6.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    TextViewNormal,
    TextViewWithClear,
} TextViewType;


@interface UIPlaceHolderTextView : UITextView {
    NSString *placeholder;
    UIColor *placeholderColor;
    
@private
    UILabel *placeHolderLabel;
}

@property (nonatomic, retain) UILabel *placeHolderLabel;
@property (nonatomic, retain) NSString *placeholder;
@property (nonatomic, retain) UIColor *placeholderColor;

@property (nonatomic, strong) UIButton *clearButton;
@property (nonatomic, assign) TextViewType type;

-(void)textChanged:(NSNotification*)notification;

@end
