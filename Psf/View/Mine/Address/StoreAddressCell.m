//
//  StoreAddressCell.m
//  Psf
//
//  Created by 燕来秋mac9 on 2018/7/23.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "StoreAddressCell.h"

@implementation StoreAddressCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self setCornentLayout];
        
    }
    return self;
}
-(void)setCornentLayout{
    [self addSubview:self.titleLabel];
    [self addSubview:self.detailLabel];
    [self addSubview:self.phoneLabel];
    [self addSubview:self.morenLabel];
    [self addSubview:self.editBtn];
    [self addSubview:self.distanceLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15);
        make.width.mas_equalTo(58);
        make.top.equalTo(self).offset(15);
    }];
    [self.phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(89);
        make.right.equalTo(self).offset(-60);
        make.top.equalTo(self).offset(15);
    }];
    [self.morenLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(10);
        make.width.mas_equalTo(34);
        make.height.mas_equalTo(16);
    }];
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel.mas_right).offset(16);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(10);
    }];
   
   
    [self.editBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-26);
        make.width.height.mas_equalTo(15);
        make.top.equalTo(self.phoneLabel.mas_top);
    }];
    [self.distanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-16);
        make.top.equalTo(self.editBtn.mas_bottom).offset(10);
    }];
    
}
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = [UIFont systemFontOfSize:14];
        _titleLabel.textColor = DSColorFromHex(0x474747);
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.text = @"";
    }
    return _titleLabel;
}
-(UILabel *)detailLabel{
    if (!_detailLabel) {
        _detailLabel = [[UILabel alloc]init];
        _detailLabel.font = [UIFont systemFontOfSize:14];
        _detailLabel.textColor = DSColorFromHex(0x969696);
        _detailLabel.textAlignment = NSTextAlignmentLeft;
        _detailLabel.text = @"";
    }
    return _detailLabel;
}
-(UILabel *)phoneLabel{
    if (!_phoneLabel) {
        _phoneLabel = [[UILabel alloc]init];
        _phoneLabel.font = [UIFont systemFontOfSize:14];
        _phoneLabel.textColor = DSColorFromHex(0x474747);
        _phoneLabel.textAlignment = NSTextAlignmentLeft;
        _phoneLabel.text = @"";
    }
    return _phoneLabel;
}
-(UILabel *)morenLabel{
    if (!_morenLabel) {
        _morenLabel = [[UILabel alloc]init];
        _morenLabel.font = [UIFont systemFontOfSize:11];
        _morenLabel.textColor = [UIColor whiteColor];
        _morenLabel.backgroundColor = DSColorFromHex(0xFF4C4D);
        _morenLabel.textAlignment = NSTextAlignmentCenter;
        _morenLabel.text = @"默认";
        _morenLabel.hidden = YES;
    }
    return _morenLabel;
}

-(UILabel *)distanceLabel{
    if (!_distanceLabel) {
        _distanceLabel = [[UILabel alloc]init];
        _distanceLabel.font = [UIFont systemFontOfSize:12];
        _distanceLabel.textColor = DSColorFromHex(0x979797);
        _distanceLabel.textAlignment = NSTextAlignmentRight;
        _distanceLabel.text = @"";
    }
    return _distanceLabel;
}
-(UIButton *)editBtn{
    if (!_editBtn) {
        _editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_editBtn setImage:[UIImage imageNamed:@"shopping_normal"] forState:UIControlStateNormal];
        [_editBtn setImage:[UIImage imageNamed:@"shopping_selected"] forState:UIControlStateSelected];
        [_editBtn addTarget:self action:@selector(pressEditBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _editBtn;
}
-(void)setIndex:(NSInteger)index{
    _index = index;
    _editBtn.tag = index;
}
-(void)pressEditBtn:(UIButton*)sender{
    sender.selected = !sender.selected;
    self.selectedBlock(_model);
}
-(void)setModel:(StoreRes *)model{
    _model = model;
    _titleLabel.text = model.storeName;
    _phoneLabel.text =[NSString stringWithFormat:@"%@%@%@%@",model.storeProvinces,model.storeCity,model.storeArea,model.storeAddress];;
    _detailLabel.text = model.storeTel;
    if (model.memberStoreIsDefault ==0) {
        self.morenLabel.hidden = YES;
        self.editBtn.selected = NO;
    }else if (model.memberStoreIsDefault ==1){
        self.morenLabel.hidden = NO;
        self.editBtn.selected = YES;
    }
    self.distanceLabel.text = model.storeInstance;
}
@end
