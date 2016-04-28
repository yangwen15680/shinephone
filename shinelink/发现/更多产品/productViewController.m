//
//  productViewController.m
//  shinelink
//
//  Created by sky on 16/4/27.
//  Copyright © 2016年 sky. All rights reserved.
//

#import "productViewController.h"
#import "imageBig.h"

  #define  headH 200*NOW_SIZE
  #define  headH2 120*NOW_SIZE
#define Kwidth [UIScreen mainScreen].bounds.size.width
@interface productViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>
@property(nonatomic,strong)NSMutableArray *imageArray;
@property(nonatomic,strong)NSMutableArray *imageArrayName;
@property(nonatomic,strong)NSMutableArray *imageArrayCount;
@property (nonatomic, strong) UILabel *title1;
@property (nonatomic, strong) UITextView *detail;
@property (nonatomic, strong) UITextView *detail2;
@property (nonatomic, strong) UIScrollView *scrollView2;
@property (nonatomic, strong) NSString *detailText;
@property (nonatomic, strong) UIButton *dayButton;
@property (nonatomic, strong) UIButton *monthButton;
@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation productViewController
{
    UITableView *_tableView;
    UIPageControl *_pageControl;
    UIScrollView *_scrollerView;
    NSString *_indenty;
    
    NSArray *arrayImage;
    NSArray *arrayName;
    //全局变量 用来控制偏移量
    NSInteger pageName;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}

-(void)initUI{

    [self uiOne];
     [self createHeaderView];
    [self uiTwo];
    [self uiThree];
}

-(void)uiOne{
    [self getText];
    _scrollView2=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Height)];
    _scrollView2.scrollEnabled=YES;
    _scrollView2.contentSize = CGSizeMake(SCREEN_Width,1000*NOW_SIZE);
    [self.view addSubview:_scrollView2];
    
    _title1=[[UILabel alloc]initWithFrame:CGRectMake(10*NOW_SIZE,10*NOW_SIZE+headH, 300*NOW_SIZE,25*NOW_SIZE )];
    _title1.text=@"<<ShineServer Terms of Use>>";
    _title1.textAlignment=NSTextAlignmentCenter;
    _title1.textColor=COLOR(0, 0, 0, 1);
    _title1.font = [UIFont systemFontOfSize:18*NOW_SIZE];
    [_scrollView2 addSubview:_title1];
    
    UIView *line3=[[UIView alloc]initWithFrame:CGRectMake(10*NOW_SIZE,10*NOW_SIZE+30*NOW_SIZE+headH, 300*NOW_SIZE,1*NOW_SIZE )];
    line3.backgroundColor=[UIColor grayColor];
    [_scrollView2 addSubview:line3];
    
    _detail=[[UITextView alloc]initWithFrame:CGRectMake(10*NOW_SIZE,50*NOW_SIZE+headH, 300*NOW_SIZE,headH2)];
    _detail.text=_detailText;
    _detail.textAlignment=NSTextAlignmentLeft;
    _detail.textColor=COLOR(60, 60, 60, 1);
    _detail.font = [UIFont systemFontOfSize:12*NOW_SIZE];
    [_scrollView2 addSubview:_detail];
    
    UIView *line4=[[UIView alloc]initWithFrame:CGRectMake(10*NOW_SIZE,55*NOW_SIZE+headH+headH2, 300*NOW_SIZE,1*NOW_SIZE )];
    line4.backgroundColor=[UIColor grayColor];
    [_scrollView2 addSubview:line4];
    
}

-(void)uiTwo{
    self.dayButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.dayButton.frame = CGRectMake(0 * SCREEN_Width/4, 60*NOW_SIZE+headH+headH2, SCREEN_Width/2, 20*NOW_SIZE);
    [self.dayButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
   [self.dayButton setBackgroundImage:[self createImageWithColor:COLOR(47, 200, 255, 1) rect:CGRectMake(0, 0, SCREEN_Width/4, 40*NOW_SIZE)] forState:UIControlStateNormal];
   // [self.dayButton setBackgroundImage:[self createImageWithColor:COLOR(17, 183, 243, 1) rect:CGRectMake(0, 0, SCREEN_Width/4, 40*NOW_SIZE)] forState:UIControlStateHighlighted];
  //  [self.dayButton setBackgroundImage:[self createImageWithColor:COLOR(17, 183, 243, 1) rect:CGRectMake(0, 0, SCREEN_Width/4, 40*NOW_SIZE)] forState:UIControlStateSelected];
    self.dayButton.tag = 1000;
    [self.dayButton setTitle:@"概述" forState:UIControlStateNormal];
    self.dayButton.selected = YES;
    [self.dayButton addTarget:self action:@selector(buttonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView2 addSubview:self.dayButton];
    
    self.monthButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.monthButton.frame = CGRectMake(1 * SCREEN_Width/2, 60*NOW_SIZE+headH+headH2, SCREEN_Width/2, 20*NOW_SIZE);
    [self.monthButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.monthButton setBackgroundImage:[self createImageWithColor:COLOR(47, 200, 255, 1) rect:CGRectMake(0, 0, SCREEN_Width/4, 40*NOW_SIZE)] forState:UIControlStateNormal];
   // [self.monthButton setBackgroundImage:[self createImageWithColor:COLOR(17, 183, 243, 1) rect:CGRectMake(0, 0, SCREEN_Width/4, 40*NOW_SIZE)] forState:UIControlStateHighlighted];
    //[self.monthButton setBackgroundImage:[self createImageWithColor:COLOR(17, 183, 243, 1) rect:CGRectMake(0, 0, SCREEN_Width/4, 40*NOW_SIZE)] forState:UIControlStateSelected];
    self.monthButton.tag = 1001;
    [self.monthButton setTitle:@"参数" forState:UIControlStateNormal];
    [self.monthButton addTarget:self action:@selector(buttonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView2 addSubview:self.monthButton];
}

- (void)buttonDidClicked:(UIButton *)sender {

    if (sender.tag == 1000) {
        if (_detail2) {
            [_detail2 removeFromSuperview];
        }
        [self uiThree];
    }else if(sender.tag == 1001){
        if (_imageView) {
            [_imageView removeFromSuperview];
        }
        [self uiFour];
    }
}

-(void)uiThree{

    _detail2=[[UITextView alloc]initWithFrame:CGRectMake(10*NOW_SIZE,60*NOW_SIZE+headH+headH2+25*NOW_SIZE, 300*NOW_SIZE,400*NOW_SIZE)];
    _detail2.text=_detailText;
    _detail2.textAlignment=NSTextAlignmentLeft;
    _detail2.textColor=COLOR(60, 60, 60, 1);
    _detail2.font = [UIFont systemFontOfSize:12*NOW_SIZE];
    [_scrollView2 addSubview:_detail2];
    
}

-(void)uiFour{
    
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10*NOW_SIZE,60*NOW_SIZE+headH+headH2+25*NOW_SIZE, 300*NOW_SIZE,400*NOW_SIZE)];
    _imageView.image = [UIImage imageNamed:@"2.jpg"];
        [_imageView setUserInteractionEnabled:YES];
    [_scrollView2 addSubview:_imageView];
    UITapGestureRecognizer *tap  = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(magnifyImage)];
    
    [self.imageView addGestureRecognizer:tap];
}

- (void)magnifyImage
{
    NSLog(@"局部放大");
    [imageBig showImage:self.imageView];//调用方法
}

-(void)getText{
    _detailText=@"    Welcome to register and use the service of Shenzhen Growatt New Energy Co., Ltd (which in the following referred as Growatt, ShineServer, Our company, Our website, We.), before use Our website please read the ShineServer Terms of Use (which in following referred as Terms of Use or Agreement).\n    Users must notice that if users want to visit or use our website (including in ways of using mobile phone apps to log in and use our website) and accept the service provided by us, please carefully read all the clauses in this Terms of Use document especially clauses related to your rights or disclaimers. If you have any queries on this Terms of Use please contact service@ginverter.com.\n   Please read and decided to agree all the content of this Terms of Use or not, if you disagree to follow the Terms of Use you should not use ShineServer service or you should quit to continue using this service provided by Growatt. \n    Once you selected the option I have read and accept ShineServer Terms of Use, the action will be regarded as acceptance to the Terms of Use including accepting any changes or supplementary to the Terms of Use done by Growatt, and simultaneously it will be regarded as finish the agreement between users and Growatt. \n    After acceptance to the Terms of Use,     \n -	Users should not use the reason of not read the full content of the Terms of Use to make any opposition.";
}

- (void)createHeaderView{
    
  
    _scrollerView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,0,Kwidth,headH)];
    
    if (_imageArray) {
        for (int i=0; i<_imageArray.count; i++) {
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(Kwidth*i,0,Kwidth,_scrollerView.bounds.size.height)];
            imageView.image = _imageArray[i];
            [_scrollerView addSubview:imageView];
            
            _scrollerView.contentSize = CGSizeMake(Kwidth*_imageArray.count,headH);
            _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0,headH-20,Kwidth,20)];
            _pageControl.numberOfPages = _imageArray.count;
        }
    }else{
        NSArray *imgArray = @[@"1.jpg",
                              @"2.jpg",
                              @"3.jpg"];
        for (int i=0; i<imgArray.count; i++) {
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(Kwidth*i,0,Kwidth,_scrollerView.bounds.size.height)];
            imageView.image = [UIImage imageNamed:imgArray[i]];
            [_scrollerView addSubview:imageView];
            
            _scrollerView.contentSize = CGSizeMake(Kwidth*imgArray.count,headH);
            _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0,headH-20,Kwidth,20)];
            _pageControl.numberOfPages = imgArray.count;
        }
    }
    
    
    _scrollerView.pagingEnabled = YES;
    _scrollerView.showsHorizontalScrollIndicator = NO;
    _scrollerView.delegate = self;
    [self.scrollView2 addSubview:_scrollerView];
    
    //创建分页视图
    
    _pageControl.currentPage = 0;
    [_pageControl addTarget:self action:@selector(pageAction:) forControlEvents:UIControlEventValueChanged];
    [self.scrollView2 addSubview:_pageControl];
}

#pragma mark pageAction的实现方法
- (void)pageAction:(UIPageControl *)control {
    NSInteger page = control.currentPage;
    [_scrollerView setContentOffset:CGPointMake(Kwidth*page,0) animated:YES];
}


#pragma mark _scrollerView的协议方法
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    CGFloat x = scrollView.contentOffset.x / Kwidth;
    _pageControl.currentPage = x;
}

#pragma mark 定时器方法
- (void)circulate:(NSTimer *)timer {
    
    pageName++;
    
    [_scrollerView setContentOffset:CGPointMake(Kwidth*pageName, 0) animated:YES];
    _pageControl.currentPage = pageName;
    
    if (pageName == 2) {
        pageName = -1;
    }
    
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
