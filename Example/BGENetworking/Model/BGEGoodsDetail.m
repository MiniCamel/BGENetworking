//
//  BGEGoodsDetail.m
//  BGENetworking_Example
//
//  Created by bge on 2021/6/5.
//  Copyright © 2021 Bge. All rights reserved.
//

#import "BGEGoodsDetail.h"

@implementation BGEGoodsDetail

+ (BOOL)propertyIsOptional:(NSString *)propertyName {
    return YES;
}

@end

@implementation BGEGoodsDetailModel

+ (BOOL)propertyIsOptional:(NSString *)propertyName {
    return NO;
}

@end
