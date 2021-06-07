//
//  BGEGoodsDetail.h
//  BGENetworking_Example
//
//  Created by bge on 2021/6/5.
//  Copyright © 2021 Bge. All rights reserved.
//

#import "BGEBaseModel.h"
#import "BGEGoodsList.h"

NS_ASSUME_NONNULL_BEGIN

@protocol BGEGoodsDetail <NSObject>

@end

@interface BGEGoodsDetail : BGEGoods

@property (assign, nonatomic) NSInteger price;

@end

@interface BGEGoodsDetailModel : BGEBaseModel

@property (strong, nonatomic) BGEGoodsDetail *data;

@end

NS_ASSUME_NONNULL_END
