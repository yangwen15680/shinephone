//
//  Header.h
//  shinelink
//
//  Created by sky on 16/2/15.
//  Copyright © 2016年 sky. All rights reserved.
//

#ifndef Header_h
#define Header_h

#define IMAGE(_NAME) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForAuxiliaryExecutable:_NAME]]
#define COLOR(_R,_G,_B,_A) [UIColor colorWithRed:_R / 255.0f green:_G / 255.0f blue:_B / 255.0f alpha:_A]
#define NOW_SIZE [UIScreen mainScreen].bounds.size.width/320
#define SCREEN_Width [UIScreen mainScreen].bounds.size.width
#define SCREEN_Height [UIScreen mainScreen].bounds.size.height
#define kiPhone6 ([UIScreen mainScreen].bounds.size.width==375)
#define frameMake(a,b,c,d) CGRectMake(a*NOW_SIZE,b*NOW_SIZE,c*NOW_SIZE,d*NOW_SIZE)


//设备
#define root_Add_Plant       NSLocalizedString(@"Add Plant", @"Add Plant")
#define root_Remove_Station       NSLocalizedString(@"Remove Station", @"Remove Station")
#define root_Upload_Picture       NSLocalizedString(@"Upload Picture", @"Upload Picture")
#define root_Cancel       NSLocalizedString(@"Cancel", @"Cancel")


//登陆
#define root_Enter_your_username       NSLocalizedString(@"Enter your username", @"Enter your username")
#define root_Enter_your_pwd       NSLocalizedString(@"Enter your pwd", @"Enter your pwd")

#endif /* Header_h */
