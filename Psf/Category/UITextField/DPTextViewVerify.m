//
//  DPTextViewVerify.m
//  SupplierApp
//
//  Created by 张舒 on 17/4/1.
//  Copyright © 2017年 liujianzhong. All rights reserved.
//

#import "DPTextViewVerify.h"
#import "DPSwizzledMethod.h"
#import <objc/runtime.h>
#import "NSString+Ext.h"
#pragma mark - __DPTextViewVerify

/// 检测UITextField、UITextView
@interface __DPTextViewVerify : NSObject  <DPTextInputVerify>

/// 前一个值
@property (copy, nonatomic) NSString *earlierText;

@property (assign,nonatomic) BOOL isHaveDian;

/// 验证对象
@property (readonly, weak, nonatomic) id<UITextInput, DPTextVerify> verifyObject;

- (instancetype)initWithVerifyObject:(id<UITextInput, DPTextVerify>)verifyObject;

@end

@implementation __DPTextViewVerify
@synthesize maxPoint  = _maxPoint;
@synthesize maxLength = _maxLength;
@synthesize minLength = _minLength;
@synthesize regexString = _regexString;
@synthesize verifyResult = _verifyResult;
@synthesize validityChange = _validityChange;

+ (void)load
{
    swizzleMethod([self class], NSSelectorFromString(@"dealloc"), [self class], @selector(swizzle_dealloc));
}

#pragma mark Life Circle
- (instancetype)initWithVerifyObject:(id<UITextInput, DPTextVerify>)verifyObject
{
    if (self = [super init]) {
        _maxPoint = DPVerifyNullValue;
        _maxLength = DPVerifyNullValue;
        _minLength = DPVerifyNullValue;
        
        _verifyObject = verifyObject;
        [self registerObserver];
    }
    return self;
}

- (void)swizzle_dealloc
{
    [self unregisterObserver];
    [self swizzle_dealloc];
}

#pragma mark Method Private
- (DPVerifyResult)compareLength:(NSInteger)length
{
    if (length <= 0) {
        return DPVerifyResultUnknown;
    }
    if (length < self.minLength) {
        return DPVerifyResultErrorMin;
    }
    
    if (self.maxLength != DPVerifyNullValue && length > self.maxLength) {
        return DPVerifyResultErrorMax;
    }
    
    return DPVerifyResultSuccess;
}
- (DPVerifyResult)checkPoint:(NSString *)text{
    NSArray *arr = [text componentsSeparatedByString:@"."];
    if (arr.count == 2) {
        NSString *string = [arr lastObject];
        if (string.length >_maxPoint) {
            return DPVerifyResultErrorMax;
        }
    }
    return DPVerifyResultSuccess;
}
- (DPVerifyResult)matchRegexWithString:(NSString *)text
{
    if (self.regexString) {
        return DPVerifyResultSuccess;
    }
    
    NSPredicate *regexPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", self.regexString];
    BOOL matchResult = [regexPredicate evaluateWithObject:text ];
    return matchResult ? DPVerifyResultSuccess : DPVerifyResultErrorRegexString;
}

- (void)registerObserver
{
    NSString *didBeginEditingNotification = nil;
    NSString *didChangeNotification = nil;
    NSString *didPointChangeNotification = nil;
    if ([self.verifyObject isKindOfClass:[UITextField class]]) {
        didBeginEditingNotification = UITextFieldTextDidBeginEditingNotification;
        didChangeNotification = UITextFieldTextDidChangeNotification;
        didPointChangeNotification = UITextFieldTextDidChangeNotification;
    } else if ([self.verifyObject isKindOfClass:[UITextView class]]) {
        didBeginEditingNotification = UITextViewTextDidBeginEditingNotification;
        didChangeNotification = UITextViewTextDidChangeNotification;
        didPointChangeNotification = UITextViewTextDidChangeNotification;
    }
    
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    [notificationCenter addObserver:self selector:@selector(textDidBeginEditingNotification:) name:didBeginEditingNotification object:nil];
    [notificationCenter addObserver:self selector:@selector(textDidChangeEditingNotification:) name:didChangeNotification object:nil];
    [notificationCenter addObserver:self selector:@selector(textPointDidChangeEditingNotification:) name:didPointChangeNotification object:nil];
    
}

- (void)unregisterObserver
{
    NSString *didBeginEditingNotification = nil;
    NSString *didChangeNotification = nil;
    NSString *didPointChangeNotification = nil;
    if ([self.verifyObject isKindOfClass:[UITextField class]]) {
        didBeginEditingNotification = UITextFieldTextDidBeginEditingNotification;
        didChangeNotification = UITextFieldTextDidChangeNotification;
        didPointChangeNotification = UITextFieldTextDidChangeNotification;
    } else if ([self.verifyObject isKindOfClass:[UITextView class]]) {
        didBeginEditingNotification = UITextViewTextDidBeginEditingNotification;
        didChangeNotification = UITextViewTextDidChangeNotification;
    }
    
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    [notificationCenter removeObserver:self name:didBeginEditingNotification object:nil];
    [notificationCenter removeObserver:self name:didChangeNotification object:nil];
    [notificationCenter removeObserver:self name:didPointChangeNotification object:nil];
}

/**
 *  光标选择的范围
 */
- (NSRange)cursorRangeForTextInput:(id<UITextInput>)textInput
{
    UITextPosition* beginning = textInput.beginningOfDocument;
    UITextRange* selectedRange = textInput.selectedTextRange;
    UITextPosition* selectionStart = selectedRange.start;
    UITextPosition* selectionEnd = selectedRange.end;
    NSInteger location = [textInput offsetFromPosition:beginning toPosition:selectionStart];
    NSInteger length = [textInput offsetFromPosition:selectionStart toPosition:selectionEnd];
    
    return NSMakeRange(location, length);
}

/**
 *  设置光标选择的范围
 */
- (void)setCursorRange:(NSRange)range forTextInput:(id<UITextInput>)textInput
{
    UITextPosition* beginning = textInput.beginningOfDocument;
    UITextPosition* startPosition = [textInput positionFromPosition:beginning offset:range.location];
    UITextPosition* endPosition = [textInput positionFromPosition:beginning offset:range.location + range.length];
    UITextRange* selectionRange = [textInput textRangeFromPosition:startPosition toPosition:endPosition];
    [textInput setSelectedTextRange:selectionRange];
}

- (void)updateTextForMax:(id<UITextInput, DPTextVerify>)textInputView
{
    // 键盘输入法类型
    //UITextInputMode *textInputMode = [sender.object valueForKey:@"textInputMode"];
    //NSString *lang = [textInputMode primaryLanguage];
    
    id<UITextInput> textInput = textInputView;
    
    NSString *toBeString = [textInputView verifyText];
    
    //获取高亮部分
    UITextRange *selectedRange = [textInput markedTextRange];
    UITextPosition *position = [textInput positionFromPosition:selectedRange.start offset:0];
    
    // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
    if (!position)
    {
        if (toBeString.length > self.maxLength) {
            BOOL setCursor = YES;
            NSInteger newLength = toBeString.length - self.earlierText.length;
            NSInteger overLength = toBeString.length - self.maxLength;
            
            NSRange cursorRange = [self cursorRangeForTextInput:textInput];
            if (NSEqualRanges(cursorRange, NSMakeRange(0, 0))) {
                setCursor = NO;
                cursorRange = NSMakeRange(toBeString.length, 0);
            }
            NSRange newRange = NSMakeRange(cursorRange.location - newLength, newLength);
            
            NSRange removeRange = NSMakeRange(newRange.location + newRange.length - overLength, overLength);
            
            removeRange = [toBeString rangeOfComposedCharacterSequencesForRange:removeRange];
            
            toBeString = [toBeString stringByReplacingCharactersInRange:removeRange withString:@""];
            
            [textInputView setVerifyText:toBeString];
            if (setCursor) {
                [self setCursorRange:NSMakeRange(removeRange.location, 0) forTextInput:textInput];
            }
        }
        NSArray *arr = [toBeString componentsSeparatedByString:@"."];
        if (arr.count == 2) {
            NSString *string = [arr lastObject];
            if (string.length >_maxPoint) {
                BOOL setCursor = YES;
                NSInteger newLength = toBeString.length - self.earlierText.length;
                NSInteger overLength = string.length - self.maxPoint;
                
                NSRange cursorRange = [self cursorRangeForTextInput:textInput];
                if (NSEqualRanges(cursorRange, NSMakeRange(0, 0))) {
                    setCursor = NO;
                    cursorRange = NSMakeRange(toBeString.length, 0);
                }
                NSRange newRange = NSMakeRange(cursorRange.location - newLength, newLength);
                
                NSRange removeRange = NSMakeRange(newRange.location + newRange.length - overLength, overLength);
                
                removeRange = [toBeString rangeOfComposedCharacterSequencesForRange:removeRange];
                
                toBeString = [toBeString stringByReplacingCharactersInRange:removeRange withString:@""];
                
                [textInputView setVerifyText:toBeString];
                if (setCursor) {
                    [self setCursorRange:NSMakeRange(removeRange.location, 0) forTextInput:textInput];
                }

            }
        }
        self.earlierText = toBeString;
    }
}

#pragma mark Method Public
- (void)setNeedsVerifyText
{
    NSString *didChangeNotification = nil;
    NSString *didPointChangeNotification = nil;
    
    if ([self.verifyObject isKindOfClass:[UITextField class]]) {
        didChangeNotification = UITextFieldTextDidChangeNotification;
        didPointChangeNotification = UITextFieldTextDidChangeNotification;
    } else if ([self.verifyObject isKindOfClass:[UITextView class]]) {
        didChangeNotification = UITextViewTextDidChangeNotification;
        didPointChangeNotification = UITextViewTextDidChangeNotification;
    }
    
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    [notificationCenter postNotificationName:didChangeNotification object:self.verifyObject];
    [notificationCenter postNotificationName:didPointChangeNotification object:self.verifyObject];
}

#pragma mark Event Response
- (void)textDidBeginEditingNotification:(NSNotification *)sender
{
    if (![sender.object isEqual:self.verifyObject]) {
        return;
    }
    
    id<DPTextVerify> inputView = sender.object;
    [self setEarlierText:inputView.verifyText];
}

- (void)textDidChangeEditingNotification:(NSNotification *)sender
{
    if (![sender.object isEqual:self.verifyObject]) {
        return;
    }
    
    id<UITextInput, DPTextVerify> inputView = sender.object;
    
    NSString *text = inputView.verifyText;
    
    DPVerifyResult verifyResult = [self compareLength:text.length];
    
    if (verifyResult == DPVerifyResultErrorMax) {
        [self updateTextForMax:sender.object];
        [self setEarlierText:inputView.verifyText];
        return;
    }
    
    if (verifyResult == DPVerifyResultSuccess) {
        verifyResult = [self matchRegexWithString:text];
    }
    
    if (verifyResult != self.verifyResult) {
        _verifyResult = verifyResult;
        if (self.validityChange) {
            self.validityChange(self.verifyResult, text);
        }
    }
    [self setEarlierText:inputView.verifyText];
    
    
}
- (void)textPointDidChangeEditingNotification:(NSNotification *)sender
{
    if (![sender.object isEqual:self.verifyObject]) {
        return;
    }
    
    id<UITextInput, DPTextVerify> inputView = sender.object;
    
    NSString *text = inputView.verifyText;

    DPVerifyResult verifyPointResult = [self checkPoint:text];
    
    if (verifyPointResult == DPVerifyResultErrorMax) {
        [self updateTextForMax:sender.object];
        [self setEarlierText:inputView.verifyText];
        return;
    }
    
    if (verifyPointResult == DPVerifyResultSuccess) {
        verifyPointResult = [self matchRegexWithString:text];
    }
    
    if (verifyPointResult != self.verifyResult) {
        _verifyResult = verifyPointResult;
        if (self.validityChange) {
            self.validityChange(self.verifyResult, text);
        }
    }
    [self setEarlierText:inputView.verifyText];
}
#pragma mark Custom Accessors
- (NSString *)earlierText
{
    
    if ([_earlierText isDPEmpty]) {
        _earlierText = self.verifyObject.verifyText;
    }
    return _earlierText;
}
-(void)setMaxPoint:(NSInteger)maxPoint{
    if (maxPoint <DPVerifyNullValue) {
        _maxPoint = DPVerifyNullValue;
        return;
    }
    _maxPoint = maxPoint;
}
- (void)setMaxLength:(NSInteger)maxLength
{
    if (maxLength < DPVerifyNullValue) {
        _maxLength = DPVerifyNullValue;
        return;
    }
    _maxLength = maxLength;
}

- (void)setMinLength:(NSInteger)minLength
{
    if (minLength < DPVerifyNullValue) {
        _minLength = DPVerifyNullValue;
        return;
    }
    _minLength = minLength;
}

- (NSString *)regexString
{
    if ([_regexString isDPEmpty]) {
        return @"";
    }
    return _regexString;
}

- (DPVerifyResult)verifyResult
{
    if (_verifyResult < DPVerifyResultUnknown) {
        NSString *text = self.verifyObject.verifyText;
        if (![text isDPEmpty]) {
            _verifyResult = [self compareLength:text.length];
            if (_verifyResult == DPVerifyResultSuccess) {
                _verifyResult = [self matchRegexWithString:text];
            }
        }else{
            _verifyResult = DPVerifyResultUnknown;
        }
    }
    return _verifyResult;
}

@end

#pragma mark - UITextField
@interface UITextField ()

/// 检测对象
@property (strong, nonatomic) __DPTextViewVerify *textVerify;

@end

@implementation UITextField (Verify)
@dynamic maxPoint;
@dynamic maxLength;
@dynamic minLength;
@dynamic regexString;
@dynamic verifyResult;
@dynamic validityChange;
@dynamic verifyText;

#pragma mark Lazy Load
- (__DPTextViewVerify *)textVerify
{
    __DPTextViewVerify *textVerify = objc_getAssociatedObject(self, @selector(textVerify));
    
    if (!textVerify) {
        textVerify = [[__DPTextViewVerify alloc] initWithVerifyObject:self];
        [self setTextVerify:textVerify];
    }
    
    return textVerify;
}

- (void)setTextVerify:(__DPTextViewVerify *)textVerify
{
    objc_setAssociatedObject(self, @selector(textVerify), textVerify, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark Method Public
- (void)setNeedsVerifyText
{
    [self.textVerify setNeedsVerifyText];
}

#pragma mark Custom Accessors
-(NSInteger)maxPoint{
    return self.textVerify.maxPoint;
}
-(void)setMaxPoint:(NSInteger)maxPoint{
    [self.textVerify setMaxPoint:maxPoint];
}
- (NSInteger)maxLength
{
    return self.textVerify.maxLength;
}

- (void)setMaxLength:(NSInteger)maxLength
{
    [self.textVerify setMaxLength:maxLength];
}

- (NSInteger)minLength
{
    return self.textVerify.minLength;
}

- (void)setMinLength:(NSInteger)minLength
{
    [self.textVerify setMinLength:minLength];
}

- (NSString *)regexString
{
    return self.textVerify.regexString;
}

- (void)setRegexString:(NSString *)regexString
{
    [self.textVerify setRegexString:regexString];
}

- (DPVerifyResult)verifyResult
{
    return self.textVerify.verifyResult;
}

- (void (^)(DPVerifyResult, NSString *))validityChange
{
    return self.textVerify.validityChange;
}

- (void)setValidityChange:(void (^)(DPVerifyResult, NSString *))validityChange
{
    [self.textVerify setValidityChange:validityChange];
}

- (NSString *)verifyText
{
    return self.text;
}

- (void)setVerifyText:(NSString *)verifyText
{
    [self setText:verifyText];
}

@end

#pragma mark - UITextView
@interface UITextView ()

/// 检测对象
@property (strong, nonatomic) __DPTextViewVerify *textVerify;

@end

@implementation UITextView (Verify)

@dynamic maxLength;
@dynamic minLength;
@dynamic regexString;
@dynamic verifyResult;
@dynamic validityChange;
@dynamic verifyText;

#pragma mark Lazy Load
- (__DPTextViewVerify *)textVerify
{
    __DPTextViewVerify *textVerify = objc_getAssociatedObject(self, @selector(textVerify));
    
    if (!textVerify) {
        textVerify = [[__DPTextViewVerify alloc] initWithVerifyObject:self];
        [self setTextVerify:textVerify];
    }
    
    return textVerify;
}

- (void)setTextVerify:(__DPTextViewVerify *)textVerify
{
    objc_setAssociatedObject(self, @selector(textVerify), textVerify, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark Method Public
- (void)setNeedsVerifyText
{
    [self.textVerify setNeedsVerifyText];
}

#pragma mark Custom Accessors
-(NSInteger)maxPoint{
    return self.textVerify.maxPoint;
}
-(void)setMaxPoint:(NSInteger)maxPoint{
    [self.textVerify setMaxPoint:maxPoint];
}
- (NSInteger)maxLength
{
    return self.textVerify.maxLength;
}

- (void)setMaxLength:(NSInteger)maxLength
{
    [self.textVerify setMaxLength:maxLength];
}

- (NSInteger)minLength
{
    return self.textVerify.minLength;
}

- (void)setMinLength:(NSInteger)minLength
{
    [self.textVerify setMinLength:minLength];
}

- (NSString *)regexString
{
    return self.textVerify.regexString;
}

- (void)setRegexString:(NSString *)regexString
{
    [self.textVerify setRegexString:regexString];
}

- (DPVerifyResult)verifyResult
{
    return self.textVerify.verifyResult;
}

- (void (^)(DPVerifyResult, NSString *))validityChange
{
    return self.textVerify.validityChange;
}

- (void)setValidityChange:(void (^)(DPVerifyResult, NSString *))validityChange
{
    [self.textVerify setValidityChange:validityChange];
}

- (NSString *)verifyText
{
    return self.text;
}

- (void)setVerifyText:(NSString *)verifyText
{
    [self setText:verifyText];
}

@end
