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
#define colorGary COLOR(212, 212, 212, 1)
#define SCREEN_Height [UIScreen mainScreen].bounds.size.height
#define kiPhone6 ([UIScreen mainScreen].bounds.size.width==375)
#define frameMake(a,b,c,d) CGRectMake(a*NOW_SIZE,b*NOW_SIZE,c*NOW_SIZE,d*NOW_SIZE)
#define kScreenWidth  [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define windowColor  [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2]
#define KNOTIFICATION_LOGINCHANGE                      @"loginStateChange"
#define HEAD_URL  @"http://192.168.3.32:8080/ShineServer_2016"
//#define HEAD_URL  @"http://192.168.3.32:8081/ShineServer"
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

//电站列表
#define root_Plant_List       NSLocalizedString(@"Plant List", @"Plant List")
#define root_Today_Energy       NSLocalizedString(@"Today Energy", @"Today Energy")
#define root_Total_Energy       NSLocalizedString(@"Total Energy", @"Total Energy")
#define root_Current_Power       NSLocalizedString(@"Current Power", @"Current Power")
#define root_Gains       NSLocalizedString(@"Gains", @"Gains")
#define root_Percentage       NSLocalizedString(@"Percentage", @"Percentage")
#define root_Storage_Status       NSLocalizedString(@"Storage Status", @"Storage Status")
#define root_Charge_Power       NSLocalizedString(@"Charge Power", @"Charge Power")
#define root_Discharge_Power       NSLocalizedString(@"Discharge Power", @"Discharge Power")
#define root_Add_Plant       NSLocalizedString(@"Add Plant", @"Add Plant")
#define root_Remove_Station       NSLocalizedString(@"Remove Station", @"Remove Station")
#define root_Upload_Picture       NSLocalizedString(@"Upload Picture", @"Upload Picture")
#define root_Setting_Station_Map       NSLocalizedString(@"Setting Station Map", @"Setting Station Map")
#define root_Installation_Information       NSLocalizedString(@"Installation Information", @"Installation Information")
#define root_plant_name       NSLocalizedString(@"plant name", @"plant name")
#define root_instal_date       NSLocalizedString(@"instal date", @"instal date")
#define root_company       NSLocalizedString(@"company", @"company")
#define root_power       NSLocalizedString(@"power", @"power")
#define root_Next       NSLocalizedString(@"Next", @"Next")

//电站详情
#define root_Plant_Detail       NSLocalizedString(@"Plant Detail", @"Plant Detail")
#define root_DAY       NSLocalizedString(@"DAY", @"DAY")
#define root_MONTH       NSLocalizedString(@"MONTH", @"MONTH")
#define root_YEAR       NSLocalizedString(@"YEAR", @"YEAR")
#define root_TOTAL       NSLocalizedString(@"TOTAL", @"TOTAL")
#define root_Daily_Returns       NSLocalizedString(@"Daily Returns", @"Daily Returns")
#define root_Daily_Electricity       NSLocalizedString(@"Daily Electricity", @"Daily Electricity")
#define root_Earnings       NSLocalizedString(@"Earnings", @"Earnings")
#define root_Month_energy       NSLocalizedString(@"Month energy", @"Month energy")
#define root_Earnings       NSLocalizedString(@"Earnings", @"Earnings")
#define root_Year_energy       NSLocalizedString(@"Year energy", @"Year energy")
#define root_Earnings       NSLocalizedString(@"Earnings", @"Earnings")
#define root_Total_energy       NSLocalizedString(@"Total energy", @"Total energy")
#define root_Powre       NSLocalizedString(@"Powre", @"Power")
#define root_Plant_Overview       NSLocalizedString(@"Plant Overview", @"Plant Overview")
#define root_Device_List       NSLocalizedString(@"Device List", @"Device List")
#define root_Event_List       NSLocalizedString(@"Event List", @"Event List")
#define root_Map       NSLocalizedString(@"Map", @"Map")
#define root_Voltage      NSLocalizedString(@"Voltage", @"Voltage")
#define root_Electron_flow      NSLocalizedString(@"Electron flow", @"Electron flow")

//详情（逆变器）
#define root_PV_POWER       NSLocalizedString(@"PV POWER", @"PV POWER")
#define root_PV1_VOLTAGE       NSLocalizedString(@"PV1 VOLTAGE", @"PV1 VOLTAGE")
#define root_PV1_ELEC_CURRENT       NSLocalizedString(@"PV1 ELEC-CURRENT", @"PV1 ELEC-CURRENT")
#define root_PV2_VOLTAGE       NSLocalizedString(@"PV2 VOLTAGE", @"PV2 VOLTAGE")
#define root_PV2_ELEC_CURRENT       NSLocalizedString(@"PV2 ELEC-CURRENT", @"PV2 ELEC-CURRENT")
#define root_R_PHASE_POWER       NSLocalizedString(@"R-PHASE POWER", @"R-PHASE POWER")
#define root_S_PHASE_POWER       NSLocalizedString(@"S-PHASE POWER", @"S-PHASE POWER")
#define root_T_PHASE_POWER       NSLocalizedString(@"T-PHASE POWER", @"T-PHASE POWER")
#define root_POWER       NSLocalizedString(@"POWER", @"POWER")
#define root_Energy       NSLocalizedString(@"Energy", @"Energy")

//详情（储能机）
#define root_CHARGING_POWER       NSLocalizedString(@"CHARGING POWER", @"CHARGING POWER")
#define root_DISCHARGING_POWER       NSLocalizedString(@"DISCHARGING POWER", @"DISCHARGING POWER")
#define root_INPUT_VOLTAGE       NSLocalizedString(@"INPUT VOLTAGE", @"INPUT VOLTAGE")
#define root_INPUT_CURRENT       NSLocalizedString(@"INPUT CURRENT", @"INPUT CURRENT")
#define root_USER_SIDE_POWER       NSLocalizedString(@"USER-SIDE POWER", @"USER-SIDE POWER")
#define root_GRID_SIDE_POWER       NSLocalizedString(@"GRID-SIDE POWER", @"GRID-SIDE POWER")

#define root_MONTH_BATTERY_CHARGE     NSLocalizedString(@"MONTH BATTERY CHARGE" , @"MONTH BATTERY CHARGE")
#define root_MONTHLY_CHARGED     NSLocalizedString(@"MONTHLY CHARGED", @"MONTHLY CHARGED")
#define root_MONTHLY_DISCHARGED     NSLocalizedString(@"MONTHLY DISCHARGED", @"MONTHLY DISCHARGED")
#define root_YEAR_BATTERY_CHARGE     NSLocalizedString(@"YEAR BATTERY CHARGE", @"YEAR BATTERY CHARGE")
#define root_YEAR_CHARGED     NSLocalizedString(@"YEAR CHARGED", @"YEAR CHARGED")
#define root_YEAR_DISCHARGED     NSLocalizedString(@"YEAR DISCHARGED", @"YEAR DISCHARGED")
#define root_TOTAL_BATTERY_CHARGE     NSLocalizedString(@"TOTAL BATTERY CHARGE", @"TOTAL BATTERY CHARGE")
#define root_TOTAL_CHARGED     NSLocalizedString(@"TOTAL CHARGED", @"TOTAL CHARGED")
#define root_TOTAL_DISCHARGED     NSLocalizedString(@"TOTAL DISCHARGED", @"TOTAL DISCHARGED")

#endif /* Header_h */
