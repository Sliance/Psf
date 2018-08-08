//
//  InvoiceViewController.m
//  Psf
//
//  Created by 燕来秋mac9 on 2018/8/6.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "InvoiceViewController.h"
#import "InvoiceRuleView.h"
#import "BottomView.h"

@interface InvoiceViewController ()<UIScrollViewDelegate,UITextFieldDelegate>
@property(nonatomic,strong)UIScrollView *bgscrollow;
@property(nonatomic,strong)UIView *bgview;
@property(nonatomic,assign)NSInteger type;
@property(nonatomic,strong)UILabel *kaiLabel;
@property(nonatomic,assign)BOOL iskai;
@property(nonatomic,strong)UISwitch *kaiswitch;
@property(nonatomic,strong)UILabel *invoiceLabel;
@property(nonatomic,strong)UIButton *singeleBtn;
@property(nonatomic,strong)UIButton *unitBtn;
@property(nonatomic,strong)UIButton *tmpBtn;
@property(nonatomic,strong)UITextField* singleField;
@property(nonatomic,strong)UITextField* taxpayersField;
@property(nonatomic,strong)UILabel *line1Label;
@property(nonatomic,strong)UILabel *line2Label;
@property(nonatomic,strong)UILabel *line3Label;
@property(nonatomic,strong)InvoiceRuleView *ruleView;
@property(nonatomic,strong)BottomView *bottomView;
@end

@implementation InvoiceViewController
-(UIScrollView *)bgscrollow{
    if (!_bgscrollow) {
        _bgscrollow = [[UIScrollView alloc]init];
        _bgscrollow.delegate =self;
        _bgscrollow.frame = CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT);
        _bgscrollow.backgroundColor = DSColorFromHex(0xF0F0F0);
    }
    return _bgscrollow;
}
-(InvoiceRuleView *)ruleView{
    if (!_ruleView) {
        _ruleView = [[InvoiceRuleView alloc]init];
    }
    return _ruleView;
}
-(BottomView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[BottomView alloc]init];
        _bottomView.frame = CGRectMake(0, SCREENHEIGHT-[self tabBarHeight], SCREENWIDTH, [self tabBarHeight]);
        [_bottomView.bottomBtn setTitle:@"保存" forState:UIControlStateNormal];
        [_bottomView.bottomBtn addTarget:self action:@selector(pressBottom) forControlEvents:UIControlEventTouchUpInside];
    }
    return _bottomView;
}
-(UIView *)bgview{
    if (!_bgview) {
        _bgview = [[UIView alloc]init];
        _bgview.frame = CGRectMake(0, 0, SCREENWIDTH, 44);
        _bgview.backgroundColor = [UIColor whiteColor];
    }
    return _bgview;
}
-(UILabel *)kaiLabel{
    if (!_kaiLabel) {
        _kaiLabel = [[UILabel alloc]init];
        _kaiLabel.text = @"开具发票";
        _kaiLabel.textColor = DSColorFromHex(0x464646);
        _kaiLabel.font = [UIFont systemFontOfSize:15];
        _kaiLabel.frame = CGRectMake(15, 0, SCREENWIDTH-80, 44);
    }
    return _kaiLabel;
}
-(UILabel *)invoiceLabel{
    if (!_invoiceLabel) {
        _invoiceLabel = [[UILabel alloc]init];
        _invoiceLabel.text = @"*发票抬头";
        _invoiceLabel.textColor = DSColorFromHex(0x979797);
        _invoiceLabel.font = [UIFont systemFontOfSize:15];
        _invoiceLabel.frame = CGRectMake(15, 44, 80, 44);
        _invoiceLabel.hidden = YES;
    }
    return _invoiceLabel;
}
-(UIButton *)singeleBtn{
    if (!_singeleBtn) {
        _singeleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_singeleBtn setTitle:@"个人" forState:UIControlStateNormal];
        [_singeleBtn setTitleColor:DSColorFromHex(0x464646) forState:UIControlStateNormal];
        [_singeleBtn setTitleColor:DSColorFromHex(0xFF4C4D) forState:UIControlStateSelected];
        [_singeleBtn.layer setCornerRadius:2];
        [_singeleBtn.layer setMasksToBounds:YES];
        [_singeleBtn.layer setBorderColor:DSColorFromHex(0xFF4C4D).CGColor];
        [_singeleBtn.layer setBorderWidth:0.5];
        [_singeleBtn addTarget:self action:@selector(pressBtn:) forControlEvents:UIControlEventTouchUpInside];
        _singeleBtn.frame = CGRectMake(100, 51, 60, 30);
        _singeleBtn.selected = YES;
        _singeleBtn.hidden = YES;
        _singeleBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    }
    return _singeleBtn;
}
-(UIButton *)unitBtn{
    if (!_unitBtn) {
        _unitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_unitBtn setTitle:@"单位" forState:UIControlStateNormal];
        [_unitBtn setTitleColor:DSColorFromHex(0x464646) forState:UIControlStateNormal];
        [_unitBtn setTitleColor:DSColorFromHex(0xFF4C4D) forState:UIControlStateSelected];
        [_unitBtn.layer setCornerRadius:2];
        [_unitBtn.layer setMasksToBounds:YES];
        [_unitBtn.layer setBorderColor:DSColorFromHex(0x464646).CGColor];
        [_unitBtn.layer setBorderWidth:0.5];
        [_unitBtn addTarget:self action:@selector(pressBtn:) forControlEvents:UIControlEventTouchUpInside];
        _unitBtn.frame = CGRectMake(175, 51, 60, 30);
        _unitBtn.hidden = YES;
        _unitBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    }
    return _unitBtn;
}
-(UISwitch *)kaiswitch{
    if (!_kaiswitch) {
        _kaiswitch = [[UISwitch alloc]initWithFrame:CGRectMake(SCREENWIDTH-55, 6, 40, 20)];
        [_kaiswitch addTarget:self action:@selector(pressSwitch:) forControlEvents:UIControlEventValueChanged];
    }
    return _kaiswitch;
}
-(UITextField *)singleField{
    if (!_singleField) {
        _singleField = [[UITextField alloc]init];
        _singleField.delegate = self;
        _singleField.frame = CGRectMake(15, 88, SCREENWIDTH-30, 44);
        _singleField.placeholder = @"请输入个人姓名";
        _singleField.font = [UIFont systemFontOfSize:15];
        _singleField.hidden = YES;
    }
    return _singleField;
}
-(UITextField *)taxpayersField{
    if (!_taxpayersField) {
        _taxpayersField = [[UITextField alloc]init];
        _taxpayersField.delegate = self;
        _taxpayersField.frame = CGRectMake(15, 132, SCREENWIDTH-30, 44);
        _taxpayersField.placeholder = @"*纳税人识别号 或 统一社会信用代码";
        _taxpayersField.hidden = YES;
        _taxpayersField.font = [UIFont systemFontOfSize:15];
    }
    return _taxpayersField;
}
-(UILabel *)line1Label{
    if (!_line1Label) {
        _line1Label = [[UILabel alloc]init];
        _line1Label.backgroundColor = DSColorFromHex(0xF0F0F0);
        _line1Label.frame = CGRectMake(15, 44, SCREENWIDTH-15, 1);
        _line1Label.hidden = YES;
    }
    return _line1Label;
}
-(UILabel *)line2Label{
    if (!_line2Label) {
        _line2Label = [[UILabel alloc]init];
        _line2Label.backgroundColor = DSColorFromHex(0xF0F0F0);
        _line2Label.frame = CGRectMake(15, 88, SCREENWIDTH-15, 1);
        _line2Label.hidden = YES;
    }
    return _line2Label;
}
-(UILabel *)line3Label{
    if (!_line3Label) {
        _line3Label = [[UILabel alloc]init];
        _line3Label.backgroundColor = DSColorFromHex(0xF0F0F0);
        _line3Label.frame = CGRectMake(15, 132, SCREENWIDTH-15, 1);
        _line3Label.hidden = YES;
    }
    return _line3Label;
}
-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self setNavWithTitle:@"发票信息"];
        
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.bgscrollow];
    [self.bgscrollow addSubview:self.bgview];
    [self.bgview addSubview:self.kaiLabel];
    [self.bgview addSubview:self.kaiswitch];
    [self.bgview addSubview:self.invoiceLabel];
    [self.bgview addSubview:self.singeleBtn];
    [self.bgview addSubview:self.unitBtn];
    [self.bgview addSubview:self.singleField];
    [self.bgview addSubview:self.taxpayersField];
    [self.bgview addSubview:self.line3Label];
    [self.bgview addSubview:self.line2Label];
    [self.bgview addSubview:self.line1Label];
    [self.bgscrollow addSubview:self.ruleView];
    [self reloadView];
    [self.view addSubview:self.bottomView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFiledTextChange:) name:UITextFieldTextDidChangeNotification object:nil];
}
- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
}
//
- (void)textFiledTextChange:(NSNotification *)noti{
    if (_iskai==YES&&_type ==0){
        _placemodel.saleOrderInvoiceUserName = _singleField.text;
    }else if (_iskai==YES&&_type ==1){
        _placemodel.saleOrderInvoiceCompanyName = _singleField.text;
        _placemodel.saleOrderInvoiceCompanyTax = _taxpayersField.text;
    }
}

-(void)setPlacemodel:(PlaceOrderReq *)placemodel{
    _placemodel = placemodel;
    _iskai = _placemodel.saleOrderIsInvoice;
    _type = _placemodel.saleOrderInvoiceType;
    [self reloadView];
    if (_type==0) {
        _singleField.text = _placemodel.saleOrderInvoiceUserName;
    }else if (_type ==1){
        _singleField.text = _placemodel.saleOrderInvoiceCompanyName;
        _taxpayersField.text = _placemodel.saleOrderInvoiceCompanyTax;
    }
    [self reloadView];
}
-(void)reloadView{
    self.kaiswitch.on = _iskai;
    if (_iskai==YES&&_type ==0){
        self.bgview.frame = CGRectMake(0, 0, SCREENWIDTH, 132);
        self.singleField.placeholder = @"请输入个人姓名";
        self.invoiceLabel.hidden = NO;
        self.singeleBtn.hidden = NO;
        self.unitBtn.hidden = NO;
        self.singleField.hidden = NO;
        self.taxpayersField.hidden = YES;
        self.line1Label.hidden = NO;
        self.line2Label.hidden = NO;
        self.line3Label.hidden = YES;
        _tmpBtn =_singeleBtn;
    }else if (_iskai==YES&&_type ==1){
        self.bgview.frame = CGRectMake(0, 0, SCREENWIDTH, 176);
        self.singleField.placeholder = @"请输入单位名称";
        self.invoiceLabel.hidden = NO;
        self.singeleBtn.hidden = NO;
        self.unitBtn.hidden = NO;
        self.singleField.hidden = NO;
        self.taxpayersField.hidden = NO;
        self.line1Label.hidden = NO;
        self.line2Label.hidden = NO;
        self.line3Label.hidden = NO;
        _tmpBtn = _unitBtn;
    }else{
         self.bgview.frame = CGRectMake(0, 0, SCREENWIDTH, 44);
        self.invoiceLabel.hidden = YES;
        self.singeleBtn.hidden = YES;
        self.unitBtn.hidden = YES;
        self.singleField.hidden = YES;
        self.taxpayersField.hidden = YES;
        self.line1Label.hidden = YES;
        self.line2Label.hidden = YES;
        self.line3Label.hidden = YES;
    }
    self.ruleView.frame = CGRectMake(0, self.bgview.ctBottom, SCREENWIDTH, 200);
}
-(void)pressSwitch:(UISwitch*)sender{
    sender.on = !sender.on;
    _iskai = sender.on;
    _placemodel.saleOrderIsInvoice = _iskai;
    [self reloadView];
}

-(void)pressBtn:(UIButton*)sender{
    _singeleBtn.selected = NO;
    [_singeleBtn.layer setBorderColor:DSColorFromHex(0x464646).CGColor];
    if (_tmpBtn == nil){
        sender.selected = YES;
        [sender.layer setBorderColor:DSColorFromHex(0xFF4C4D).CGColor];
        _tmpBtn = sender;
    }else if (_tmpBtn !=nil && _tmpBtn == sender){
        sender.selected = YES;
         [sender.layer setBorderColor:DSColorFromHex(0xFF4C4D).CGColor];
    }else if (_tmpBtn!= sender && _tmpBtn!=nil){
        _tmpBtn.selected = NO;
         [_tmpBtn.layer setBorderColor:DSColorFromHex(0x464646).CGColor];
        sender.selected = YES;
         [sender.layer setBorderColor:DSColorFromHex(0xFF4C4D).CGColor];
        _tmpBtn = sender;
    }
    if (_tmpBtn== _singeleBtn) {
        _type =0;
       
        
    }else if (_tmpBtn==_unitBtn){
        _type = 1;
        
    }
    _singleField.text = @"";
    _placemodel.saleOrderInvoiceType = _type;
    [self reloadView];
}
-(void)pressBottom{
    if (_type ==0) {
        if (_singleField.text.length<1) {
            [self showInfo:@"请输入个人姓名"];
            return;
        }
    }else if (_type ==1){
        if (_singleField.text.length<1) {
            [self showInfo:@"请输入单位名称"];
            return;
        }
        if (_taxpayersField.text.length<1) {
            [self showInfo:@"请输入税号"];
            return;
        }
    }
    self.submintBlock(_placemodel);
    [self.navigationController popViewControllerAnimated:YES];
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
