//
//  BGEPlistModel.m
//  BGENetworking
//
//  Created by Bge on 06/04/2021.
//  Copyright (c) 2021 Bge. All rights reserved.
//

#import "BGEPlistModel.h"

///plist和类成员变量是一一对应的，所以isOptional都为NO
@implementation BGEConfig

+ (BOOL)propertyIsOptional:(NSString *)propertyName {
    return NO;
}

@end

@implementation BGEConfigUrl

+ (BOOL)propertyIsOptional:(NSString *)propertyName {
    return NO;
}

@end

@implementation BGEConfigError

+ (BOOL)propertyIsOptional:(NSString *)propertyName {
    return NO;
}

@end

@implementation BGEPlistModel

+ (BOOL)propertyIsOptional:(NSString *)propertyName {
    return NO;
}

@end
