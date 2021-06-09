//
//  BGELoginResult.h
//  BGENetworking_Example
//
//  Created by bge on 2021/6/9.
//  Copyright © 2021 Bge. All rights reserved.
//

#import "BGEBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface BGELoginResult : JSONModel

@property (assign, nonatomic) NSInteger userID;
@property (strong, nonatomic) NSString *username;
@property (assign, nonatomic) NSInteger emchat;

@end

@interface BGELoginResultModel : BGEBaseModel

@property (strong, nonatomic) NSString *accessToken;
@property (strong, nonatomic) BGELoginResult *data;

@end

NS_ASSUME_NONNULL_END
