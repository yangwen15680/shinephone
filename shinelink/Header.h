//
//  Header.h
//  shinelink
//
//  Created by sky on 16/2/15.
//  Copyright © 2016年 sky. All rights reserved.
//

#ifndef Header_h
#define Header_h

#import "UserInfo.h"
#import "BaseRequest.h"
#import "MBProgressHUD.h"
#import "RootViewController.h"
#import "CoreDataManager.h"

#define ManagerObjectModelFileName @"deviceCore" //数据库名字

#define IMAGE(_NAME) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForAuxiliaryExecutable:_NAME]]
#define COLOR(_R,_G,_B,_A) [UIColor colorWithRed:_R / 255.0f green:_G / 255.0f blue:_B / 255.0f alpha:_A]
#define NOW_SIZE [UIScreen mainScreen].bounds.size.width/320

#define SCREEN_Width [UIScreen mainScreen].bounds.size.width
#define SCREEN_Height [UIScreen mainScreen].bounds.size.height
#define kiPhone6 ([UIScreen mainScreen].bounds.size.width==375)
#define frameMake(a,b,c,d) CGRectMake(a*NOW_SIZE,b*NOW_SIZE,c*NOW_SIZE,d*NOW_SIZE)
#define kScreenWidth  [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define windowColor  [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2]
#define KNOTIFICATION_LOGINCHANGE                      @"loginStateChange"
//#define HEAD_URL  @"http://192.168.3.32:8080/ShineServer_2016"
#define HEAD_URL  @"http://192.168.3.32:8081/ShineServer"
//#define HEAD_URL  @"http://server-cn.growatt.com"
#define mainColor [UIColor colorWithRed:130/255.0f green:200/255.0f blue:250/255.0f alpha:1]
//设备
#define root_Add_Plant       NSLocalizedString(@"Add Plant", @"Add Plant")
#define root_Remove_Station       NSLocalizedString(@"Remove Station", @"Remove Station")
#define root_Upload_Picture       NSLocalizedString(@"Upload Picture", @"Upload Picture")
#define root_Cancel       NSLocalizedString(@"Cancel", @"Cancel")


//登陆
#define root_Enter_your_username       NSLocalizedString(@"Enter your username", @"Enter your username")
#define root_Enter_your_pwd       NSLocalizedString(@"Enter your pwd", @"Enter your pwd")

//注册
#define root_Enter_your_username       NSLocalizedString(@"Enter your username", @"Enter your username")
#define root_Enter_your_pwd       NSLocalizedString(@"Enter your pwd", @"Enter your pwd")
#define root_Enter_email       NSLocalizedString(@"Enter email", @"Enter email")
#define root_Enter_phone_number       NSLocalizedString(@"Enter phone number", @"Enter phone number")
#define root_Networking      NSLocalizedString(@"Networking Timeout", @"Networking Timeout")
#define root_Yes       NSLocalizedString(@"Yes", @"Yes")

//数据采集器/编辑采集器
#define root_Add       NSLocalizedString(@"Add", @"Add")
#define root_aliases       NSLocalizedString(@"aliases", @"aliases")
#define root_datalog_sn       NSLocalizedString(@"datalog sn", @"datalog sn")
#define root_group       NSLocalizedString(@"group", @"group")
#define root_device_type       NSLocalizedString(@"device type", @"device type")
#define root_data_update_interval       NSLocalizedString(@"data update interval", @"data update interval")
#define root_Add       NSLocalizedString(@"Add", @"Add")
#define root_Modified       NSLocalizedString(vvvv, @"Modified")
#define root_Delete       NSLocalizedString(@"Delete", @"Delete")
#define root_Aliases_can_not_be_empty       NSLocalizedString(@"Aliases can not be empty", @"Aliases can not be empty")
#define root_Successfully_modified       NSLocalizedString(@"Successfully modified", @"Successfully modified")
#define root_Modification_fails       NSLocalizedString(@"Modification fails", @"Modification fails")
#define root_Successfully_deleted       NSLocalizedString(@"Successfully deleted", @"Successfully deleted")
#define root_Delete_failed       NSLocalizedString(@"Delete failed", @"Delete failed")
#define root_Added_successfully       NSLocalizedString(@"Added successfully", @"Added successfully")

//添加数据采集器
#define root_Add       NSLocalizedString(@"Add", @"Add")
#define root_Enter_DatalogSN       NSLocalizedString(@"Enter DatalogSN", @"Enter DatalogSN")
#define root_Datalog_Valicode       NSLocalizedString(@"Datalog Valicode", @"Datalog Valicode")
#define root_Insert_true_datalog_sn       NSLocalizedString(@"Insert true datalog sn", @"Insert true datalog sn")
#define root_Datalog_verification_code_is_incorrect       NSLocalizedString(@"Datalog verification code is incorrect", @"Datalog verification code is incorrect")
#define root_Datalog_verification_code_is_incorrect       NSLocalizedString(@"Datalog verification code is incorrect", @"Datalog verification code is incorrect")
#define root_Added_Successfully       NSLocalizedString(@"Added Successfully", @"Added Successfully")
#define root_Add_Failed       NSLocalizedString(@"Add Failed", @"Add Failed")
#define root_Insert_datalog_code       NSLocalizedString(@"Insert datalog code", @"Insert datalog code")

#endif /* Header_h */
