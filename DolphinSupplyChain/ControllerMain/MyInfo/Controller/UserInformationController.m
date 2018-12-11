//
//  UserInformationController.m
//  Distribution
//
//  Created by 张翔 on 14-11-21.
//  Copyright (c) 2014年 ___YKSKJ.COM___. All rights reserved.
//

#import "UserInformationController.h"
#import "ChangePasswordController.h"
#import "ZXNTool.h"

@interface UserInformationController ()<UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    NSMutableDictionary *userInformation;
    HTTabbleView *table;
    
    
    NSArray *userArr;//0、头像；1、账号mobile_phone；2、昵称username；3、weidian；4、email
    NSArray *arr;
    
    NSString *phone;
    NSString *userName;
    NSArray *weidian;
    NSString *email;
    UIImage *userImage;
}

@end

@implementation UserInformationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    userInformation = [[NSMutableDictionary alloc] init];
   
    
    table = [[HTTabbleView alloc] initWithFrame:CGRectMake(0, kDisNavgation, kDisWidth, kDisHeight - kDisNavgation) style:UITableViewStyleGrouped];
    table.dataSource = self;
    table.delegate = self;
    table.scrollEnabled = NO;
    table.backgroundColor = [UIColor clearColor];
    [self.view addSubview:table];
    table.separatorStyle = NO;
    
    [self addNavigationType:YKS_Left_Title_RightTwo NavigationTitle:@"个人信息"];
    [self.btnRigthTwo setTitle:@"保存" forState:UIControlStateNormal];
    self.btnRigthTwo.titleLabel.font = kFont16;
    
    
    [self getUserInfo];
    [table reloadData];
}

- (void)tapRightTwo
{
    NSDictionary *dic = nil;
    if ([YKSUserDefaults shareInstance].sUser_Account.length != 0) {
        
        NSDictionary *infos = @{ @"email":email};
        NSString *sJson = [ZXNTool getJSONString:infos];
        
        dic = @{@"infos":sJson};
    }
    else
    {
        NSDictionary *infos = @{ @"email":email,
                                 @"user_name":userName};
        
        NSString *sJson = [ZXNTool getJSONString:infos];
        
        dic = @{@"infos":sJson};
    }
    [HTLoadingTool showLoadingStringDontOperation:@"保存中..."];
    [AFHTTPClient POST:@"/user/updateInfos" params:dic successInfo:^(ResponseModel *response) {
        
        [self.view makeToast:@"保存个人信息成功" duration:1.0 position:CSToastPositionCenter];
        
        [[YKSUserDefaults shareInstance] upDateUser_Account:userName];
        [[YKSUserDefaults shareInstance] upDateUser_Email:email];
        
    } flaseInfo:^(ResponseModel *response, HTTPType type) {
        if (type == NEED_HINT || type == SERVICE_ERROR || type == NO_NETWORK) {
            [self.view makeToast:response.sMsg duration:1.0 position:CSToastPositionCenter];
        }
        
        if (type == NEED_LOGIN) {
            ZXNLog(@"需要登录");
        }
    }];
}

#pragma mark --获得用户信息
- (void) getUserInfo
{
    phone = [YKSUserDefaults shareInstance].sUser_Mobile;
    userName = [YKSUserDefaults shareInstance].sUser_Account;
    email = [YKSUserDefaults shareInstance].sUser_Email;
    userImage = [UIImage imageNamed:@"Head_Portrait_Longin"];
}

#pragma mark tableView代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            return 3;
            break;
        case 2:
            return 1;
            break;
            
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([indexPath section] == 0 && [indexPath row] == 0) {
        return 100;
    }
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    long section = [indexPath section];
    long row = [indexPath row];
    static NSString *cellIdentifier = @"cellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    switch (section) {
        case 0:
            if (row == 0) {
                cell.textLabel.text = @"头像";
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

                UIImageView *imagev = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
                imagev.layer.cornerRadius = 40;
                imagev.layer.masksToBounds = YES;
                imagev.image = userImage;
                cell.accessoryView = imagev;
            }
            
            break;
            
        case 1:
            if (row == 0) {
                cell.textLabel.text = @"账号";
                cell.detailTextLabel.text = phone;
                cell.accessoryType = UITableViewCellAccessoryNone;
            }else if(row == 1){
                cell.textLabel.text = @"用户名";
                if ([phone isEqualToString:userName]) {
                    
                    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                }
                cell.detailTextLabel.text = userName;
                
                UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, kDisWidth - 15, 0.5)];
                line.backgroundColor = [UIColor colorWithRed:220.0/255.0 green:220.0/255.0 blue:220.0/255.0 alpha:1.0];
                [cell.contentView addSubview:line];
            }else{
                cell.textLabel.text = @"修改密码";
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                
                UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, kDisWidth - 15, 0.5)];
                line.backgroundColor = [UIColor colorWithRed:220.0/255.0 green:220.0/255.0 blue:220.0/255.0 alpha:1.0];
                [cell.contentView addSubview:line];
            }
            break;
        case 2:
            
            cell.textLabel.text = @"邮箱";
            cell.detailTextLabel.text = email;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                
            UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, kDisWidth - 15, 0.5)];
            line.backgroundColor = [UIColor colorWithRed:220.0/255.0 green:220.0/255.0 blue:220.0/255.0 alpha:1.0];
            [cell.contentView addSubview:line];
            
            break;
    }
    cell.textLabel.textColor = [UIColor darkGrayColor];
    cell.textLabel.font = [UIFont systemFontOfSize:15.0f];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:14.0f];
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    long section = [indexPath section];
    long row = [indexPath row];
    
    if ([YKSUserDefaults shareInstance].sUser_Account.length != 0 && section == 1 && indexPath.row == 1) {
        return;
    }
    ChangeSomethingController *changeVC = [[ChangeSomethingController alloc] initWithChangeSomething:^(NSString *sNeiRon, NSString *Type) {
        
        if ([Type isEqualToString:@"Name"]) {
            userName = sNeiRon;
        }
        else
        {
            email = sNeiRon;
        }
        [tableView reloadData];
    }];
    switch (section) {
        case 0:
            
//            [self addPhoto];
            break;
        case 1:
            if (row == 1)
            {
                if (userName.length == 0)
                {
                    changeVC.numOfRow = 0;
                    changeVC.nickName = userName;
                    [self.navigationController pushViewController:changeVC animated:YES];
                }
            }
            if (row == 2)
            {
                ChangePasswordController *changeVC = [[ChangePasswordController alloc] init];
                [self.navigationController pushViewController:changeVC animated:YES];
            }
            
            break;
        case 2:
            changeVC.numOfRow = 2;
            [self.navigationController pushViewController:changeVC animated:YES];
            
            break;
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 5;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 5;
}

-(void)addPhoto{
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"相册", nil];

    [sheet showInView:self.view];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
   
    switch (buttonIndex) {
        case 0:
            [self takePhoto];
            break;
        case 1:
            [self openLocalPhoto];
            break;
        default:
            break;
    }
}

#pragma mark -- actionsheet actions
-(void)takePhoto{
    UIImagePickerControllerSourceType sourceType=UIImagePickerControllerSourceTypeCamera;
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIImagePickerController *picker=[[UIImagePickerController alloc] init];
        picker.delegate=self;
        picker.allowsEditing=YES;
        picker.sourceType=sourceType;
        [self presentViewController:picker animated:YES completion:nil];
    }else{
        ZXNLog(@"模拟器中无法打开照相机，请在真机中使用");
    }
}

-(void)openLocalPhoto{
    UIImagePickerController *picker=[[UIImagePickerController alloc] init];
    picker.delegate=self;
    picker.allowsEditing=YES;
    picker.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:picker animated:YES completion:nil];
}

#pragma mark -- imagePickerController delegate
//  当选择一张图片后进入这里
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    //    当选择的类型是图片
    if ([type isEqualToString:@"public.image"]) {
        //先把图片转成NSData
        UIImage* image = [info objectForKey:UIImagePickerControllerEditedImage];
        CGSize imageSize = image.size;
        imageSize.height = 120;
        imageSize.width = 120;
        image = [self imageWithImage:image scaledToSize:imageSize];
        NSData *data = UIImageJPEGRepresentation(image, 0.5);
        NSUserDefaults *userInfo = [NSUserDefaults standardUserDefaults];
        [userInfo setObject:data forKey:@"image"];
        [userInfo synchronize];
        
        [picker dismissViewControllerAnimated:YES completion:^{
            
            
        }];
        
    }
}


//对图片尺寸进行压缩--
-(UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize
{
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}


@end
