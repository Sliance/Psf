//
//  ZSCycleScrollView.h
//  ZSCycleScrollView
//
//  Created by 燕来秋mac9 on 2018/6/15.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZSConfig.h"
#import "ImageModel.h"


/**
 *  把RGB色值由0～255转为标准的0～1.0, alpha默认为1.0
 *
 *  @param r red 0.0~255.0
 *  @param g green 0.0~255.0
 *  @param b blue 0.0~255.0
 *
 *  @return RGB color
 */
#define GCColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]


/**
 *  把RGB色值由0～255转为标准的0～1.0,alpha可以设值
 *
 *  @param r red 0.0~255.0
 *  @param g green 0.0~255.0
 *  @param b blue 0.0~255.0
 *  @param a alpha 0.0~1.0
 *
 *  @return RGB color
 */
#define GCColorWithAlpha(r, g, b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]




typedef NS_ENUM(NSInteger,ZSCycleScrollPageControlAliment){
    /**
     *  page control 位于中间，默认在中间
     */
    ZSCycleScrollPageControlAlimentCenter = 0,
    
    /**
     *  page control 位于右侧
     */
    ZSCycleScrollPageControlAlimentRight = 1,
    
    /**
     *  page control 位于左侧
     */
    ZSCycleScrollPageControlAlimentLeft = 2
};


@class ZSCycleScrollView;

@protocol ZSCycleScrollViewDelegate <NSObject>
/**
 *  滚动图片点击事件，点击来第row张图片
 *
 *  @param cycleScrollView 创建的scrollview
 *  @param row             第row行
 */
- (void)cycleScrollView:(ZSCycleScrollView*)cycleScrollView didSelectItemAtRow:(NSInteger)row;

@end

@interface ZSCycleScrollView : UIView

/**
 *  代理
 */
@property (nonatomic,weak) id <ZSCycleScrollViewDelegate>delegate;
/**
 *  本地图片数组,每一个element必须是uiimage
 */
@property (nonatomic,strong) NSArray *localImageGroups;


/**
 *  网络图片URL数组,每一个element既可以是NSURL，也可是nsurl string
 */
@property (nonatomic,strong) NSMutableArray *imageUrlGroups;

/**
 *  title 数组
 */
@property (nonatomic,strong) NSArray *titles;


/**
 *  自动滚动时间间隔,默认为1.0
 */
@property (nonatomic,assign) CGFloat autoScrollTimeInterval;


/**
 *  默认放置图片,可设置可不设置
 */
@property (nonatomic,strong) UIImage *placehodlerImage;


/**
 *  page controll 的位置
 */
@property (nonatomic,assign) ZSCycleScrollPageControlAliment pageControlAliment;

/**
 *  分页控件小圆标大小
 */
@property (nonatomic, assign) CGSize pageControlDotSize;
/**
 *  分页控件小圆标颜色
 */
@property (nonatomic, strong) UIColor *dotColor;

/**
 *  title字体颜色，默认为白色
 */
@property (nonatomic, strong) UIColor *titleLabelTextColor;
/**
 *  title字体大小，默认为14
 */
@property (nonatomic, strong) UIFont *titleLabelFont;
/**
 *  title字体背景色
 */
@property (nonatomic, strong) UIColor *titleLabelBgColor;

/**
 *  title字体高度，默认为20
 */
@property (nonatomic, assign) CGFloat titleLabelHeight;

@property(nonatomic,assign)CGSize  imageSize;
/**
 *  创建声明cycleScrollView的方式
 *
 *  @param frame       frame
 *  @param imageGroups 本地图片组，每一个元素都是UiImage
 *
 *  @return GCCycleScrollView object
 */
+ (id)cycleScrollViewWithFrame:(CGRect)frame imageGroups:(NSArray*)imageGroups;

/**
 *  创建声明cycleScrollView的方式
 *
 *  @param frame          frame
 *  @param imageURLGroups 网络图片URL组
 *
 *  @return GCCycleScrollView object
 */
+ (id)cycleScrollViewWithFrame:(CGRect)frame imageURLGroups:(NSArray *)imageURLGroups;

/**
 *  清除缓存
 */
- (void)clearCache;
@property (nonatomic, strong)UICollectionView *collectionView;
@property(nonatomic,copy)void (^selectedItemBlock)(NSInteger);

@end
