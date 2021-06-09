//
//  BGEPlistModel.h
//  BGENetworking
//
//  Created by Bge on 06/04/2021.
//  Copyright (c) 2021 Bge. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol BGEPlistModel <NSObject>
@end

@protocol BGEConfig <NSObject>
@end

@protocol BGEConfigError <NSObject>
@end

/*
 * plist对应的解析类，通过plist拿到dictionary，用JSONModel转换成OC对象
 */
@class BGEConfig, BGEConfigUrl, BGEConfigError;
@interface BGEPlistModel : JSONModel

@property (strong, nonatomic) NSArray<BGEConfigError> *errors;
@property (strong, nonatomic) BGEConfig *configure;

@end

@interface BGEConfig : JSONModel

///支持的contentType类型
@property (strong, nonatomic) NSArray *acceptContentType;//array for NSString
///上传图片默认的mimeType类型
@property (strong, nonatomic) NSString *uploadImageDefaultMimeType;
///请求参数方式是JSON还是key=value&key2=value2形式
@property (assign, nonatomic) BOOL isJSONRequestSerializer;
///超时时间
@property (strong, nonatomic) NSString *timeoutInterval;
///基类，用于errorcode不成功时候的错误解析
@property (strong, nonatomic) NSString *analysisBaseClass;
@property (strong, nonatomic) NSString *errorCodeKeyPath;
@property (strong, nonatomic) NSString *errorMessageKeyPath;
///请求成功的code判断
@property (assign, nonatomic) NSInteger responseSuccessCode;
///服务器判定登录信息无效时候返回的code，收到这个token会发送bgeNetworkingLoginInvalidNotification通知
@property (assign, nonatomic) NSInteger loginStatusInvalidErrorCode;

@end

/*
 * 接口配置信息，通过name来找path和对应的接口解析类
 */
@interface BGEConfigUrl : JSONModel

///接口名称
@property (strong, nonatomic) NSString *name;
///接口路径
@property (strong, nonatomic) NSString *path;
///接口解析类
@property (strong, nonatomic) NSString *analysisClassName;

@end

/*
 * 错误配置信息，优先返回errorCode对应的错误描述
 */
@interface BGEConfigError : JSONModel

///错误码
@property (strong, nonatomic) NSString *name;
///错误信息
@property (strong, nonatomic) NSString *errorDescription;

@end
