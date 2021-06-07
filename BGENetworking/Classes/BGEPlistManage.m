//
//  BGEPlistManage.m
//  BGENetworking
//
//  Created by Bge on 06/04/2021.
//  Copyright (c) 2021 Bge. All rights reserved.
//

#import "BGEPlistManage.h"
#import "BGENetworkingMarco.h"
#import "BGEPlistModel.h"

@interface BGEPlistManage ()

@property (strong, nonatomic, readwrite) BGEPlistModel *bgePlistModel;

@end

@implementation BGEPlistManage

NSString * const bgeConfigFileName = @"BGEConfig.plist";

#pragma mark - singleton
static BGEPlistManage *singleton = nil;

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
        
        NSError *error;
        singleton.bgePlistModel = [[BGEPlistModel alloc] initWithDictionary:[singleton _plistDataWithConfig] error:&error];
        if (error) {
            BGENetworkingLog(@"Config initial failed: %@, check this file, please!", error.description);
        }
    });
    return singleton;
}

- (id)copyWithZone:(NSZone *)zone {
    return singleton;
}

#pragma mark - public method
///根据apiName返回对应的path
- (NSString *)pathWithApiName:(NSString *)apiName {
    NSArray *urlsArray = self.bgePlistModel.urls;
    for (int i = 0; i < urlsArray.count; i++) {
        BGEConfigUrl *bgeConfigUrl = [urlsArray objectAtIndex:i];
        if ([bgeConfigUrl.name isEqualToString:apiName]) {
            return bgeConfigUrl.path;
        }
    }
    
    BGENetworkingLog(@"path for api name '%@' not found", apiName);
    return [NSString new];
}

///根据apiName返回对应的解析类名
- (NSString *)analysisClassNameWithApiName:(NSString *)apiName {
    NSArray *urlsArray = self.bgePlistModel.urls;
    for (int i = 0; i < urlsArray.count; i++) {
        BGEConfigUrl *bgeConfigUrl = [urlsArray objectAtIndex:i];
        if ([bgeConfigUrl.name isEqualToString:apiName]) {
            return bgeConfigUrl.analysisClassName;
        }
    }
    
    BGENetworkingLog(@"analysis class name for api name '%@' not found", apiName);
    return [NSString new];
}

///根据错误码返回对应的错误信息
- (NSString *)errorDescriptionWithErrorName:(NSString *)errorName {
    NSArray *errorsArray = self.bgePlistModel.errors;
    for (int i = 0; i < errorsArray.count; i++) {
        BGEConfigError *bgeConfigError = [errorsArray objectAtIndex:i];
        if ([bgeConfigError.name isEqualToString:errorName]) {
            return bgeConfigError.errorDescription;
        }
    }
    
    BGENetworkingLog(@"error for error name '%@' not found", errorName);
    return [NSString new];
}

#pragma mark - private method
///获取plist文件的内容（dictionary）
- (NSDictionary *)_plistDataWithConfig {
    NSArray *array = [bgeConfigFileName componentsSeparatedByString:@"."];
    
    //cocoapods中使用的plist文件不能直接用mainBundle，要使用org.cocoapods.xxx
    NSBundle *bundle = [NSBundle bundleWithIdentifier:@"org.cocoapods.BGENetworking"];
    NSString *plistPath = [bundle pathForResource:array[0] ofType:array[1]];
    NSDictionary *data = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
    return data;
}

@end
