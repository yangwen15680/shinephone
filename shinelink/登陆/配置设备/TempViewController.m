
//
//  TempViewController.m
//  QRCode_Demo
//
//  Created by 沈红榜 on 15/11/17.
//  Copyright © 2015年 沈红榜. All rights reserved.
//

#import "TempViewController.h"
#import "SHBQRView.h"

@interface TempViewController ()<SHBQRViewDelegate>

@end

@implementation TempViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    SHBQRView *qrView = [[SHBQRView alloc] initWithFrame:self.view.bounds];
    qrView.delegate = self;
    [self.view addSubview:qrView];
    
    
    
}


- (void)qrView:(SHBQRView *)view ScanResult:(NSString *)result {
    [view stopScan];
    NSString *KK=root_saomiao_jieguo;
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:[NSString stringWithFormat:@"%@:%@", KK,result] preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:root_OK style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [view startScan];
    }]];
    [self presentViewController:alert animated:true completion:nil];
}

@end
