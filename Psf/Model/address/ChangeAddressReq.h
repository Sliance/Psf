//
//  ChangeAddressReq.h
//  Psf
//
//  Created by 燕来秋mac9 on 2018/7/12.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChangeAddressReq : NSObject
///(181)
@property(nonatomic,copy)NSString *erpStoreId;
///接收人姓名
@property(nonatomic,strong)NSString *memberAddressName;
///手机号码
@property(nonatomic,strong)NSString *memberAddressMobile;
///省份
@property(nonatomic,strong)NSString *memberAddressProvince;
///城市
@property(nonatomic,strong)NSString *memberAddressCity;
///地区
@property(nonatomic,strong)NSString *memberAddressArea;
///定位详细地址
@property(nonatomic,strong)NSString *memberAddressPositionDetail;
///是否默认地址
@property(nonatomic,assign)BOOL memberAddressIsDefault;
///经度
@property(nonatomic,copy)NSString *memberAddressLongitude;
///纬度
@property(nonatomic,copy)NSString *memberAddressLatitude;
///详细地址
@property(nonatomic,strong)NSString *memberAddressDetail;
///
@property(nonatomic,strong)NSString *appId;
///
@property(nonatomic,strong)NSString *token;
///客户端
@property(nonatomic,strong)NSString *platform;
///时间戳
@property(nonatomic,strong)NSString *timestamp;
///会员地址编号
@property(nonatomic,copy)NSString *memberAddressId;
///
@property(nonatomic,copy)NSString *systemVersion;
@end
