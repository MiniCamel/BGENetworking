//
//  BGEEncryptDelegate.h
//  BGENetworking_Example
//
//  Created by bge on 2021/6/5.
//  Copyright © 2021 Bge. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol BGEEncryptDelegate <NSObject>

- (nonnull NSDictionary *)testEncrypt:(nonnull NSDictionary *)originParam;
- (nonnull NSDictionary *)encrypt:(nonnull NSDictionary *)originParam;

- (nonnull NSString *_Nonnull(^)(NSString * _Nonnull))dontNeedDecryptBlock;
- (nonnull NSString *_Nonnull(^)(NSString * _Nonnull))decryptBlock;
- (nonnull NSString *_Nonnull(^)(NSString * _Nonnull))testDecryptBlock;

@end

NS_ASSUME_NONNULL_END
