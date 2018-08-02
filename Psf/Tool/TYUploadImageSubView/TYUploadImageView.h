//
//  TYUploadImageView.h
//  TZImagePickerController
//
//  Created by 安天洋 on 2017/4/21.
//  Copyright © 2017年 谭真. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, UPLOADIMAGETYPE) {
    UPLOADIMAGETYPECONTRACT, //  合同及其他资料
    UPLOADIMAGETYPEANIMATION, // 动检证照片
    UPLOADIMAGETYPETICKET // 发票照片
};

@interface TYUploadImageView : UIView

@property (nonatomic, strong) UIViewController * superViewController;

@property (nonatomic, assign) UPLOADIMAGETYPE uploadImageType;
@property (nonatomic, assign) NSInteger maxImagesCount;
/**
 UploadImageView

 @param frame frame description
 @param type type description
 @return return value description
 */
- (id)initWithFrame:(CGRect)frame withType:(UPLOADIMAGETYPE)type withMaxImagesCount:(NSInteger)maxCount;

/**
 单选图片的时候的实例化方法
 @param frame
 @param placeholderStr 占位图的图片
 @return
 */
- (id)initWithFrame:(CGRect)frame withPlaceholderName:(NSString *)placeholderStr;

/**
 写入图片

 @param arrayImage 需要显示的图片
 @return SubView 的高度
 */
-(float)configViewWithData:(NSArray *)arrayImage;


typedef void (^TYUpImageBlock)(NSArray *images ,NSArray * photoArr);

@property (nonatomic, copy) TYUpImageBlock returnimageBlock;

- (void)returnimages:(TYUpImageBlock)block;





@end
