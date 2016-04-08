//
//  findViewController.m
//  shinelink
//
//  Created by sky on 16/2/15.
//  Copyright © 2016年 sky. All rights reserved.
//


#import "aboutTableViewCell.h"
#import "aboutViewController.h"
#import "aboutOneTableViewCell.h"
#define Kwidth [UIScreen mainScreen].bounds.size.width


@interface aboutViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITabBarControllerDelegate>

@property (nonatomic, strong) UIImagePickerController *cameraImagePicker;
@property (nonatomic, strong) UIImagePickerController *photoLibraryImagePicker;

@end

@implementation aboutViewController
{
    UITableView *_tableView;
    UIPageControl *_pageControl;
    UIScrollView *_scrollerView;
    NSString *_indenty;
    NSString *_indenty1;
    
   
    
    
    //全局变量 用来控制偏移量
    NSInteger pageName;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    //创建tableView的方法
    [self _createTableView];
    
    //创建tableView的头视图
    [self _createHeaderView];
    
    
    
}

- (void)_createTableView {
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
  
    
    [self.view addSubview:_tableView];
  
}

- (void)_createHeaderView {
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0,0,Kwidth,200)];
    UIColor *color=[UIColor colorWithRed:130/ 255.0f green:200 / 255.0f blue:250 / 255.0f alpha:1];
    
    //UIColor *color=[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_list_popver"]];
    [headerView setBackgroundColor:color];
    
    
    double imageSize=150;
    
    UIImageView *userImage= [[UIImageView alloc] initWithFrame:CGRectMake((Kwidth-imageSize)/2, 25, imageSize, imageSize)];
    [userImage setImage:[UIImage imageNamed:@"1.jpg"]];
    userImage.layer.masksToBounds=YES;
    userImage.layer.cornerRadius=imageSize/2.0;
    [userImage setUserInteractionEnabled:YES];
    
    UILongPressGestureRecognizer * longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(pickUpImage)];
    longPressGesture.minimumPressDuration = 1.0f;
    [userImage addGestureRecognizer:longPressGesture];
    
    
    _tableView.tableHeaderView = headerView;
    [headerView addSubview:userImage];
    
}

- (void)pickUpImage{
    NSLog(@"取照片");
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle: nil
                                                                              message: nil
                                                                       preferredStyle:UIAlertControllerStyleActionSheet];
    //添加Button
    [alertController addAction: [UIAlertAction actionWithTitle: @"拍照" style: UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        //处理点击拍照
        self.cameraImagePicker = [[UIImagePickerController alloc] init];
        self.cameraImagePicker.allowsEditing = YES;
        self.cameraImagePicker.delegate = self;
        self.cameraImagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:_cameraImagePicker animated:YES completion:nil];
        
    }]];
    [alertController addAction: [UIAlertAction actionWithTitle: @"从相册选取" style: UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        //处理点击从相册选取
        self.photoLibraryImagePicker = [[UIImagePickerController alloc] init];
        self.photoLibraryImagePicker.allowsEditing = YES;
        self.photoLibraryImagePicker.delegate = self;
        self.photoLibraryImagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:_photoLibraryImagePicker animated:YES completion:nil];
        
    }]];
    [alertController addAction: [UIAlertAction actionWithTitle: @"取消" style: UIAlertActionStyleCancel handler:nil]];
    
    [self presentViewController: alertController animated: YES completion: nil];
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 65*NOW_SIZE;
    
}





- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cell11=@"cell1";
        static NSString *cell22=@"cell2";
     static NSString *cell33=@"cell3";
     static NSString *cell44=@"cell4";
    aboutTableViewCell *cell1=[tableView dequeueReusableCellWithIdentifier:cell11];
    aboutOneTableViewCell *cell2=[tableView dequeueReusableCellWithIdentifier:cell22];
    aboutTableViewCell *cell4=[tableView dequeueReusableCellWithIdentifier:cell44];
    aboutOneTableViewCell *cell3=[tableView dequeueReusableCellWithIdentifier:cell33];
    if(indexPath.row==0)
    {
        if (!cell1) {
            cell1=[[aboutTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell11];
        }
        [cell1.imageLog setImage:[UIImage imageNamed:@"update.png"]];
        cell1.tableName.text = @"用户协议";
        
        return cell1;
    }   else if(indexPath.row==1)
    {
        if (!cell3) {
            cell3=[[aboutOneTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell33];
        }
        [cell3.imageLog setImage:[UIImage imageNamed:@"user-agreement.png"]];
        cell3.tableName.text = @"客服电话";
        cell3.tableDetail.text=@"186666666";
        
          return cell3;
    } else if(indexPath.row==2)
    {
        if (!cell4) {
            cell4=[[aboutTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell44];
        }
        [cell4.imageLog setImage:[UIImage imageNamed:@"service.png"]];
        cell4.tableName.text = @"检查更新";
        
        return cell4;
    }
    else return nil;

}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath

{
 
    
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
