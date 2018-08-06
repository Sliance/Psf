//
//  UIPlaceHolderTextView.m
//  Pinche
//
//  Created by haole on 12-3-6.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "UIPlaceHolderTextView.h"

@implementation UIPlaceHolderTextView

@synthesize placeHolderLabel;
@synthesize placeholder;
@synthesize placeholderColor;

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];

#if ! __has_feature(objc_arc)
    [super dealloc];
#endif
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setPlaceholder:@""];
    [self setPlaceholderColor:[UIColor lightGrayColor]];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged:) name:UITextViewTextDidChangeNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(beginEditing:) name:UITextViewTextDidBeginEditingNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(endEditingNote:) name:UITextViewTextDidEndEditingNotification object:nil];
}

- (id)init {
    if( (self = [super init]) )
    {
        [self setPlaceholder:@""];
        [self setPlaceholderColor:[UIColor lightGrayColor]];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged:) name:UITextViewTextDidChangeNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(beginEditing:) name:UITextViewTextDidBeginEditingNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(endEditingNote:) name:UITextViewTextDidEndEditingNotification object:nil];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    if( (self = [super initWithFrame:frame]) )
    {
        [self setPlaceholder:@""];
        [self setPlaceholderColor:[UIColor lightGrayColor]];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged:) name:UITextViewTextDidChangeNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(beginEditing:) name:UITextViewTextDidBeginEditingNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(endEditingNote:) name:UITextViewTextDidEndEditingNotification object:nil];
    }
    return self;
}

- (void)beginEditing:(NSNotification *)notification {
    if ([notification.object isEqual:self]) {
        if (self.type == TextViewWithClear && self.text.length) {
            self.clearButton.hidden = NO;
        } else {
            self.clearButton.hidden = YES;
        }
    }
}

- (void)endEditingNote:(NSNotification *)notification {
    if ([notification.object isEqual:self]) {
        self.clearButton.hidden = YES;
    }
}

- (void)textChanged:(NSNotification *)notification
{
    if([[self text] length] != 0)
    {
        [[self viewWithTag:999] setAlpha:0];
    }
    if ([notification.object isEqual:self]) {
        if([[self placeholder] length] == 0)
        {
            return;
        }
        
        if([[self text] length] == 0)
        {
            [[self viewWithTag:999] setAlpha:1];
            if (self.type == TextViewWithClear) {
                self.clearButton.hidden = YES;
            }
        }
        else
        {
            [[self viewWithTag:999] setAlpha:0];
            if (self.type == TextViewWithClear) {
                self.clearButton.hidden = NO;
            }
        }
    }
}

- (void)setType:(TextViewType)type {
    _type = type;
    if (type == TextViewWithClear) {
        
    } else {
        if ([self.subviews containsObject:self.clearButton]) {
            [self.clearButton removeFromSuperview];
        }
    }
}

- (UIButton *)clearButton{
    if (!_clearButton) {
        _clearButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_clearButton setImage:[UIImage imageNamed:@"icon_textview_clear"] forState:UIControlStateNormal];
        [_clearButton addTarget:self action:@selector(clearClick) forControlEvents:UIControlEventTouchUpInside];
        _clearButton.frame = CGRectMake(0, 0, 30, 30);
    }
    return _clearButton;
}

- (void)clearClick {
    self.text = @"";
    self.clearButton.hidden = YES;
}

- (void)setText:(NSString *)text {
    [super setText:text];
    [self textChanged:nil];
}

- (void)drawRect:(CGRect)rect
{
    if( [[self placeholder] length] > 0 )
    {
        if ( placeHolderLabel == nil )
        {
            placeHolderLabel = [[UILabel alloc] initWithFrame:CGRectMake(8,8,self.bounds.size.width - 16,0)];
            placeHolderLabel.lineBreakMode = NSLineBreakByCharWrapping;
            placeHolderLabel.numberOfLines = 0;
            placeHolderLabel.font = [UIFont systemFontOfSize:15];
            placeHolderLabel.backgroundColor = [UIColor clearColor];
            placeHolderLabel.textColor = self.placeholderColor;
            placeHolderLabel.alpha = 0;
            placeHolderLabel.tag = 999;
            [self addSubview:placeHolderLabel];
        }
        
        placeHolderLabel.text = self.placeholder;
        [placeHolderLabel sizeToFit];
        [self sendSubviewToBack:placeHolderLabel];
    }
    
    
    if( [[self text] length] == 0 && [[self placeholder] length] > 0 )
    {
        [[self viewWithTag:999] setAlpha:1];
    }
    
    [super drawRect:rect];
    if (self.type == TextViewWithClear) {
//        self.inputView.frame = CGRectMake(0, 0, rect.size.width - 50, rect.size.height);
        UIEdgeInsets insets = self.textContainerInset;
        insets.right = 40;
        self.textContainerInset = insets;
        self.inputView.backgroundColor = [UIColor greenColor];
        [self addSubview:self.clearButton];
        self.clearButton.frame = CGRectMake(rect.size.width - 30, (rect.size.height - 30)/2, 30, 30);
        self.clearButton.hidden = YES;
    }
}

@end
