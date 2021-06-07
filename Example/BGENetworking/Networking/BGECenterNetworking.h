//
//  BGECenterNetworking.h
//  BGENetworking_Example
//
//  Created by bge on 2021/6/5.
//  Copyright © 2021 Bge. All rights reserved.
//

#import <BGENetworking/BGENetworking.h>
#import "BGEEncryptDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface BGECenterNetworking : BGENetworking

@property (weak, nonatomic) id<BGEEncryptDelegate> delegate;

+ (nullable instancetype)sharedInstance;

@end

NS_ASSUME_NONNULL_END
