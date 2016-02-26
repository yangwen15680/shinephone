//
//  BaseRequest.h
//  shinelink
//
//  Created by sky on 16/2/26.
//  Copyright © 2016年 sky. All rights reserved.
//
typedef void (^successBlock) (id content);

#import <Foundation/Foundation.h>

@interface BaseRequest : NSObject
+ (void)requestWithMethod:(NSString *)method
                 paramars:(NSDictionary *)paramars
             paramarsSite:(NSString *)site
              sucessBlock:(successBlock)successBlock
                  failure:(void (^)(NSError * error))failure;

+ (void)requestWithMethodResponseStringResult:(NSString *)method
                                     paramars:(NSDictionary *)paramars
                                 paramarsSite:(NSString *)site
                                  sucessBlock:(successBlock)successBlock
                                      failure:(void (^)(NSError * error))failure;

+ (void)requestWithMethodByGet:(NSString *)method
                      paramars:(NSDictionary *)paramars
                  paramarsSite:(NSString *)site
                   sucessBlock:(successBlock)successBlock
                       failure:(void (^)(NSError * error))failure;

+ (void)requestWithMethodResponseJsonByGet:(NSString *)method
                                  paramars:(NSDictionary *)paramars
                              paramarsSite:(NSString *)site
                               sucessBlock:(successBlock)successBlock
                                   failure:(void (^)(NSError * error))failure;

+ (void)requestImageWithMethodByGet:(NSString *)method
                           paramars:(NSDictionary *)paramars
                       paramarsSite:(NSString *)site
                        sucessBlock:(successBlock)successBlock
                            failure:(void (^)(NSError * error))failure;

+ (void)requestWithMethod:(NSString *)method
                 paramars:(NSDictionary *)paramars
             paramarsSite:(NSString *)site
                dataImage:(NSData *)data
              sucessBlock:(successBlock)successBlock
                  failure:(void (^)(NSError * error))failure;

+ (void)uplodImageWithMethod:(NSString *)method
                    paramars:(NSDictionary *)paramars
                paramarsSite:(NSString *)site
               dataImageDict:(NSMutableDictionary *)dataDict
                 sucessBlock:(successBlock)successBlock
                     failure:(void (^)(NSError * error))failure;


@end
