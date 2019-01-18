//
//  DetailRecipeController.m
//  Psf
//
//  Created by zhangshu on 2019/1/15.
//  Copyright © 2019 zhangshu. All rights reserved.
//

#import "DetailRecipeController.h"
#import "NextServiceApi.h"
#import "DetailRecipeHeadView.h"
#import "DetailRecipeCell.h"
#import "detailGoodsViewController.h"

@interface DetailRecipeController ()<UITableViewDelegate,UITableViewDataSource,UIWebViewDelegate>
@property(nonatomic,strong)DetailRecipeRes *result;
@property(nonatomic,strong)DetailRecipeHeadView*headView;
@property(nonatomic,strong)UITableView*tableview;
@property(nonatomic,strong)UIWebView*webView;
@property(nonatomic,strong)UIView*footView;

@end

@implementation DetailRecipeController
-(DetailRecipeHeadView *)headView{
    if (!_headView) {
        _headView = [[DetailRecipeHeadView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENWIDTH+40)];
    }
    return _headView;
}
-(UIView *)footView{
    if (!_footView) {
        _footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, SCREENWIDTH, 5)];
        label.backgroundColor = DSColorFromHex(0xFAFAFA);
        [_footView addSubview:label];
        _footView.backgroundColor = [UIColor whiteColor];
    }
    return _footView;
}
-(UITableView *)tableview{
    if (!_tableview) {
        _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT) style:UITableViewStylePlain];
        [_tableview registerClass:[DetailRecipeCell class] forCellReuseIdentifier:NSStringFromClass([DetailRecipeCell class])];
        _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableview.delegate = self;
        _tableview.dataSource = self;
    }
    return _tableview;
}
-(UIWebView *)webView{
    if (!_webView) {
        _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 35, SCREENWIDTH, SCREENHEIGHT)];
        _webView.delegate = self;
//        _webView.scrollView.scrollEnabled = NO;
    }
    return _webView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableview];
    self.tableview.tableHeaderView = self.headView;
    self.tableview.tableFooterView = self.footView;
    [self.footView addSubview:self.webView];
    WEAKSELF;
    [self.headView setHeighrBlock:^(CGFloat height) {
        weakSelf.headView.frame = CGRectMake(0, 0, SCREENWIDTH, height);
    }];
    
   
}
-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.view.backgroundColor = [UIColor whiteColor];
        
        [self setTitle:@"详情"];
        
    }
    return self;
}

-(void)setEpicureId:(NSString *)epicureId{
    _epicureId = epicureId;
    [self requestData];
}

-(void)requestData{
    StairCategoryReq *req = [[StairCategoryReq alloc]init];
    req.token = [UserCacheBean share].userInfo.token;
    req.platform = @"ios";
    req.appId = @"993335466657415169";
    req.cityName = @"上海市";
    req.cityId = @"310100";
    req.timestamp = @"0";
    req.erpStoreId = [UserCacheBean share].userInfo.erpStoreId;
    req.pageIndex = 1;
    req.pageSize = @"10";
    req.sign = @"ffc18def63af3916f4d39165697f228f";
    req.epicureId = self.epicureId;
    WEAKSELF;
    [[NextServiceApi share]getDetailRecipeWithParam:req response:^(id response) {
        if (response) {
            weakSelf.result = response;
            [weakSelf.headView setModel:weakSelf.result];
            NSString *html_str = [NSString stringWithFormat:@"<head><style>img{width:%fpx !important;}</style></head>%@",SCREENWIDTH-15,self.result.howTOMake];
            [weakSelf.webView loadHTMLString:html_str baseURL:nil];
        }
        [weakSelf.tableview reloadData];
    }];
}
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    self.webView.frame = CGRectMake(0, 35, SCREENWIDTH, self.webView.scrollView.contentSize.height);
    self.footView.frame = CGRectMake(0, 0, SCREENWIDTH, self.webView.scrollView.contentSize.height+35);
    self.tableview.tableFooterView = self.footView;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
   return  self.result.epicureMobileV1IngredientsInfoWrappers.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DetailRecipeCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([DetailRecipeCell class])];
    EpicureProductModel*model = self.result.epicureMobileV1IngredientsInfoWrappers[indexPath.row];
    [cell setModel:model];
    WEAKSELF;
    [cell setSelectedCollect:^(NSInteger productID) {
        detailGoodsViewController *vc = [[detailGoodsViewController alloc]init];
        [vc setProductID:productID];
        vc.hidesBottomBarWhenPushed = YES;
        [weakSelf.navigationController pushViewController:vc animated:YES];
    }];
    return cell;
}
@end
