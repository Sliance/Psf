//
//  EvaluateViewController.m
//  Psf
//
//  Created by 燕来秋mac9 on 2018/6/26.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "EvaluateViewController.h"
#import "EvaluateTableViewCell.h"
#import "EvaluateListHeadView.h"
#import "FillEvaluateController.h"
#import "StairCategoryReq.h"
#import "NextServiceApi.h"
#import "EvaluateListModel.h"

@interface EvaluateViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableview;

@property(nonatomic,strong)EvaluateListHeadView *headView;
@property(nonatomic,strong)EvaluateListRes *evaRes;
@property(nonatomic,strong)NSMutableArray *imageDataArr;
@property(nonatomic,strong)NSMutableArray *contentDataArr;
@property(nonatomic,assign) NSInteger type;

@end

@implementation EvaluateViewController

-(UITableView *)tableview{
    if (!_tableview) {
        _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0,[self navHeightWithHeight], SCREENWIDTH, SCREENHEIGHT-[self navHeightWithHeight]) style:UITableViewStylePlain];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.tableFooterView = [[UIView alloc]init];
        _tableview.separatorColor = DSColorFromHex(0xF0F0F0);
        _tableview.backgroundColor = DSColorFromHex(0xF0F0F0);
    }
    return _tableview;
}
-(EvaluateListHeadView *)headView{
    if (!_headView) {
        _headView = [[EvaluateListHeadView alloc]init];
        _headView.frame = CGRectMake(0, 0, SCREENWIDTH, 91);
    }
    return _headView;
}
-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self setTitle:@"评价"];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    if (@available(iOS 11.0, *)) {
        _tableview.contentInsetAdjustmentBehavior = NO;
    } else {
        self.navigationController.navigationBar.translucent = NO;
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    [self.view addSubview:self.tableview];
    _imageDataArr = [NSMutableArray array];
    _contentDataArr = [NSMutableArray array];
    self.tableview.tableHeaderView = self.headView;
    self.type = 0;
}
- (void)setProductId:(NSInteger)productId{
    _productId = productId;
    [self requestEvaluate];
}
-(void)requestEvaluate{
    StairCategoryReq *req = [[StairCategoryReq alloc]init];
    req.appId = @"993335466657415169";
    req.timestamp = @"529675086";
    req.token = [UserCacheBean share].userInfo.token;
    req.version = @"1.0.0";
    req.platform = @"ios";
    req.couponType = @"allProduct";
    req.saleOrderStatus = @"0";
    req.userLongitude = @"121.4737";
    req.userLatitude = @"31.23037";
    req.productId = _productId;
    req.pageIndex = 1;
    req.pageSize = @"10";
    req.productCategoryParentId = @"";
    req.saleOrderId = @"1013703405872041985";
    req.cityId = @"310100";
    req.cityName = @"上海市";
    __weak typeof(self)weakself = self;
    [[NextServiceApi share]requestEvaluateListModelListLoadWithParam:req response:^(id response) {
      
        weakself.evaRes = response;
        [weakself updateData];
    }];
    [self.headView setChooseTypeBlock:^(NSInteger index) {
        weakself.type = index;
        [weakself.tableview reloadData];
    }];
}
-(void)updateData{
    [self.imageDataArr removeAllObjects];
    [self.contentDataArr removeAllObjects];
    for (EvaluateListModel *model in self.evaRes.saleOrderProductCommentList) {
        if (model.saleOrderProductCommentImageList.count>0) {
            [self.imageDataArr addObject:model];
        }else if(model.saleOrderProductCommentImageList.count==0&&model.saleOrderProductCommentContent.length>0&&![model.saleOrderProductCommentContent isEqualToString:@"此用户没有填写评价。"]){
            [self.contentDataArr addObject:model];
        }
        
    }
    [self.headView.allBtn setTitle:[NSString stringWithFormat:@"全部（%ld）",self.evaRes.saleOrderProductCommentList.count] forState:UIControlStateNormal];
    [self.headView.photoBtn setTitle:[NSString stringWithFormat:@"有图（%ld）",self.imageDataArr.count] forState:UIControlStateNormal];
    [self.headView.contentBtn setTitle:[NSString stringWithFormat:@"有内容（%ld）",self.contentDataArr.count] forState:UIControlStateNormal];
    self.headView.titleLabel.text = [NSString stringWithFormat:@"%.1f%% 好评",self.evaRes.rate.floatValue*100];
    if (self.evaRes.rate.floatValue >=0.8&&self.evaRes.rate.floatValue <1) {
        self.headView.ratingView.rating = 4;
    }else if (self.evaRes.rate.floatValue >=0.6&&self.evaRes.rate.floatValue <0.8){
        self.headView.ratingView.rating = 3;
    }else if (self.evaRes.rate.floatValue >=0.4&&self.evaRes.rate.floatValue <0.6){
        self.headView.ratingView.rating = 2;
    }else if (self.evaRes.rate.floatValue >=0.2&&self.evaRes.rate.floatValue <0.4){
        self.headView.ratingView.rating = 1;
    }else if (self.evaRes.rate.floatValue >=0&&self.evaRes.rate.floatValue <0.2){
        self.headView.ratingView.rating = 0;
    }else if (self.evaRes.rate.floatValue ==1){
        self.headView.ratingView.rating = 5;
    }

    [self.tableview reloadData];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.type ==1) {
        return self.imageDataArr.count;
    }else if (self.type ==2){
        return self.contentDataArr.count;
    }
    return self.evaRes.saleOrderProductCommentList.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 15;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.type ==1) {
        EvaluateListModel *model = self.imageDataArr[indexPath.row];
       return  [EvaluateTableViewCell getCellHeightWithData:model];
    }else if (self.type ==2){
        EvaluateListModel *model = self.contentDataArr[indexPath.row];
      return [EvaluateTableViewCell getCellHeightWithData:model];
    }
    EvaluateListModel *model = self.evaRes.saleOrderProductCommentList[indexPath.row];
    return [EvaluateTableViewCell getCellHeightWithData:model];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identify = @"EvaluateTableViewCell";
    EvaluateTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell) {
        cell = [[EvaluateTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identify];
    }
    if (self.type ==1) {
       EvaluateListModel *model = self.imageDataArr[indexPath.row];
        [cell setModel:model];
    }else if (self.type ==2){
        EvaluateListModel *model = self.contentDataArr[indexPath.row];
        [cell setModel:model];
    }else{
        EvaluateListModel *model = self.evaRes.saleOrderProductCommentList[indexPath.row];
        [cell setModel:model];
    }
    
    
    cell.accessoryType = UITableViewCellAccessoryNone;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
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
