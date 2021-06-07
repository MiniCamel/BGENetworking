//
//  BGEGoodsList.h
//  BGENetworking_Example
//
//  Created by bge on 2021/6/5.
//  Copyright © 2021 Bge. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "BGEBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@protocol BGEGoods <NSObject>

@end

@interface BGEGoods : JSONModel

@property (assign, nonatomic) long long id;
@property (strong, nonatomic) NSString *name;
@property (assign, nonatomic) NSInteger stock;

@end

@interface BGEGoodsList : BGEBaseModel

@property (strong, nonatomic) NSArray<BGEGoods> *data;

@end

NS_ASSUME_NONNULL_END
