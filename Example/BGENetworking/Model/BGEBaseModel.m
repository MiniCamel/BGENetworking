//
//  BGEBaseModel.m
//  BGENetworking_Example
//
//  Created by bge on 2021/6/4.
//  Copyright © 2021 Bge. All rights reserved.
//

#import "BGEBaseModel.h"

@implementation MetaModel

+ (BOOL)propertyIsOptional:(NSString *)propertyName {
    return YES;
}

@end

@implementation BGEBaseModel

+ (BOOL)propertyIsOptional:(NSString *)propertyName {
    return YES;
}

@end
