//
//  UserInfo.m
//  shinelink
//
//  Created by sky on 16/2/25.
//  Copyright © 2016年 sky. All rights reserved.
//


#import "UserInfo.h"

static UserInfo *userInfo = nil;

@implementation UserInfo

+ (UserInfo *)defaultUserInfo {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        userInfo = [[UserInfo alloc]init];
    });
    return userInfo;
}

- (instancetype)init {
    if (self = [super init]) {
        
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        
       
        
        if (![ud objectForKey:@"userName"]) {
            [ud setObject:@"" forKey:@"userName"];
            _userName = @"";
        } else {
            _userName = [ud objectForKey:@"userName"];
        }
        
        if (![ud objectForKey:@"userPassword"]) {
            [ud setObject:@"" forKey:@"userPassword"];
            _userPassword = @"";
        } else {
            _userPassword = [ud objectForKey:@"userPassword"];
        }
        
        if (![ud objectForKey:@"TelNumber"]) {
            [ud setObject:@"" forKey:@"TelNumber"];
            _TelNumber = @"";
        } else {
            _TelNumber= [ud objectForKey:@"TelNumber"];
        }
        
        if (![ud objectForKey:@"email"]) {
            [ud setObject:@"" forKey:@"email"];
            _email= @"";
        } else {
            _email= [ud objectForKey:@"email"];
        }
        
        if (![ud objectForKey:@"server"]) {
            [ud setObject:@"http://server.growatt.com" forKey:@"server"];
            _server = @"http://server.growatt.com";
        } else {
            _server = [ud objectForKey:@"server"];
        }
        
        [ud synchronize];
        
    }
    return self;
}


- (void)setUserPassword:(NSString *)userPassword {
    _userPassword = userPassword;
    
    [[NSUserDefaults standardUserDefaults] setObject:_userPassword forKey:@"userPassword"];
}


- (void)setUserName:(NSString *)userName {
    _userName = userName;
    
    [[NSUserDefaults standardUserDefaults] setObject:_userName forKey:@"userName"];
}

-(void)setTelNumber:(NSString *)TelNumber{

    _TelNumber=TelNumber;
      [[NSUserDefaults standardUserDefaults] setObject:_TelNumber forKey:@"TelNumber"];
}

-(void)setEmail:(NSString *)email{
    
    _email=email;
    [[NSUserDefaults standardUserDefaults] setObject:_email forKey:@"email"];
}

- (void)setServer:(NSString *)server{
    _server = server;
    
    [[NSUserDefaults standardUserDefaults] setObject:_server forKey:@"server"];
}



@end
