//
//  AnswerViewController.m
//  shinelink
//
//  Created by sky on 16/4/12.
//  Copyright © 2016年 sky. All rights reserved.
//

#import "AnswerViewController.h"
#import "myListSecond.h"
#import "GetServerViewController.h"

@interface AnswerViewController ()<UITextFieldDelegate,UIActionSheetDelegate, UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSMutableArray *labelArray;
@property (nonatomic, strong) UITextField *userTextField;
@property (nonatomic, strong) UITextField *SNTextField;
@property (nonatomic, strong) UILabel* registLable;
@property (nonatomic, strong) UITextView *contentView;
@property (nonatomic, strong) UIImagePickerController *cameraImagePicker;
@property (nonatomic, strong) UIImagePickerController *photoLibraryImagePicker;
@property (nonatomic, strong) NSMutableArray *picArray;
@property (nonatomic, strong) NSMutableDictionary *allDict;
@end

@implementation AnswerViewController
{
int picTime;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=root_ME_tijiao_wenti;
    picTime=0;
    
    _picArray=[NSMutableArray array];
    [self initUI];
}


-(void)initUI{
    _scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Height)];
    _scrollView.scrollEnabled=YES;
    _scrollView.contentSize = CGSizeMake(SCREEN_Width,600*NOW_SIZE);
    [self.view addSubview:_scrollView];
 //   float Size1=50*NOW_SIZE;
    
 
        UILabel *PV1Lable=[[UILabel alloc]initWithFrame:CGRectMake(0*NOW_SIZE, 17*NOW_SIZE, 80*NOW_SIZE,20*NOW_SIZE )];
        PV1Lable.text=root_ME_neirong;
        PV1Lable.textAlignment=NSTextAlignmentRight;
        PV1Lable.textColor=[UIColor blackColor];
        PV1Lable.font = [UIFont systemFontOfSize:14*NOW_SIZE];
        [_scrollView addSubview:PV1Lable];
    
    UIImageView *image2=[[UIImageView alloc]initWithFrame:CGRectMake(80*NOW_SIZE, 17, 220*NOW_SIZE,205*NOW_SIZE )];
    image2.userInteractionEnabled = YES;
    image2.image = IMAGE(@"外框@3x.png");
    [_scrollView addSubview:image2];
    
    self.contentView = [[UITextView alloc] initWithFrame:CGRectMake(85*NOW_SIZE, 17*NOW_SIZE, 205*NOW_SIZE,200*NOW_SIZE )];
    // self.contentView.placeholder = @"请输入内容";
    self.contentView.textColor = [UIColor blackColor];
    self.contentView.tintColor = [UIColor blackColor];
    // [self.contentView setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
    //  [self.contentView setValue:[UIFont systemFontOfSize:12*NOW_SIZE] forKeyPath:@"_placeholderLabel.font"];
    self.contentView.font = [UIFont systemFontOfSize:14*NOW_SIZE];
    [_scrollView addSubview:_contentView];
    
    UILabel *PV1Lable1=[[UILabel alloc]initWithFrame:CGRectMake(0*NOW_SIZE, 29*NOW_SIZE+200*NOW_SIZE, 80*NOW_SIZE,20*NOW_SIZE )];
    PV1Lable1.text=root_ME_fujian;
    PV1Lable1.textAlignment=NSTextAlignmentRight;
    PV1Lable1.textColor=[UIColor blackColor];
    PV1Lable1.font = [UIFont systemFontOfSize:14*NOW_SIZE];
    [_scrollView addSubview:PV1Lable1];
    
    UIImageView *image1=[[UIImageView alloc]initWithFrame:CGRectMake(80*NOW_SIZE, 27*NOW_SIZE+200*NOW_SIZE, 220*NOW_SIZE,30*NOW_SIZE )];
    image1.userInteractionEnabled = YES;
    image1.image = IMAGE(@"frame4@2x.png");
    [_scrollView addSubview:image1];
    
    UILabel *registLable1= [[UILabel alloc] initWithFrame:CGRectMake(85*NOW_SIZE, 27*NOW_SIZE+200*NOW_SIZE, 220*NOW_SIZE,30*NOW_SIZE )];
    registLable1.text=root_ME_shangchuan_tupian;
    registLable1.textColor=[UIColor grayColor];
    registLable1.textAlignment = NSTextAlignmentLeft;
    registLable1.font = [UIFont systemFontOfSize:14*NOW_SIZE];
    registLable1.userInteractionEnabled=YES;
    UITapGestureRecognizer * labelTap1=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(controlPhoto)];
    [registLable1 addGestureRecognizer:labelTap1];
    [_scrollView addSubview:registLable1];
    
    UIButton *goBut =  [UIButton buttonWithType:UIButtonTypeCustom];
    goBut.frame=CGRectMake(60*NOW_SIZE, 60*NOW_SIZE+200*NOW_SIZE+160*NOW_SIZE, 200*NOW_SIZE, 40*NOW_SIZE);
    [goBut.layer setMasksToBounds:YES];
    [goBut.layer setCornerRadius:25.0];
    [goBut setBackgroundImage:IMAGE(@"按钮2.png") forState:UIControlStateNormal];
    [goBut setTitle:root_finish forState:UIControlStateNormal];
    [goBut addTarget:self action:@selector(finishDone) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:goBut];
    
    float size5=60*NOW_SIZE;
    for(int i=0;i<4;i++){
        UIImageView *image5=[[UIImageView alloc]initWithFrame:CGRectMake(75*NOW_SIZE+size5*i, 65*NOW_SIZE+200*NOW_SIZE, 50*NOW_SIZE,50*NOW_SIZE )];
        // image5.userInteractionEnabled = YES;
        image5.image = IMAGE(@"add2@2x.png");
        [_scrollView addSubview:image5];
    }
    
    for(int i=0;i<4;i++){
        UIImageView *image5=[[UIImageView alloc]initWithFrame:CGRectMake(75*NOW_SIZE+size5*i, 90*NOW_SIZE+200*NOW_SIZE+50*NOW_SIZE, 50*NOW_SIZE,50*NOW_SIZE )];
        // image5.userInteractionEnabled = YES;
        image5.image = IMAGE(@"add2@2x.png");
        [_scrollView addSubview:image5];
    }
    
    
}

-(void)finishDone{
    NSMutableDictionary *dataImageDict = [NSMutableDictionary dictionary];
//    for (int i=0; i<_picArray.count; i++) {
//        NSData *imageData = UIImageJPEGRepresentation(_picArray[i], 0.5);
//        NSString *imageName=@"imageName";
//        [dataImageDict setObject:imageData forKey:imageName];
//    }
    
    for (int i=0; i<_picArray.count; i++) {
        NSData *imageData = UIImageJPEGRepresentation(_picArray[i], 0.5);
        NSString *imageName=[NSString stringWithFormat:@"image%d",i+1];
        [dataImageDict setObject:imageData forKey:imageName];
    }
    
    if ([[_contentView text] isEqual:@""]) {
        [self showToastViewWithTitle:root_ME_shuru_leirong];
        return;
    }
    
    NSUserDefaults *ud=[NSUserDefaults standardUserDefaults];
    NSString *userID=[ud objectForKey:@"userID"];
    _allDict=[NSMutableDictionary dictionary];
      [_allDict setObject:[_contentView text] forKey:@"message"];
     [_allDict setObject:_qusetionId forKey:@"questionId"];
     [_allDict setObject:userID forKey:@"userId"];
    
    [BaseRequest uplodImageWithMethod:HEAD_URL paramars:_allDict paramarsSite:@"/questionAPI.do?op=replyMessage" dataImageDict:dataImageDict sucessBlock:^(id content) {
        NSLog(@"addCustomerQuestion==%@", content);
        id  content1= [NSJSONSerialization JSONObjectWithData:content options:NSJSONReadingAllowFragments error:nil];
        if (content1) {
            if ([content1[@"success"] integerValue] == 1) {
                
                [self goback];
                [self showAlertViewWithTitle:nil message:root_ME_tianjia_chenggong cancelButtonTitle:root_Yes];
               
            }
        }else{
            [self showAlertViewWithTitle:nil message:root_ME_tianjia_shibai cancelButtonTitle:root_Yes];
        }
    }
                              failure:^(NSError *error) {
                                  [self showToastViewWithTitle:root_Networking];
                              }];
    
}

-(void)goback{
   // myListSecond *second=[[myListSecond alloc]init];
    [self.navigationController popViewControllerAnimated:NO];

}

-(void)controlPhoto{
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle: nil
                                                                              message: nil
                                                                       preferredStyle:UIAlertControllerStyleActionSheet];
    //添加Button
    [alertController addAction: [UIAlertAction actionWithTitle: root_paiZhao style: UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        //处理点击拍照
        self.cameraImagePicker = [[UIImagePickerController alloc] init];
        self.cameraImagePicker.allowsEditing = YES;
        self.cameraImagePicker.delegate = self;
        self.cameraImagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:_cameraImagePicker animated:YES completion:nil];
        
    }]];
    [alertController addAction: [UIAlertAction actionWithTitle: root_xiangkuang_xuanQu style: UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        //处理点击从相册选取
        self.photoLibraryImagePicker = [[UIImagePickerController alloc] init];
        self.photoLibraryImagePicker.allowsEditing = YES;
        self.photoLibraryImagePicker.delegate = self;
        self.photoLibraryImagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:_photoLibraryImagePicker animated:YES completion:nil];
        
        
    }]];
    [alertController addAction: [UIAlertAction actionWithTitle: root_cancel style: UIAlertActionStyleCancel handler:nil]];
    
    [self presentViewController: alertController animated: YES completion: nil];
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    UIImage *image = info[@"UIImagePickerControllerEditedImage"];
    //NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
    [_picArray addObject:image];
    float size2=60*NOW_SIZE;
    
    if (picTime<4) {
        UIImageView *image2=[[UIImageView alloc]initWithFrame:CGRectMake(75*NOW_SIZE+size2*picTime, 65*NOW_SIZE+200*NOW_SIZE, 50*NOW_SIZE,50*NOW_SIZE )];
        image2.userInteractionEnabled = YES;
        image2.image = _picArray[picTime];
        image2.tag=picTime+3000;
        [_scrollView addSubview:image2];
        
        UIButton *del= [[UIButton alloc] initWithFrame:CGRectMake(75*NOW_SIZE+size2*picTime, 70*NOW_SIZE+200*NOW_SIZE+50*NOW_SIZE, 50*NOW_SIZE,10*NOW_SIZE )];
        [del setTitle:root_del forState:UIControlStateNormal];
        del.backgroundColor=[UIColor clearColor];
        [del setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        // del.font = [UIFont systemFontOfSize:12*NOW_SIZE];
        //del.userInteractionEnabled=YES;
        del.tag=2000+picTime;
        [del addTarget:self action:@selector(delPicture:) forControlEvents:UIControlEventTouchUpInside];
        [_scrollView addSubview:del];
        // UITapGestureRecognizer * labelTap2=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(delPicture:)];
        // [del addGestureRecognizer:labelTap2];
        
    }else if(4<=picTime && picTime<8){
        UIImageView *image2=[[UIImageView alloc]initWithFrame:CGRectMake(70*NOW_SIZE+size2*(picTime-4), 70*NOW_SIZE+200*NOW_SIZE+50*NOW_SIZE, 50*NOW_SIZE,50*NOW_SIZE )];
        image2.userInteractionEnabled = YES;
        image2.image = _picArray[picTime];
        image2.tag=picTime+3000;
        [_scrollView addSubview:image2];
        
        UIButton *del2= [[UIButton alloc] initWithFrame:CGRectMake(70*NOW_SIZE+size2*(picTime-4), 25*NOW_SIZE+50*NOW_SIZE*4+175*NOW_SIZE+55*NOW_SIZE, 50*NOW_SIZE,10*NOW_SIZE )];
        [del2 setTitle:root_del forState:UIControlStateNormal];
        del2.backgroundColor=[UIColor clearColor];
        [del2 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        // del.font = [UIFont systemFontOfSize:12*NOW_SIZE];
        //del.userInteractionEnabled=YES;
        del2.tag=2000+picTime;
        [del2 addTarget:self action:@selector(delPicture:) forControlEvents:UIControlEventTouchUpInside];
        [_scrollView addSubview:del2];
    }
    
    picTime++;
}

-(void)delPicture:(UIButton*)del{
    //NSLog(@"del.tag=%ld",del.tag);
    //int a=del.tag;
    UIButton  *a=del;
    NSString *replaceName=@"del";
    //  [_picArray removeObjectAtIndex:a.tag-2000];
    [_picArray replaceObjectAtIndex:a.tag-2000 withObject:replaceName];
    UIImageView *image3=[_scrollView viewWithTag:a.tag+1000];
    UIButton *button3=[_scrollView viewWithTag:a.tag];
    [button3 removeFromSuperview];
    [image3 removeFromSuperview];
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
