//
//  BGEBaseModel.h
//  BGENetworking_Example
//
//  Created by bge on 2021/6/4.
//  Copyright © 2021 Bge. All rights reserved.
//

#import <JSONModel/JSONModel.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MetaModel <NSObject>

@end

@interface MetaModel : JSONModel

@property (assign, nonatomic) NSInteger code;
@property (strong, nonatomic) NSString *desc;
@property (assign, nonatomic) NSInteger count;//分页的总条数

@end

@protocol BGEBaseModel <NSObject>

@end

@interface BGEBaseModel : JSONModel

@property (strong, nonatomic) MetaModel *meta;

@end

NS_ASSUME_NONNULL_END
