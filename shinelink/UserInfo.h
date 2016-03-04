//
//  UserInfo.h
//  shinelink
//
//  Created by sky on 16/2/25.
//  Copyright © 2016年 sky. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfo : NSObject

+ (UserInfo *)defaultUserInfo;

@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *userPassword;
@property (nonatomic, strong) NSString *userID;
@property (nonatomic, strong) NSString *server;
@property (nonatomic, strong) NSString *TelNumber;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *plantID;
@property (nonatomic, strong) NSString *plantNum;
@property(weak ,nonatomic)NSTimer *R_timer;
@property (nonatomic, assign) BOOL isAutoLogin;

@end
