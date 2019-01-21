//
//  CircleListCell.m
//  Ypc
//
//  Created by zhangshu on 2019/1/8.
//  Copyright © 2019 zhangshu. All rights reserved.
//

#import "CircleListCell.h"
#import "ZSConfig.h"
@implementation CircleListCell
-(UIView *)bgView{
    if (!_bgView) {
        _bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH/2-15, 200)];
        _bgView.backgroundColor = [UIColor whiteColor];
        [_bgView.layer setCornerRadius:9];
        [_bgView.layer setMasksToBounds:YES];
    }
    return _bgView;
}
-(UIImageView *)headImage{
    if (!_headImage) {
        _headImage = [[UIImageView alloc] init];
        _headImage.contentMode = UIViewContentModeScaleAspectFill;
        _headImage.clipsToBounds = YES;
    }
    return _headImage;
}
-(UIImageView *)memberImage{
    if (!_memberImage) {
        _memberImage = [[UIImageView alloc] init];
        [_memberImage.layer setMasksToBounds:YES];
        [_memberImage.layer setCornerRadius:12];
    }
    return _memberImage;
}
-(UILabel *)contentLabel{
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc]init];
        _contentLabel.font = [UIFont systemFontOfSize:15];
        _contentLabel.textColor = DSColorFromHex(0x313131);
        _contentLabel.numberOfLines = 3;
        
    }
    return _contentLabel;
}
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = [UIFont systemFontOfSize:12];
        _titleLabel.textColor = DSColorFromHex(0x313131);
    }
    return _titleLabel;
}
- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self.contentView addSubview:self.bgView];
        [self.bgView addSubview:self.headImage];
        [self.bgView addSubview:self.contentLabel];
        [self.bgView addSubview:self.memberImage];
        [self.bgView addSubview:self.titleLabel];
    }
    return self;
}

-(void)setModel:(CircleListRes *)model{
    _model = model;
    NSString *url ;
    NSString*name;
    
    
    if (model.epicureName.length>0) {
        name = model.epicureName;
        url = [NSString stringWithFormat:@"%@%@",IMAGEHOST,model.epicureImgPath];
    }else if (model.articleName.length>0){
        name = model.articleName;
        url = [NSString stringWithFormat:@"%@%@",IMAGEHOST,model.articleImgPath];
    }
    self.contentLabel.text = name;
    self.headImage.frame = CGRectMake(0, 0, SCREENWIDTH/2-15, 120*(SCREENWIDTH/2-15)/172.5);
    
    if ([self.contentLabel getHeightLineWithString:name withWidth:SCREENWIDTH/2-35 withFont:[UIFont systemFontOfSize:15] lineSpacing:3]>55) {
        self.contentLabel.frame = CGRectMake(10, self.headImage.ctBottom+10, SCREENWIDTH/2-35, 55);
    }else{
        self.contentLabel.frame = CGRectMake(10, self.headImage.ctBottom+10, SCREENWIDTH/2-35, [self.contentLabel getHeightLineWithString:name withWidth:SCREENWIDTH/2-35 withFont:[UIFont systemFontOfSize:15] lineSpacing:3]);
    }
    self.bgView.frame = CGRectMake(0, 0, SCREENWIDTH/2-15, self.contentLabel.ctBottom+15);
    if (model.height>0) {
        
    }else{
        if (self.heightBlock) {
            self.heightBlock(self.bgView.ctBottom);
        }
    }
    
    [self.headImage sd_setImageWithURL:[NSURL URLWithString:url] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        WEAKSELF;
        
    }];
    
    
}
+(CGFloat)getHeight:(CircleListRes *)model{
    CGFloat height = 0;
    NSString *url = [NSString stringWithFormat:@"%@%@",IMAGEHOST,model.epicureImgPath];
    
    UIImageView*image=[[UIImageView alloc]init];
    __block typeof(height)weakheight = height;
    [image sd_setImageWithURL:[NSURL URLWithString:url] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            weakheight += image.size.height*(SCREENWIDTH/2-15)/image.size.width;
    }];
    UILabel *content = [[UILabel alloc]init];
    weakheight+= 10+[content getHeightLineWithString:model.epicureName withWidth:SCREENWIDTH/2-35 withFont:[UIFont systemFontOfSize:15] lineSpacing:3];
    weakheight+= 49;
    return weakheight;
}

@end
