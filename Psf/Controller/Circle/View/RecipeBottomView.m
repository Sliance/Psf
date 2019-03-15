//
//  Recipem
//  Psf
//
//  Created by zhangshu on 2019/1/21.
//  Copyright © 2019 zhangshu. All rights reserved.
//

#import "RecipeBottomView.h"

@implementation RecipeBottomView

-(UIButton *)collectBtn{
    if (!_collectBtn) {
        _collectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_collectBtn setImage:[UIImage imageNamed:@"collect_recipe"] forState:UIControlStateNormal];
        [_collectBtn setImage:[UIImage imageNamed:@"collect_recipe_selected"] forState:UIControlStateSelected];
        [_collectBtn setTitleColor:DSColorFromHex(0x707070) forState:UIControlStateNormal];
        [_collectBtn setTitleColor:DSColorFromHex(0xFF4C4D) forState:UIControlStateSelected];
        _collectBtn.titleLabel.font = [UIFont systemFontOfSize:10];
        _collectBtn.frame = CGRectMake(SCREENWIDTH/4, 0, SCREENWIDTH/4, 49);
        _collectBtn.tag = 2;
        [_collectBtn addTarget:self action:@selector(pressBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _collectBtn;
}
-(UIButton *)shareBtn{
    if (!_shareBtn) {
        _shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_shareBtn setImage:[UIImage imageNamed:@"share_recipe"] forState:UIControlStateNormal];
        [_shareBtn setImage:[UIImage imageNamed:@"share_recipe"] forState:UIControlStateSelected];
        [_shareBtn setTitleColor:DSColorFromHex(0x707070) forState:UIControlStateNormal];
        [_shareBtn setTitleColor:DSColorFromHex(0xFF4C4D) forState:UIControlStateSelected];
        _shareBtn.titleLabel.font = [UIFont systemFontOfSize:10];
        _shareBtn.frame = CGRectMake(SCREENWIDTH/2, 0, SCREENWIDTH/4, 49);
        _shareBtn.tag = 3;
        [_shareBtn addTarget:self action:@selector(pressBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _shareBtn;
}
-(UIButton *)commentBtn{
    if (!_commentBtn) {
        _commentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_commentBtn setImage:[UIImage imageNamed:@"comment_recipe"] forState:UIControlStateNormal];
        [_commentBtn setImage:[UIImage imageNamed:@"comment_recipe"] forState:UIControlStateSelected];
        [_commentBtn setTitleColor:DSColorFromHex(0x707070) forState:UIControlStateNormal];
        [_commentBtn setTitleColor:DSColorFromHex(0xFF4C4D) forState:UIControlStateSelected];
        _commentBtn.titleLabel.font = [UIFont systemFontOfSize:10];
        _commentBtn.frame = CGRectMake(0, 0, SCREENWIDTH/4, 49);
        _commentBtn.tag = 1;
        [_commentBtn addTarget:self action:@selector(pressBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _commentBtn;
}
-(UIButton *)zanBtn{
    if (!_zanBtn) {
        _zanBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_zanBtn setImage:[UIImage imageNamed:@"zan_recipe"] forState:UIControlStateNormal];
        [_zanBtn setImage:[UIImage imageNamed:@"zan_recipe_selected"] forState:UIControlStateSelected];
        [_zanBtn setTitleColor:DSColorFromHex(0x707070) forState:UIControlStateNormal];
        [_zanBtn setTitleColor:DSColorFromHex(0xFF4C4D) forState:UIControlStateSelected];
        _zanBtn.titleLabel.font = [UIFont systemFontOfSize:10];
        _zanBtn.frame = CGRectMake(SCREENWIDTH*3/4, 0, SCREENWIDTH/4, 49);
        _zanBtn.tag = 4;
        [_zanBtn addTarget:self action:@selector(pressBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _zanBtn;
}
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.collectBtn];
        [self addSubview:self.shareBtn];
        [self addSubview:self.commentBtn];
        [self addSubview:self.zanBtn];
    }
    return self;
}

-(void)setModel:(RecipeCollectModel *)model{
    _model = model;
    self.collectBtn.selected = model.memberWasCollection;
    self.zanBtn.selected = model.memberWasLiked;
    [self.collectBtn setTitle:model.totalCollection forState:UIControlStateNormal];
    [self.shareBtn setTitle:model.totalForwardCount forState:UIControlStateNormal];
    [self.commentBtn setTitle:model.totalCommentNum forState:UIControlStateNormal];
    [self.zanBtn setTitle:model.totalLike forState:UIControlStateNormal];
    [self.collectBtn setIconInTopWithSpacing:5];
    [self.shareBtn setIconInTopWithSpacing:5];
    [self.commentBtn setIconInTopWithSpacing:5];
    [self.zanBtn setIconInTopWithSpacing:5];
}

-(void)pressBtn:(UIButton*)sender{
    self.selectedBlock(sender.tag);
}
@end
