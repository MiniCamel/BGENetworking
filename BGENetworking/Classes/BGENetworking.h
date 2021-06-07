//
//  BGENetworking.h
//  BGENetworking
//
//  Created by Bge on 06/04/2021.
//  Copyright (c) 2021 Bge. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BGEPlistManage.h"
#import "BGEPlistModel.h"
#import "BGENetworkingMarco.h"

typedef void(^progressHandle)(double progress);
typedef void(^successHandle)(id _Nullable responseObject);
typedef void(^failureHandle)(id _Nullable errorObject);

///解密block，针对返回json加密的情况
typedef NSString * _Nonnull (^decryptBlock)(NSString * _Nonnull);

UIKIT_EXTERN NSString * _Nonnull const bgeNetworkingLoginInvalidNotification;
UIKIT_EXTERN NSString * _Nonnull const bgeNetworkingVersion;

@interface BGENetworking : NSObject

@property (strong, nonatomic) NSString * _Nonnull imageFormat;
@property (strong, nonatomic) NSString * _Nonnull hostUrl;

- (nullable NSURLSessionDataTask *)GET:(nonnull NSString *)apiName
                               headers:(nullable NSDictionary *)headers
                            parameters:(nullable NSDictionary *)parameters
                              progress:(nullable progressHandle)progress
                          decryptBlock:(nonnull decryptBlock)decryptBlock
                               success:(nonnull successHandle)success
                               failure:(nullable failureHandle)failure;

- (nullable NSURLSessionDataTask *)POST:(nonnull NSString *)apiName
               headers:(nullable NSDictionary *)headers
                             parameters:(nullable NSDictionary *)parameters
                               progress:(nullable progressHandle)progress
                           decryptBlock:(nonnull decryptBlock)decryptBlock
                                success:(nonnull successHandle)success
                                failure:(nullable failureHandle)failure;

- (nullable NSURLSessionDataTask *)DELETE:(nonnull NSString *)apiName
                            headers:(nullable NSDictionary *)headers
                               parameters:(nullable NSDictionary *)parameters
                                 progress:(nullable progressHandle)progress
                             decryptBlock:(nonnull decryptBlock)decryptBlock
                                  success:(nonnull successHandle)success
                                  failure:(nullable failureHandle)failure;

- (nullable NSURLSessionDataTask *)PUT:(nonnull NSString *)apiName
                            headers:(nullable NSDictionary *)headers
                               parameters:(nullable NSDictionary *)parameters
                                 progress:(nullable progressHandle)progress
                             decryptBlock:(nonnull decryptBlock)decryptBlock
                                  success:(nonnull successHandle)success
                                  failure:(nullable failureHandle)failure;

- (nullable NSURLSessionDataTask *)PATCH:(nonnull NSString *)apiName
                                 headers:(nullable NSDictionary *)headers
                              parameters:(nullable NSDictionary *)parameters
                                progress:(nullable progressHandle)progress
                            decryptBlock:(nonnull decryptBlock)decryptBlock
                                 success:(nonnull successHandle)success
                                 failure:(nullable failureHandle)failure;

- (nullable NSURLSessionDataTask *)uploadEnclosure:(nonnull NSDictionary *)enclosureDictionary
                                           apiName:(nonnull NSString *)apiName
                                           headers:(nullable NSDictionary *)headers
                                        parameters:(nullable NSDictionary *)parameters
                                      decryptBlock:(nonnull decryptBlock)decryptBlock
                                          progress:(nullable progressHandle)progress
                                           success:(nonnull successHandle)success
                                           failure:(nullable failureHandle)failure;


@end
