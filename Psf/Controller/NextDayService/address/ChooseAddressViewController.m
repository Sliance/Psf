//
//  ChooseAddressViewController.m
//  Psf
//
//  Created by 燕来秋mac9 on 2018/6/25.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "ChooseAddressViewController.h"
#import "ChooseCityHeadView.h"
#import "ChooseAddressTableViewCell.h"

@interface ChooseAddressViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableview;
@property(nonatomic,strong)ChooseCityHeadView *chooseView;
@end

@implementation ChooseAddressViewController
-(ChooseCityHeadView *)chooseView{
    if (!_chooseView) {
        _chooseView = [[ChooseCityHeadView alloc]initWithFrame:CGRectMake(0, 64, SCREENWIDTH, 46)];
    }
    return _chooseView;
}
-(UITableView *)tableview{
    if (!_tableview) {
        _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 11+[self navHeightWithHeight], SCREENWIDTH, SCREENHEIGHT-[self navHeightWithHeight]-[self tabBarHeight]) style:UITableViewStyleGrouped];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.separatorColor = [UIColor whiteColor];
        _tableview.tableFooterView = [[UIView alloc]init];
        _tableview.backgroundColor = DSColorFromHex(0xF0F0F0);
    }
    return _tableview;
}
-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
   [self.view addSubview:self.backBtn];
   
     [self setTextFieldLeftView:self.chooseView.searchField :@"search_icon":20];
    [self.view addSubview:self.tableview];
     [self.view addSubview:self.chooseView];

}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section ==2) {
        return 4;
    }
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 15;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section ==0) {
        return 44;
    }else if (indexPath.section ==1){
        return 65;
        
    }
    return 40;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section ==0) {
        return @"";
    }else if (section ==1){
        return @"我的收货地址";
    }
    return @"附近地址";
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section ==1) {
        static NSString *identify = @"ChooseAddressTableViewCell";
        ChooseAddressTableViewCell *choosecell = [tableView dequeueReusableCellWithIdentifier:identify];
        if (!choosecell) {
            choosecell = [[ChooseAddressTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
        }
        return choosecell;
    }
    static NSString *identify = @"identify";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    if (indexPath.section ==0) {
        cell.textLabel.text = @"当前：闵行区旭辉·浦江国际";
    }else if (indexPath.section ==2){
        cell.textLabel.text = @"江正地产";
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.textColor = DSColorFromHex(0x464646);
    cell.textLabel.font = [UIFont systemFontOfSize:14];
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
