//
//  BGENetworking.m
//  BGENetworking
//
//  Created by Bge on 06/04/2021.
//  Copyright (c) 2021 Bge. All rights reserved.
//

#import "BGENetworking.h"
#import <AFNetworking/AFNetworking.h>
#import <JSONModel/JSONModel.h>

NSString *_Nonnull const bgeNetworkingLoginInvalidNotification = @"BGENetworkingLoginInvalidNotification";
NSString *_Nonnull const bgeNetworkingVersion = @"1.0.3";

@interface BGENetworking ()

@end

@implementation BGENetworking

///上传图片格式，默认采用jpg格式上传
- (NSString *)imageFormat {
    if (!_imageFormat) {
        _imageFormat = [BGEPlistManage sharedInstance].bgePlistModel.configure.uploadImageDefaultMimeType;
    }
    
    return _imageFormat;
}

#pragma mark - request
- (nullable NSURLSessionDataTask *)GET:(nonnull NSString *)apiName
                               headers:(nullable NSDictionary *)headers
                            parameters:(nullable NSDictionary *)parameters
                              progress:(nullable progressHandle)progress
                          decryptBlock:(nonnull decryptBlock)decryptBlock
                               success:(nonnull successHandle)success
                               failure:(nullable failureHandle)failure {
    return [self _dataTaskWithHTTPMethod:@"GET" apiName:apiName headers:headers parameters:parameters uploadProgress:nil downloadProgress:^(double progress) {
        
    } decryptBlock:decryptBlock success:success failure:failure];
}

- (nullable NSURLSessionDataTask *)POST:(nonnull NSString *)apiName
                                headers:(nullable NSDictionary *)headers
                             parameters:(nullable NSDictionary *)parameters
                               progress:(nullable progressHandle)progress
                           decryptBlock:(nonnull decryptBlock)decryptBlock
                                success:(nonnull successHandle)success
                                failure:(nullable failureHandle)failure {
    return [self _dataTaskWithHTTPMethod:@"POST" apiName:apiName headers:headers parameters:parameters uploadProgress:^(double progress) {
        
    } downloadProgress:nil decryptBlock:decryptBlock success:success failure:failure];
}

- (nullable NSURLSessionDataTask *)DELETE:(nonnull NSString *)apiName
                                  headers:(nullable NSDictionary *)headers
                               parameters:(nullable NSDictionary *)parameters
                                 progress:(nullable progressHandle)progress
                             decryptBlock:(nonnull decryptBlock)decryptBlock
                                  success:(nonnull successHandle)success
                                  failure:(nullable failureHandle)failure {
    return [self _dataTaskWithHTTPMethod:@"DELETE" apiName:apiName headers:headers parameters:parameters uploadProgress:nil downloadProgress:nil decryptBlock:decryptBlock success:success failure:failure];
}


- (nullable NSURLSessionDataTask *)PUT:(nonnull NSString *)apiName
                               headers:(nullable NSDictionary *)headers
                            parameters:(nullable NSDictionary *)parameters
                              progress:(nullable progressHandle)progress
                          decryptBlock:(nonnull decryptBlock)decryptBlock
                               success:(nonnull successHandle)success
                               failure:(nullable failureHandle)failure {
    return [self _dataTaskWithHTTPMethod:@"PUT" apiName:apiName headers:headers parameters:parameters uploadProgress:nil downloadProgress:nil decryptBlock:decryptBlock success:success failure:failure];
}

- (nullable NSURLSessionDataTask *)PATCH:(nonnull NSString *)apiName
                                 headers:(nullable NSDictionary *)headers
                              parameters:(nullable NSDictionary *)parameters
                                progress:(nullable progressHandle)progress
                            decryptBlock:(nonnull decryptBlock)decryptBlock
                                 success:(nonnull successHandle)success
                                 failure:(nullable failureHandle)failure {
    return [self _dataTaskWithHTTPMethod:@"PATCH" apiName:apiName headers:headers parameters:parameters uploadProgress:nil downloadProgress:nil decryptBlock:decryptBlock success:success failure:failure];
}

- (nullable NSURLSessionDataTask *)uploadEnclosure:(nonnull NSDictionary *)enclosureDictionary
                                           apiName:(nonnull NSString *)apiName
                                           headers:(nullable NSDictionary *)headers
                                        parameters:(nullable NSDictionary *)parameters
                                      decryptBlock:(nonnull decryptBlock)decryptBlock
                                          progress:(nullable progressHandle)progress
                                           success:(nonnull successHandle)success
                                           failure:(nullable failureHandle)failure {
    NSString *hostUrl = [self hostUrl];
    NSString *path = [[BGEPlistManage sharedInstance] pathWithApiName:apiName];
    NSString *urlPath = [hostUrl stringByAppendingString:path];
    
    BGENetworkingLog(@"-------upload enclosure apiName: %@, request:%@?%@", apiName, urlPath, [self _stringWithRequestParam:parameters]);
    
    AFHTTPSessionManager *sessionManager = [self _bgeNetworkingSessionWithResponseSerializer:
                                            [AFHTTPResponseSerializer serializer]];
    
    return [sessionManager POST:urlPath
                     parameters:parameters headers:headers
      constructingBodyWithBlock:^(id < AFMultipartFormData > _Nonnull formData) {
        //循环添加上传的文件类型，文件名后缀需要自己加，iOS是文件流不是文件系统 没有文件名
        for (NSString *key in enclosureDictionary.allKeys) {
              NSData *enclosureData = [NSData dataWithData:[enclosureDictionary valueForKey:key]];
              [formData appendPartWithFileData:enclosureData name:key fileName:key mimeType:self.imageFormat];
        }
    } progress:^(NSProgress *_Nonnull downloadProgress) {
        if (progress) {
            progress(downloadProgress.fractionCompleted);
        }
    } success:^(NSURLSessionDataTask *_Nonnull task, id _Nullable responseObject) {
        NSDictionary *responseDictionary = [self _responseDictionaryWithData:responseObject decryptBlock:decryptBlock];
        [self _requestSuccessWithApiName:apiName responseObject:responseDictionary success:success failure:failure];
    } failure:^(NSURLSessionDataTask *_Nullable task, NSError *_Nonnull error) {
        [self _requestFailureWithApiName:apiName error:error failure:failure];
    }];
}

#pragma mark - private method
- (AFHTTPSessionManager *)_bgeNetworkingSessionWithResponseSerializer:(AFHTTPResponseSerializer *)responseSerializer {
    AFHTTPSessionManager *result = [AFHTTPSessionManager manager];
    
    result.requestSerializer = [AFJSONRequestSerializer serializer];
   
    result.responseSerializer = responseSerializer;
    
    //设置可接收的contentType类型
    NSArray *acceptContentTypeArray = [BGEPlistManage sharedInstance].bgePlistModel.configure.acceptContentType;
    [result.responseSerializer setAcceptableContentTypes:[NSSet setWithArray:acceptContentTypeArray]];
    
    //超时时间设置
    NSTimeInterval timeoutInterval = [[BGEPlistManage sharedInstance].bgePlistModel.configure.timeoutInterval doubleValue];
    [result.requestSerializer setTimeoutInterval:timeoutInterval];
    
    return result;
}

- (nullable NSURLSessionDataTask *)_dataTaskWithHTTPMethod:(nonnull NSString *)httpMethod
                                                  apiName:(nonnull NSString *)apiName
                                                  headers:(nullable NSDictionary *)headers
                                               parameters:(nullable NSDictionary *)parameters
                                           uploadProgress:(nullable progressHandle)uProgress
                                         downloadProgress:(nullable progressHandle)dProgress
                                             decryptBlock:(nonnull decryptBlock)decryptBlock
                                                  success:(nonnull successHandle)success
                                                  failure:(nullable failureHandle)failure {

    //拼接域名和路径
    NSString *hostUrl = [self hostUrl];
    NSString *path = [[BGEPlistManage sharedInstance] pathWithApiName:apiName];
    NSString *urlPath = [hostUrl stringByAppendingString:path];
    
    BGENetworkingLog(@"-------httpMethod apiName: %@, request:%@?%@", apiName, urlPath, [self _stringWithRequestParam:parameters]);
    
    AFHTTPSessionManager *sessionManager = [self _bgeNetworkingSessionWithResponseSerializer:
                                            [AFHTTPResponseSerializer serializer]];
    
    NSURLSessionDataTask *dataTask = [sessionManager dataTaskWithHTTPMethod:httpMethod URLString:urlPath parameters:parameters headers:headers uploadProgress:^(NSProgress * _Nonnull uploadProgress) {
        if (uProgress) {
            uProgress(uploadProgress.fractionCompleted);
        }
    } downloadProgress:^(NSProgress * _Nonnull downloadProgress) {
        if (dProgress) {
            dProgress(downloadProgress.fractionCompleted);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //请求成功的处理，考虑到返回数据可能加密（加密之后就不是json格式），返回都用data来接收，解密之后再转成dictionary
        NSDictionary *responseDictionary = [self _responseDictionaryWithData:responseObject decryptBlock:decryptBlock];
        [self _requestSuccessWithApiName:apiName responseObject:responseDictionary success:success failure:failure];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //请求失败的处理
        [self _requestFailureWithApiName:apiName error:error failure:failure];
    }];
    
    [dataTask resume];
    
    return dataTask;
}

//把返回的NSData类型转换为NSDictionary对象，中间加了解密的clock方法回调
- (NSDictionary *)_responseDictionaryWithData:(NSData *)data decryptBlock:(nonnull decryptBlock)decryptBlock {
    NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSData *jsonData = [decryptBlock(responseString) dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableLeaves error:nil];
    return responseDictionary;
}

///拼接请求参数打印在控制台
- (NSString *)_stringWithRequestParam:(NSDictionary *)parameters {
    NSString *result = @"";
    
    @try {
        NSMutableArray<NSString *> *paramStringArray = [@[] mutableCopy];
        
        for (NSString *key in[parameters allKeys]) {
            if ([parameters[key] isKindOfClass:[NSString class]]) {
                [paramStringArray addObject:[NSString stringWithFormat:@"%@=%@", key, parameters[key]]];
            }
            else if ([parameters[key] isKindOfClass:[NSArray class]]) {
                for (NSString *value in parameters[key]) {
                    [paramStringArray addObject:[NSString stringWithFormat:@"%@=%@", key, value]];
                }
            }
            else if ([parameters[key] isKindOfClass:[NSNumber class]]) {
                NSNumber *value = parameters[key];
                [paramStringArray addObject:[NSString stringWithFormat:@"%@=%@", key, [value stringValue]]];
            }
        }
        
        if (paramStringArray.count > 0) {
            result = [paramStringArray componentsJoinedByString:@"&"];
        }
    }
    @catch(NSException *exception) {
        BGENetworkingLog(@"param format to string error: %@", exception.description);
    }
    return result;
}

- (void)_requestSuccessWithApiName:(NSString *)apiName
                   responseObject:(id)responseObject
                          success:(nonnull successHandle)success
                          failure:(nullable failureHandle)failure {
    BGENetworkingLog(@"-------apiName: %@, response: %@", apiName, responseObject);
    
    int errorCode = [[responseObject valueForKeyPath:[BGEPlistManage sharedInstance].bgePlistModel.configure.errorCodeKeyPath] intValue];

    //考虑到不同的团队使用的成功的code可能不一样，在plist文件中配置
    if (errorCode == [BGEPlistManage sharedInstance].bgePlistModel.configure.responseSuccessCode) {
        //通过JSONModel方法把dictionary转换成对应的Model类返回
        NSString *className = [[BGEPlistManage sharedInstance] analysisClassNameWithApiName:apiName];
        Class class = NSClassFromString(className);
        id returnObject = [[class alloc] initWithDictionary:responseObject error:nil];

        if (![returnObject isMemberOfClass:class]) {
            BGENetworkingLog(@"-------apiName: %@, analysis class error: %@, actual class name: %@", apiName, NSStringFromClass(class), [returnObject class]);
        }
        
        success(returnObject);
    }
    else {
        //处理服务端逻辑错误，此处的解析类默认是plist中配置的BaseModel类
        Class class = NSClassFromString([BGEPlistManage sharedInstance].bgePlistModel.configure.analysisBaseClass);
        id returnObject = [[class alloc] initWithDictionary:responseObject error:nil];
        
        if (errorCode == [BGEPlistManage sharedInstance].bgePlistModel.configure.loginStatusInvalidErrorCode) {
            //object为YES表示要立即对登录校验token失效的情况做处理，调用者自己加逻辑判断防止死循环调用
            [[NSNotificationCenter defaultCenter] postNotificationName:bgeNetworkingLoginInvalidNotification object:@(YES)];
        }
        
        //如果本地config配置的errors有对应的name，则错误信息显示配置的errorDesctiption而不是服务端返回的错误信息
        NSString *errorDesctiption = [[BGEPlistManage sharedInstance] errorDescriptionWithErrorName:[NSString stringWithFormat:@"%d", errorCode]];
        if (errorDesctiption.length > 0) {
            [returnObject setValue:errorDesctiption forKeyPath:[BGEPlistManage sharedInstance].bgePlistModel.configure.errorMessageKeyPath];
        }
        
        if (failure) {
            failure(returnObject);
        }
    }
}

///请求的网络状态失败和服务器逻辑失败是同样的处理逻辑
- (void)_requestFailureWithApiName:(NSString *)apiName error:(NSError *)error failure:(failureHandle)failure {
    Class class = NSClassFromString([BGEPlistManage sharedInstance].bgePlistModel.configure.analysisBaseClass);
    id errorObject = [[class alloc] init];
    
    [errorObject setValue:[NSNumber numberWithInteger:error.code]
               forKeyPath:[BGEPlistManage sharedInstance].bgePlistModel.configure.errorCodeKeyPath];
    
    NSString *errorMessageString = error.localizedDescription ? error.localizedDescription : @"未知错误";
    
    [errorObject setValue:errorMessageString
               forKeyPath:[BGEPlistManage sharedInstance].bgePlistModel.configure.errorMessageKeyPath];
    
    //http请求的错误也优先用config配置的errors
    NSString *errorDesctiption = [[BGEPlistManage sharedInstance] errorDescriptionWithErrorName:[NSString stringWithFormat:@"%ld", (long)error.code]];
    if (errorDesctiption.length > 0) {
        [errorObject setValue:errorDesctiption forKeyPath:[BGEPlistManage sharedInstance].bgePlistModel.configure.errorMessageKeyPath];
    }
    
    if (failure) {
        failure(errorObject);
    }
}

@end
