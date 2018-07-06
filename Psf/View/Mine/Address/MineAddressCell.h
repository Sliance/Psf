//
//  MineAddressCell.h
//  Psf
//
//  Created by 燕来秋mac9 on 2018/6/26.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "BaseTableViewCell.h"
@protocol MineAddressCellDelegate<NSObject>
-(void)editAddressIndex:(NSInteger)index;

@end
@interface MineAddressCell : BaseTableViewCell

@property(nonatomic,assign)id<MineAddressCellDelegate>delegate;

@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UILabel *detailLabel;
@property(nonatomic,strong)UILabel *phoneLabel;
@property(nonatomic,strong)UILabel *morenLabel;
@property(nonatomic,strong)UIImageView *lineImage;
@property(nonatomic,strong)UIButton *editBtn;
@property(nonatomic,strong)UILabel *lineLabel;
@property(nonatomic,assign)NSInteger index;
@end
