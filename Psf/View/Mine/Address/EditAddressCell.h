//
//  EditAddressCell.h
//  Psf
//
//  Created by 燕来秋mac9 on 2018/6/26.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface EditAddressCell : BaseTableViewCell<UITextFieldDelegate>
@property(nonatomic,strong)UITextField *contentField;

@end
