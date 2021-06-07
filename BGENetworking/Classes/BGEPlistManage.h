//
//  BGEPlistManage.h
//  BGENetworking
//
//  Created by Bge on 06/04/2021.
//  Copyright (c) 2021 Bge. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BGEPlistModel;
@interface BGEPlistManage : NSObject <NSCopying>

@property (strong, nonatomic, readonly) BGEPlistModel *bgePlistModel;

+ (instancetype)sharedInstance;

//urls
- (NSString *)pathWithApiName:(NSString *)apiName;
- (NSString *)analysisClassNameWithApiName:(NSString *)apiName;

//errors
- (NSString *)errorDescriptionWithErrorName:(NSString *)errorName;

@end
