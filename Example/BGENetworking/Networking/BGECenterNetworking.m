//
//  BGECenterNetworking.m
//  BGENetworking_Example
//
//  Created by bge on 2021/6/5.
//  Copyright © 2021 Bge. All rights reserved.
//

#import "BGECenterNetworking.h"
#import "BGEEncrypt.h"

@implementation BGECenterNetworking

#pragma mark - singleton
static BGECenterNetworking *singleton = nil;

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
        singleton.delegate = [BGEEncrypt sharedInstance];
    });
    return singleton;
}

- (id)copyWithZone:(NSZone *)zone {
    return singleton;
}

#pragma mark - override method
- (nonnull NSString *)hostUrl {
    NSString *result = [super hostUrl];
    if (!result) {
        result = @"https://test.zscenter.zhaosha.com/index.php/Home/";
//        result = @"https://center.zhaosha.com/index.php/Home/";
        self.hostUrl = result;
    }
    return result;
}

@end
