//
//  MineInformationController.m
//  Psf
//
//  Created by 燕来秋mac9 on 2018/6/26.
//  Copyright © 2018年 zhangshu. All rights reserved.
//

#import "MineInformationController.h"
#import "HeadimageTableViewCell.h"
#import "BottomView.h"
#import "MineServiceApi.h"
#import "UploadImageTool.h"
#import "UIImage+Resize.h"
@interface MineInformationController ()<UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate,UIImagePickerControllerDelegate>
@property(nonatomic,strong)UITableView *tableview;
@property(nonatomic,strong)NSArray *dataArr;
@property(nonatomic,strong)BottomView *bottomView;
@property(nonatomic,strong)MineInformationReq *result;
@property(nonatomic,strong)NSString *headerIconUrl;
@end

@implementation MineInformationController
-(BottomView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[BottomView alloc]init];
        _bottomView.frame = CGRectMake(0, SCREENHEIGHT-[self tabBarHeight], SCREENWIDTH, [self tabBarHeight]);
        [_bottomView.bottomBtn setTitle:@"保存" forState:UIControlStateNormal];
        [_bottomView.bottomBtn addTarget:self action:@selector(pressSubmit) forControlEvents:UIControlEventTouchUpInside];
    }
    return _bottomView;
}
-(UITableView *)tableview{
    if (!_tableview) {
        _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0,0, SCREENWIDTH, SCREENHEIGHT-[self tabBarHeight]) style:UITableViewStylePlain];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.separatorColor = DSColorFromHex(0xF0F0F0);
        _tableview.tableFooterView = [[UIView alloc]init];
        _tableview.backgroundColor = DSColorFromHex(0xF0F0F0);
    }
    return _tableview;
}
-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self setNavWithTitle:@"个人信息"];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableview];
    [self.view addSubview:self.bottomView];
    _dataArr = @[@"头像",@"昵称",@"性别",@"生日"];
    [self requestData];
}
-(void)requestData{
    StairCategoryReq *req = [[StairCategoryReq alloc]init];
    req.appId = @"993335466657415169";
    req.timestamp = @"529675086";
    req.token = [UserCacheBean share].userInfo.token;
    req.version = @"1.0.0";
    req.platform = @"ios";
    req.cityId = @"310100";
    req.cityName = @"上海市";
    __weak typeof(self)weakself = self;
    [[MineServiceApi share]getMemberInformationWithParam:req response:^(id response) {
        if (response) {
            weakself.result = [[MineInformationReq alloc]init];
            weakself.result = response;
            [weakself.tableview reloadData];
        }
    }];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 4;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 15;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row ==0) {
        return 85;
    }
    return 45;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row ==0) {
        static NSString *identify = @"HeadimageTableViewCell";
        HeadimageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
        if (!cell) {
            cell = [[HeadimageTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identify];
        }
        [cell setResult:self.result];
        return cell;
    }
    static NSString *identify = @"identify";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identify];
    }
    
 
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.textColor = DSColorFromHex(0x454545);
    cell.textLabel.font = [UIFont systemFontOfSize:13];
    cell.textLabel.text = _dataArr[indexPath.row];
    cell.detailTextLabel.textColor = DSColorFromHex(0x454545);
    cell.detailTextLabel.font = [UIFont systemFontOfSize:13];
    switch (indexPath.row) {
        case 1:
        {
          cell.detailTextLabel.text = self.result.memberNickName;
        }
            break;
        case 2:
        {
          cell.detailTextLabel.text = self.result.memberGender;
        }
            break;
        case 3:
        {
            cell.detailTextLabel.text = self.result.memberBirthday;
        }
            break;
            
        default:
            break;
    }
    return cell;
}
#pragma mark - HTTPRequest
- (NSInteger)sendImageRequest:(UIImage *)image
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[UploadImageTool share] getQiniuUploadWithImages:image Token:^(NSDictionary *uploadDic) {
       
    } failure:^{
        [self showToast:@"头像上传失败"];
    }];
   
    return 0;
}
//手机拍照
-(void)takePhotoWithTag
{
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    imagePicker.allowsEditing = NO;
    [self presentViewController:imagePicker animated:YES completion:nil];
}

// 获取图库
-(void)localPhotoWithTag
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    picker.allowsEditing = NO;
    [self presentViewController:picker animated:YES completion:nil];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        UIActionSheet *leftAction = [[UIActionSheet alloc] initWithTitle:@"上传头像" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍摄照片", @"选择手机中的照片", nil];
        leftAction.tag = 101;
        [leftAction showInView:self.view];
    }
}
#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex  {
    if (buttonIndex == 0) {
        [self takePhotoWithTag];
    }  else if(buttonIndex == 1) {
        [self localPhotoWithTag];
    }
}

//处理图片
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    image = [image resizedImageWithContentMode:UIViewContentModeScaleAspectFit bounds:CGSizeMake(640, 640) interpolationQuality:kCGInterpolationMedium];
    //
    [self sendImageRequest:image];
    [picker dismissViewControllerAnimated:YES completion:^{
    }];
}
-(void)pressSubmit{
    MineInformationReq *req = [[MineInformationReq alloc]init];
    [[MineServiceApi share]updateMemberInformationWithParam:req response:^(id response) {
        
    }];
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
