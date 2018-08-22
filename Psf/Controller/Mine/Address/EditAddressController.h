//
//  EditAddressController.h
//  Psf
//
//  Created by 燕来秋mac9 on 2018/6/26.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "BaseViewController.h"
#import "AddressServiceApi.h"
@interface EditAddressController : BaseViewController
@property(nonatomic,strong)ChangeAddressReq *changeReq;
///添加是0修改是1
@property(nonatomic,assign)NSInteger type;

@end
