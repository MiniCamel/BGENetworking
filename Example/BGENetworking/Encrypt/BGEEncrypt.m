//
//  BGEEncrypt.m
//  BGENetworking_Example
//
//  Created by bge on 2021/6/5.
//  Copyright © 2021 Bge. All rights reserved.
//

#import "BGEEncrypt.h"

@implementation BGEEncrypt

#pragma mark - singleton
static BGEEncrypt *singleton = nil;

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        singleton = [[[self class] alloc] init];
    });
    return singleton;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        singleton = [super allocWithZone:zone];
    });
    return singleton;
}

- (id)copyWithZone:(NSZone *)zone {
    return singleton;
}

#pragma mark - BGEEncryptDelegate
- (NSDictionary *)testEncrypt:(NSDictionary *)originParam {
    //接口测试加密
    return originParam;
}

- (NSDictionary *)encrypt:(NSDictionary *)originParam {
    //TODO 接口正式加密
    return originParam;
}

- (NSString * _Nonnull (^)(NSString * _Nonnull))decryptBlock {
    //TODO 返回json数据解密
    return ^(NSString *originString) {
        return originString;
//        NSLog(@"%@", [JFDES decrypt:originString encryptType:JFDESEncryptAwaitz]);
//        return IS_PRODUCTION
//        ?[JFDES decrypt:originString encryptType:JFDESEncryptAwaitz]
//        :[JFDES decrypt:originString encryptType:JFDESEncryptTest];
    };
}

- (NSString * _Nonnull (^)(NSString * _Nonnull))testDecryptBlock {
    //TODO 测试返回json数据解密
    return ^(NSString *originString) {
        return originString;
//        NSLog(@"%@", [JFDES decrypt:originString encryptType:JFDESEncryptAwaitz]);
//        return IS_PRODUCTION
//        ?[JFDES decrypt:originString encryptType:JFDESEncryptAwaitz]
//        :[JFDES decrypt:originString encryptType:JFDESEncryptTest];
    };
}

- (NSString * _Nonnull (^)(NSString * _Nonnull))dontNeedDecryptBlock {
    return ^(NSString *originString) {
        return originString;
    };
}


@end
