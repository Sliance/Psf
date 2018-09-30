//
//  DetailsRefundController.m
//  Psf
//
//  Created by 燕来秋mac9 on 2018/9/29.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "DetailsRefundController.h"

@interface DetailsRefundController ()<UIScrollViewDelegate>
@property(nonatomic,strong)UIScrollView *bgScrollow;
@property(nonatomic,strong)UIView *titleView;
@property(nonatomic,strong)UIView *priceView;
@property(nonatomic,strong)UIView *goodsView;
@property(nonatomic,strong)UIView *detailView;
@property(nonatomic,strong)UIView *footView;

@property(nonatomic,strong)UILabel *toplabel;
@property(nonatomic,strong)UILabel *topdate;

@property(nonatomic,strong)UILabel *totallabel;
@property(nonatomic,strong)UILabel *totalamount;

@property(nonatomic,strong)UILabel *goodlabel;
@property(nonatomic,strong)UIImageView *headImage;
@property(nonatomic,strong)UILabel *nameLabel;
@property(nonatomic,strong)UILabel *countLabel;
@property(nonatomic,strong)UILabel *payableLabel;
@property(nonatomic,strong)UILabel *topline;

@property(nonatomic,strong)UILabel *whylabel;
@property(nonatomic,strong)UILabel *wxlabel;
@property(nonatomic,strong)UILabel *balancelabel;
@property(nonatomic,strong)UILabel *dateLabel;
@property(nonatomic,strong)UILabel *numberLabel;

@property(nonatomic,strong)UILabel *serviceDateLabel;
@property(nonatomic,strong)UIButton *onlineBtn;
@property(nonatomic,strong)UIButton *phoneBtn;
@end

@implementation DetailsRefundController
-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self setTitle:@"退款详情"];
    }
    return self;
}
-(UIScrollView *)bgScrollow{
    if (!_bgScrollow) {
        _bgScrollow = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
        _bgScrollow.delegate = self;
    }
    return _bgScrollow;
}
-(UIView *)titleView{
    if (!_titleView) {
        _titleView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 120)];
        _titleView.backgroundColor = [UIColor whiteColor];
    }
    return _titleView;
}
-(UIView *)priceView{
    if (!_priceView) {
        _priceView = [[UIView alloc]initWithFrame:CGRectMake(0, 130, SCREENWIDTH, 45)];
        _priceView.backgroundColor = [UIColor whiteColor];
    }
    return _priceView;
}

-(UIView *)goodsView{
    if (!_goodsView) {
        _goodsView = [[UIView alloc]initWithFrame:CGRectMake(0, 185, SCREENWIDTH, 150)];
        _goodsView.backgroundColor = [UIColor whiteColor];
    }
    return _goodsView;
}
-(UIView *)detailView{
    if (!_detailView) {
        _detailView = [[UIView alloc]initWithFrame:CGRectMake(0, 345, SCREENWIDTH, 165)];
        _detailView.backgroundColor = [UIColor whiteColor];
    }
    return _detailView;
}
-(UILabel *)toplabel{
    if (!_toplabel) {
        _toplabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, SCREENWIDTH, 30)];
        _toplabel.textColor = DSColorFromHex(0x63C94B);
        _toplabel.textAlignment = NSTextAlignmentCenter;
        _toplabel.font = [UIFont systemFontOfSize:30];
        _toplabel.text = @"退款成功";
    }
    return _toplabel;
}
-(UILabel *)topdate{
    if (!_topdate) {
        _topdate = [[UILabel alloc]initWithFrame:CGRectMake(0, 70, SCREENWIDTH, 18)];
        _topdate.textColor = DSColorFromHex(0x464646);
        _topdate.textAlignment = NSTextAlignmentCenter;
        _topdate.font = [UIFont systemFontOfSize:18];
        _topdate.text = @"2018-09-011 11:17";
    }
    return _topdate;
}
-(UILabel *)totallabel{
    if (!_totallabel) {
        _totallabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, SCREENWIDTH-15, 45)];
        _totallabel.textAlignment = NSTextAlignmentLeft;
        _totallabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:15];
        _totallabel.textColor = DSColorFromHex(0x464646);
        _totallabel.text = @"退款总金额";
    }
    return _totallabel;
}
-(UILabel *)totalamount{
    if (!_totalamount) {
        _totalamount = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH-15, 45)];
        _totalamount.textAlignment = NSTextAlignmentRight;
        _totalamount.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:15];
        _totalamount.textColor = DSColorFromHex(0xFF4C4D);
        _totalamount.text = @"￥11.8";
    }
    return _totalamount;
}
-(UILabel *)goodlabel{
    if (!_goodlabel) {
        _goodlabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, SCREENWIDTH-15, 45)];
        _goodlabel.textAlignment = NSTextAlignmentLeft;
        _goodlabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:15];
        _goodlabel.textColor = DSColorFromHex(0x464646);
        _goodlabel.text = @"退款信息";
    }
    return _goodlabel;
}
-(UIImageView *)headImage{
    if (!_headImage) {
        _headImage = [[UIImageView alloc]initWithFrame:CGRectMake(15, 60, 75, 75)];
        _headImage.image = [UIImage imageNamed:@"banner_sort"];
        [_headImage.layer setMasksToBounds:YES];
        [_headImage.layer setCornerRadius:4];
        _headImage.layer.borderWidth = 0.5;
        _headImage.layer.borderColor = [UIColor colorWithRed:127.5/255.0 green:127.5/255.0 blue:127.5/255.0 alpha:0.3].CGColor;
    }
    return _headImage;
}
-(UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(100, 70, SCREENWIDTH-115, 15)];
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        _nameLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:15];
        _nameLabel.textColor = DSColorFromHex(0x464646);
        _nameLabel.text = @"榴莲饼";
    }
    return _nameLabel;
}
-(UILabel *)countLabel{
    if (!_countLabel) {
        _countLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREENWIDTH/2, 92, SCREENWIDTH/2-15, 15)];
        _countLabel.textAlignment = NSTextAlignmentRight;
        _countLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:15];
        _countLabel.textColor = DSColorFromHex(0x464646);
        _countLabel.text = @"X1";
    }
    return _countLabel;
}
-(UILabel *)payableLabel{
    if (!_payableLabel) {
        _payableLabel = [[UILabel alloc]initWithFrame:CGRectMake(100, 110, SCREENWIDTH-115, 15)];
        _payableLabel.textAlignment = NSTextAlignmentLeft;
        _payableLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:15];
        _payableLabel.textColor = DSColorFromHex(0x464646);
        _payableLabel.text = @"￥11.8";
    }
    return _payableLabel;
}
-(UILabel *)topline{
    if (!_topline) {
        _topline = [[UILabel alloc]initWithFrame:CGRectMake(15, 45, SCREENWIDTH-15, 0.5)];
        _topline.backgroundColor = DSColorFromHex(0xF0F0F0);
    }
    return _topline;
}
-(UILabel *)whylabel{
    if (!_whylabel) {
        _whylabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 15, SCREENWIDTH-15, 15)];
        _whylabel.textAlignment = NSTextAlignmentLeft;
        _whylabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:15];
        _whylabel.textColor = DSColorFromHex(0x464646);
        _whylabel.text = @"退款原因：测试";
    }
    return _whylabel;
}
-(UILabel *)wxlabel{
    if (!_wxlabel) {
        _wxlabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 45, SCREENWIDTH-15, 15)];
        _wxlabel.textAlignment = NSTextAlignmentLeft;
        _wxlabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:15];
        _wxlabel.textColor = DSColorFromHex(0x464646);
        _wxlabel.text = @"微信退款：￥11.80";
    }
    return _wxlabel;
}
-(UILabel *)balancelabel{
    if (!_balancelabel) {
        _balancelabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 75, SCREENWIDTH-15, 15)];
        _balancelabel.textAlignment = NSTextAlignmentLeft;
        _balancelabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:15];
        _balancelabel.textColor = DSColorFromHex(0x464646);
        _balancelabel.text = @"余额退款：￥0.00";
    }
    return _balancelabel;
}
-(UILabel *)dateLabel{
    if (!_dateLabel) {
        _dateLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 105, SCREENWIDTH-15, 15)];
        _dateLabel.textAlignment = NSTextAlignmentLeft;
        _dateLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:15];
        _dateLabel.textColor = DSColorFromHex(0x464646);
        _dateLabel.text = @"申请时间：2018-09-11 11：04";
    }
    return _dateLabel;
}
-(UILabel *)numberLabel{
    if (!_numberLabel) {
        _numberLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 135, SCREENWIDTH-15, 15)];
        _numberLabel.textAlignment = NSTextAlignmentLeft;
        _numberLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:15];
        _numberLabel.textColor = DSColorFromHex(0x464646);
        _numberLabel.text = @"申请编号：2018091111044323432";
    }
    return _numberLabel;
}
-(UILabel *)serviceDateLabel{
    if (!_serviceDateLabel) {
        _serviceDateLabel = [[UILabel alloc]init];
        _serviceDateLabel.textAlignment = NSTextAlignmentLeft;
        _serviceDateLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:12];
        _serviceDateLabel.textColor = DSColorFromHex(0x474747);
        _serviceDateLabel.text = @"服务时间： 9:00 - 22:00";
    }
    return _serviceDateLabel;
}
-(UIButton *)onlineBtn{
    if (!_onlineBtn) {
        _onlineBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _onlineBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [_onlineBtn setTitleColor:DSColorFromHex(0x464646) forState:UIControlStateNormal];
        [_onlineBtn setImage:[UIImage imageNamed:@"online_service"] forState:UIControlStateNormal];
        [_onlineBtn setTitle:@"在线客服" forState:UIControlStateNormal];
        [_onlineBtn.layer setCornerRadius:2];
        [_onlineBtn.layer setMasksToBounds:YES];
        [_onlineBtn.layer setBorderWidth:0.5];
        [_onlineBtn.layer setBorderColor:DSColorMake(180, 180, 180).CGColor];
        _onlineBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
    }
    return _onlineBtn;
}
-(UIButton *)phoneBtn{
    if (!_phoneBtn) {
        _phoneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _phoneBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [_phoneBtn setTitleColor:DSColorFromHex(0x464646) forState:UIControlStateNormal];
        [_phoneBtn setImage:[UIImage imageNamed:@"phone_service"] forState:UIControlStateNormal];
        [_phoneBtn setTitle:@"电话客服" forState:UIControlStateNormal];
        [_phoneBtn.layer setCornerRadius:2];
        [_phoneBtn.layer setMasksToBounds:YES];
        [_phoneBtn.layer setBorderWidth:0.5];
        [_phoneBtn.layer setBorderColor:DSColorMake(180, 180, 180).CGColor];
        _phoneBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
        [_phoneBtn addTarget:self action:@selector(pressPhone) forControlEvents:UIControlEventTouchUpInside];
    }
    return _phoneBtn;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.bgScrollow];
    [self.bgScrollow addSubview:self.titleView];
    [self.bgScrollow addSubview:self.priceView];
    [self.bgScrollow addSubview:self.goodsView];
    [self.bgScrollow addSubview:self.detailView];
    [self.titleView addSubview:self.toplabel];
    [self.titleView addSubview:self.topdate];
    [self.priceView addSubview:self.totallabel];
    [self.priceView addSubview:self.totalamount];
    
    [self.goodsView addSubview:self.goodlabel];
    [self.goodsView addSubview:self.topline];
    [self.goodsView addSubview:self.headImage];
    [self.goodsView addSubview:self.nameLabel];
    [self.goodsView addSubview:self.payableLabel];
    [self.goodsView addSubview:self.countLabel];
    
    [self.detailView addSubview:self.whylabel];
    [self.detailView addSubview:self.wxlabel];
    [self.detailView addSubview:self.balancelabel];
    [self.detailView addSubview:self.dateLabel];
    [self.detailView addSubview:self.numberLabel];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
