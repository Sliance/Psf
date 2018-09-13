//
//  StoreRes.h
//  Psf
//
//  Created by 燕来秋mac9 on 2018/7/20.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StoreRes : NSObject
///门店编号
@property(nonatomic,copy)NSString *memberId;
///是否默认门店
@property(nonatomic,assign)BOOL memberStoreIsDefault;
///详细地址
@property(nonatomic,copy)NSString *storeAddress;
///区
@property(nonatomic,copy)NSString *storeArea;
///市
@property(nonatomic,copy)NSString *storeCity;
///门店编号
@property(nonatomic,copy)NSString *storeId;
///距离
@property(nonatomic,copy)NSString *storeInstance;
///纬度
@property(nonatomic,copy)NSString *storeLatitude;
///经度
@property(nonatomic,copy)NSString *storeLongitude;
///门店名字
@property(nonatomic,copy)NSString *storeName;
///门店所在省
@property(nonatomic,copy)NSString *storeProvinces;
///联系电话
@property(nonatomic,copy)NSString *storeTel;
///
@property(nonatomic,copy)NSString *erpStoreId;
@end
