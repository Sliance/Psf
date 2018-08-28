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
#import "SexPickerTool.h"
#import "DatePickerTool.h"

@interface MineInformationController ()<UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate>
@property(nonatomic,strong)UITableView *tableview;
@property(nonatomic,strong)NSArray *dataArr;
@property(nonatomic,strong)BottomView *bottomView;
@property(nonatomic,strong)MineInformationReq *result;
@property(nonatomic,strong)NSMutableArray *imageArr;
@property(nonatomic,strong)UITextField *nameField;
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
        _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0,[self navHeightWithHeight], SCREENWIDTH, SCREENHEIGHT-[self tabBarHeight]) style:UITableViewStylePlain];
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
        [self setTitle:@"个人信息"];
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
    [self.view addSubview:self.bottomView];
    _dataArr = @[@"头像",@"昵称",@"性别",@"生日"];
    _imageArr = [NSMutableArray array];
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
    return 0.01;
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
            UITextField*field;
            if (!field) {
                field = [[UITextField alloc]init];
                field.textAlignment = NSTextAlignmentRight;
                field.font = [UIFont systemFontOfSize:13];
                field.frame = CGRectMake(SCREENWIDTH/2, 0, SCREENWIDTH/2-15, 45);
                field.delegate = self;
                
                [cell addSubview:field];
            }
            _nameField = field;
          field.text = self.result.memberNickName;
            
        }
            break;
        case 2:
        {
            if (self.result.memberGender.length==0) {
                cell.detailTextLabel.text =@"未选择";
            }else{
               cell.detailTextLabel.text = self.result.memberGender;
            }
        }
            break;
        case 3:
        {
            if (self.result.memberBirthday.length ==0) {
                cell.detailTextLabel.text =@"未填写";
            }else{
               cell.detailTextLabel.text = self.result.memberBirthday;
            }
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
    [_imageArr removeAllObjects];
    NSData *data = UIImageJPEGRepresentation(image, 1.0);
    NSString *dataStr = [data base64EncodedStringWithOptions:0];
    NSString * fileName = [NSString stringWithFormat:@"data:image/jpg;base64,%@",dataStr];
    [_imageArr addObject:fileName];
   
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    __weak typeof(self)weakself = self;
    [[UploadImageTool share] getQiniuUploadWithImages:self.imageArr Token:^(NSArray *uploadDic) {
        if (uploadDic) {
            
            ImageModel *model = [uploadDic firstObject];
            weakself.result.memberAvatarPath = [NSString stringWithFormat:@"%@%@",IMAGEHOST,model.fileOriginalPath];
            weakself.result.memberAvatarId = model.fileId;
            [weakself.tableview reloadData];
        }
        [hud setHidden:YES];
    } failure:^{
        [hud setHidden:YES];
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
    __weak typeof(self)weakself = self;
    if (indexPath.row == 0) {
        UIActionSheet *leftAction = [[UIActionSheet alloc] initWithTitle:@"上传头像" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍摄照片", @"选择手机中的照片", nil];
        leftAction.tag = 101;
        [leftAction showInView:self.view];
    }else if (indexPath.row ==2){
        SexPickerTool *sexPick = [[SexPickerTool alloc] initWithFrame:CGRectMake(0, SCREENHEIGHT-250, SCREENWIDTH, 250)];
        [sexPick setDataSource:nil];
        __block SexPickerTool *blockPicker = sexPick;
        sexPick.callBlock = ^(NSString *pickDate) {
            
            if (pickDate) {
                weakself.result.memberGender = pickDate;
                [weakself.tableview reloadData];
            }
            
            [blockPicker removeFromSuperview];
        };
        [self.view addSubview:sexPick];
    }else if (indexPath.row ==3){
        DatePickerTool *datePicker = [[DatePickerTool alloc] initWithFrame:CGRectMake(0, SCREENHEIGHT-250, SCREENWIDTH, 250)];
        __block DatePickerTool *blockPick = datePicker;
        datePicker.callBlock = ^(NSString *pickDate) {
            
            if (pickDate) {
                weakself.result.memberBirthday = pickDate;
                [weakself.tableview reloadData];
            }
            
            [blockPick removeFromSuperview];
        };
        
        [self.view addSubview:datePicker];
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
    self.result.appId = @"993335466657415169";
    self.result.timestamp = @"529675086";
    self.result.token = [UserCacheBean share].userInfo.token;
    self.result.platform = @"ios";
    self.result.memberNickName = self.nameField.text;
    [[MineServiceApi share]updateMemberInformationWithParam:self.result response:^(id response) {
        if (response) {
            [self showToast:response[@"message"]];
        }
    }];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self hideKeyBoard];
}
-(void)hideKeyBoard{
    
    self.result.memberNickName = _nameField.text;
   
    [_nameField resignFirstResponder];
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
