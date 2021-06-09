//
//  BGEViewController.m
//  BGENetworking
//
//  Created by Bge on 06/07/2021.
//  Copyright (c) 2021 Bge. All rights reserved.
//

#import "BGEViewController.h"
#import "BGEBaseNetworking.h"
#import "BGECenterNetworking.h"
#import "BGEEncrypt.h"
#import "BGELoginResult.h"

@interface BGEViewController ()

@end

@implementation BGEViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    [[BGEBaseNetworking sharedInstance] POST:@"Login/login" headers:@{} parameters:@{@"mobile":@"15312584242", @"password": @"123456"} progress:nil decryptBlock:[[BGEEncrypt sharedInstance] dontNeedDecryptBlock] model:[BGELoginResultModel class] success:^(id  _Nullable responseObject) {
        BGELoginResultModel *loginResult = (BGELoginResultModel *)responseObject;
        NSLog(@"%@", loginResult);

        
        //goodsDetail
//        BGEGoodsDetail *goodsDetail = (BGEGoodsDetail *)responseObject;
        
        //get verify codeAT
//        BGEBaseModel *error = (BGEBaseModel *)responseObject;
//        NSLog(@"error: %ld, %@", error.meta.code, error.meta.desc);
    } failure:^(id  _Nullable errorObject) {
        BGEBaseModel *error = (BGEBaseModel *)errorObject;
        NSLog(@"error: %ld, %@", error.meta.code, error.meta.desc);
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

