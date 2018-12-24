//
//  HomeHeadView.m
//  Psf
//
//  Created by zhangshu on 2018/12/20.
//  Copyright © 2018 zhangshu. All rights reserved.
//

#import "HomeHeadView.h"

@implementation HomeHeadView

-(ZSCycleScrollView *)cycleScroll{
    if (!_cycleScroll) {
        _cycleScroll = [[ZSCycleScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH,200*SCREENWIDTH/375+130)];
        _cycleScroll.imageSize = CGSizeMake(SCREENWIDTH, 200*SCREENWIDTH/375);
        _cycleScroll.delegate =self;
        [_cycleScroll setIndex:0];
        
        _cycleScroll.autoScrollTimeInterval = 3.0;
        _cycleScroll.dotColor = [UIColor redColor];
    }
    return _cycleScroll;
}
-(UIImageView *)headimage{
    if (!_headimage) {
        _headimage = [[UIImageView alloc]init];
        
    }
    return _headimage;
}
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = [UIFont boldSystemFontOfSize:18];
        _titleLabel.textColor = DSColorFromHex(0x464646);
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.cycleScroll];
        [self addSubview:self.headimage];
        [self addSubview:self.titleLabel];
        [self.headimage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.top.equalTo(self).offset(200*SCREENWIDTH/375+110);
            make.height.mas_equalTo(120*SCREENWIDTH/375);
        }];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
             make.left.right.equalTo(self);
            make.top.equalTo(self.headimage.mas_bottom).offset(15);
        }];
        
        __weak typeof(self)weakself = self;
        [self.cycleScroll setSelectedItemBlock:^(NSInteger index) {
            weakself.selected(index);
        }];
    }
    return self;
}
-(void)setModel:(SubjectCategoryModel *)model{
    _model = model;
    NSString*url = [NSString stringWithFormat:@"%@%@",IMAGEHOST,model.subjectCategoryImagePath];
    [self.headimage sd_setImageWithURL:[NSURL URLWithString:url]];
    self.titleLabel.text = model.subjectCategoryName;
}
-(void)cycleScrollView:(ZSCycleScrollView *)cycleScrollView didSelectItemAtRow:(NSInteger)row{
    self.imageBlock(row);
}
@end
