//
//  InviteNewFriendController.h
//  Psf
//
//  Created by zhangshu on 2019/2/26.
//  Copyright © 2019 zhangshu. All rights reserved.
//

#import "BaseViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>
NS_ASSUME_NONNULL_BEGIN

@protocol JSProtocol <JSExport>
-(void)testJS;
-(void)shareTitle:(NSString *)title Desc:(NSString *)desc;

@end
@interface InviteNewFriendController : BaseViewController

@end

NS_ASSUME_NONNULL_END
