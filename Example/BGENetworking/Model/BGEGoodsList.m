//
//  BGEGoodsList.m
//  BGENetworking_Example
//
//  Created by bge on 2021/6/5.
//  Copyright © 2021 Bge. All rights reserved.
//

#import "BGEGoodsList.h"

@implementation BGEGoods

+ (BOOL)propertyIsOptional:(NSString *)propertyName {
    return YES;
}

@end

@implementation BGEGoodsList

+ (BOOL)propertyIsOptional:(NSString *)propertyName {
    return NO;
}

@end
