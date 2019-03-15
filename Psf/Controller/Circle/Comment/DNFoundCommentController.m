//
//  DNFoundCommentController.m
//  DnaerApp
//
//  Created by 燕来秋 on 2018/11/2.
//  Copyright © 2018 燕来秋. All rights reserved.
//

#import "DNFoundCommentController.h"

#import "DNCommentHeadView.h"
#import "DNFoundCommentCell.h"
#import "DNCommentInputBar.h"
#import "NextServiceApi.h"
#import "DNCommentList.h"
#import "ZSConfig.h"
@interface DNFoundCommentController ()<UITextFieldDelegate>
//底部View
@property (nonatomic ,strong) UIView *deliverView;
//遮罩
@property (nonatomic ,strong) UIView *BGView;
@property (nonatomic ,strong) NSMutableArray *dataArr;
@property (nonatomic ,strong) UILabel *titleLabel;
@property (nonatomic ,strong) UILabel *lineLabel;
@property (nonatomic ,strong) UIButton *closeBtn;
@property (nonatomic ,strong) UIButton *rightBtn;
@property (nonatomic ,strong) UITableView *tableView;
@property (nonatomic ,strong) DNCommentInputBar *bottomInput;
@property (nonatomic, assign) NSInteger pageIndex;
@property (nonatomic, strong) NSString *commentId;

@end

@implementation DNFoundCommentController


- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,32, SCREENWIDTH, SCREENHEIGHT/2-32-TabbarHeight) style:UITableViewStyleGrouped];
        _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
        _tableView.tableViewAdapter.headerHeight = 0.01;
        _tableView.tableViewAdapter.footerHeight = 0.01;
        _tableView.backgroundColor = UIColor.whiteColor;
        _tableView.eventTransmissionBlock = [self handleTabViewEventTransmissionBlock];
        _tableView.tableViewDidSelectRowBlock = [self tableViewDidSelectRowBlock];
    }
    return _tableView;
}
-(DNCommentInputBar *)bottomInput{
    if (!_bottomInput) {
        _bottomInput = [[DNCommentInputBar alloc]initWithFrame:CGRectMake(0,SCREENHEIGHT/2-TabbarHeight, SCREENWIDTH, TabbarHeight)];
        _bottomInput.inputField.delegate = self;
        _bottomInput.backgroundColor = [UIColor whiteColor];
        WEAKSELF;
        [_bottomInput setSendBlock:^(NSString * content) {
            [weakSelf goToRepaly:content];
        }];
    }
    return _bottomInput;
}
-(UIButton *)closeBtn{
    if (!_closeBtn) {
        _closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_closeBtn setImage:[UIImage imageNamed:@"label_delete"] forState:UIControlStateNormal];
        [_closeBtn addTarget:self action:@selector(quit) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeBtn;
}
-(UIButton *)rightBtn{
    if (!_rightBtn) {
        _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_rightBtn setImage:[UIImage imageNamed:@"found_comment_sort"] forState:UIControlStateNormal];
        [_rightBtn addTarget:self action:@selector(pressSort) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightBtn;
}
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = [UIFont systemFontOfSize:12];
        _titleLabel.textColor = DSColorFromHex(0x454545);
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.text = @"评论";
    }
    return _titleLabel;
}
-(UILabel *)lineLabel{
    if (!_lineLabel) {
        _lineLabel = [[UILabel alloc]init];
        _lineLabel.backgroundColor = DSColorFromHex(0xF0F0F0);
    }
    return _lineLabel;
}
-(UIView *)BGView{
    if (!_BGView) {
        _BGView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
        _BGView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.0];
    }
    return _BGView;
}
-(UIView *)deliverView{
    if (!_deliverView) {
        _deliverView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREENHEIGHT, SCREENWIDTH, SCREENHEIGHT/2)];
        [_deliverView setCorner:UIRectCornerTopLeft|UIRectCornerTopRight radius:8];
        _deliverView.backgroundColor = [UIColor whiteColor];
        
    }
    return _deliverView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArr = [[NSMutableArray alloc]init];
    self.tableView.cellDatas = self.dataArr;
    self.tableView.headerDatas = self.dataArr;
    self.tableView.footerDatas = self.dataArr;
     [self setLayout];
    [self configTableView];
    [self.tableView.mj_header beginRefreshing];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHidden:) name:UIKeyboardWillHideNotification object:nil];
}
- (void)keyboardWillShow:(NSNotification *)notification
{
    CGRect keyboardFrame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat  keyboardHeight = keyboardFrame.size.height;
    CGFloat duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:duration animations:^{
        self.BGView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
        self.deliverView.frame = CGRectMake(0, SCREENHEIGHT/2-keyboardHeight, SCREENWIDTH, SCREENHEIGHT/2);
        
    } completion:^(BOOL finished) {
    }];
    
    
}

- (void)keyboardWillHidden:(NSNotification *)notification
{
    CGFloat duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:duration animations:^{
        self.BGView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
        self.deliverView.frame = CGRectMake(0, SCREENHEIGHT/2, SCREENWIDTH, SCREENHEIGHT/2);
        
    } completion:^(BOOL finished) {
    }];
}
-(void)configTableView {
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    WEAKSELF
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakSelf.pageIndex = 1;
        [weakSelf requestData];
    }];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        weakSelf.pageIndex++;
        [weakSelf requestData];
    }];
    self.tableView.mj_footer.hidden = YES;

}

-(void)setContentId:(NSString *)contentId{
    _contentId = contentId;
}
-(void)requestData{
    StairCategoryReq *bean = [[StairCategoryReq alloc]init];
    bean.pageIndex = self.pageIndex;
    bean.pageSize = @"10";
    bean.token = [UserCacheBean share].userInfo.token;
    bean.platform = @"ios";
    bean.appId = @"993335466657415169";
    bean.cityName = @"上海市";
    bean.cityId = @"310100";
    bean.timestamp = @"0";
    bean.memberCommentTypeId = self.contentId;
    WEAKSELF;
    [[NextServiceApi share] getCommentListWithParam:bean response:^(id response) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        if (response) {
            if (self.pageIndex ==1) {
                [weakSelf.dataArr removeAllObjects];
                [weakSelf.dataArr addObjectsFromArray:response];
                [weakSelf.tableView.mj_header endRefreshing];
            } else {
                [weakSelf.dataArr addObjectsFromArray:response];
            }
            if ([response count] <10) {
                [weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];
            }
        }
        weakSelf.tableView.cellDatas = weakSelf.dataArr;
        weakSelf.tableView.headerDatas = weakSelf.dataArr;
        [weakSelf.tableView reloadData];
    }];
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    // 浮现
    [UIView animateWithDuration:0.3 animations:^{
        self.BGView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
        self.deliverView.frame = CGRectMake(0, SCREENHEIGHT/2, SCREENWIDTH, SCREENHEIGHT/2);
        
    } completion:^(BOOL finished) {
    }];
}
-(void)setLayout{
    [self.view addSubview:self.BGView];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(quit)];
    [self.BGView addGestureRecognizer:tap];
    [self.view addSubview:self.deliverView];
    [self.deliverView addSubview:self.titleLabel];
    [self.deliverView addSubview:self.lineLabel];
    [self.deliverView addSubview:self.closeBtn];
    [self.deliverView addSubview:self.rightBtn];
    [self.deliverView addSubview:self.tableView];
    [self.deliverView addSubview:self.bottomInput];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.deliverView).offset(20);
        make.right.equalTo(self.deliverView).offset(-20);
        make.top.equalTo(self.deliverView);
        make.height.mas_equalTo(31);
    }];
    [self.closeBtn  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.deliverView);
        make.height.mas_equalTo(31);
        make.width.mas_equalTo(36);
    }];
    [self.rightBtn  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.equalTo(self.deliverView);
        make.height.mas_equalTo(31);
        make.width.mas_equalTo(44);
    }];
    [self.lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.deliverView);
        make.right.equalTo(self.deliverView);
        make.top.equalTo(self.deliverView).offset(31);
        make.height.mas_equalTo(0.3);
    }];
    
}
-(void)quit
{
    [UIView animateWithDuration:0.5 animations:^{
        self.BGView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.0];
        self.deliverView.frame = CGRectMake(0, SCREENHEIGHT, SCREENWIDTH, SCREENHEIGHT/2);
    } completion:^(BOOL finished) {
        
        [self dismissViewControllerAnimated:NO completion:nil];
        
    }];
}

- (void)beginEditing:(NSNotification *)notification {
    

}
-(void)pressSort{
    
}
-(CHGTableViewDidSelectRowBlock)tableViewDidSelectRowBlock {
    [self.view endEditing:YES];
    return nil;
}
/// 处理tableView触发的事件
-(CHGEventTransmissionBlock)handleTabViewEventTransmissionBlock {
    WEAKSELF
    [self.view endEditing:YES];
    return ^id(id target, id params, NSInteger tag, CHGCallBack callBack) {
        
        if ([target isKindOfClass:[DNCommentHeadView class]]) {
            DNCommentList*model = params;
            if (tag ==1) {
                [weakSelf pressZan:model.memberCommentId];
            }else if (tag ==0){
                weakSelf.commentId = model.memberCommentId;
                [weakSelf.bottomInput.inputField becomeFirstResponder];
            }
        }else if ([target isKindOfClass:[DNFoundCommentCell class]]) {
            DNCommentExtsReplysModel*model = params;
            weakSelf.commentId = model.memberCommentId;
            [weakSelf.bottomInput.inputField becomeFirstResponder];
        }
        return nil;
    };
}
-(void)goToRepaly:(NSString*)content{
    StairCategoryReq *req = [[StairCategoryReq alloc]init];
    req.token = [UserCacheBean share].userInfo.token;
    req.platform = @"ios";
    req.appId = @"993335466657415169";
    req.cityName = @"上海市";
    req.cityId = @"310100";
    req.timestamp = @"0";
    req.erpStoreId = [UserCacheBean share].userInfo.erpStoreId;
    req.memberCommentType = @"EPICURE";
    req.memberCommentTypeId = self.contentId;
    req.memberCommentId = self.commentId;
    req.commentContent = content;
    WEAKSELF;
    [[NextServiceApi share]addCommenttWithParam:req response:^(id response) {
        if ([response[@"code"]integerValue] ==200) {
            [weakSelf showInfo:@"评论成功"];
            [weakSelf.tableView.mj_header beginRefreshing];
            [weakSelf.view endEditing:YES];
            weakSelf.bottomInput.inputField.text = @"";
            weakSelf.commentId = @"";
        }else{
            [weakSelf showInfo:response[@"message"]];
        }
    }];
}
-(void)pressZan:(NSString*)commentId{
    StairCategoryReq *req = [[StairCategoryReq alloc]init];
    req.token = [UserCacheBean share].userInfo.token;
    req.platform = @"ios";
    req.appId = @"993335466657415169";
    req.cityName = @"上海市";
    req.cityId = @"310100";
    req.timestamp = @"0";
    req.erpStoreId = [UserCacheBean share].userInfo.erpStoreId;
    req.referenceType = @"EPICURE_COMMENT";
    req.referenceId = commentId;
    WEAKSELF;
    [[NextServiceApi share]likeDetailRecipeWithParam:req response:^(id response) {
        if ([response[@"code"]integerValue] ==200) {
            [weakSelf showInfo:response[@"data"][@"operationType"]];
            [weakSelf.tableView.mj_header beginRefreshing];
        }else{
            [weakSelf showInfo:response[@"message"]];
        }
        
    }];
}

/**
 显示提示
 */
- (void)showInfo:(NSString *)info{
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:window animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.userInteractionEnabled = NO;
    hud.label.text = info;
    hud.yOffset = -85;
    [hud hide:YES afterDelay:3];
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
#if ! __has_feature(objc_arc)
    [super dealloc];
#endif
}
@end
