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
#import "BGEGoodsList.h"
#import "BGEGoodsDetail.h"

@interface BGEViewController ()

@end

@implementation BGEViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    [[BGEBaseNetworking sharedInstance] POST:@"goodsList" headers:@{} parameters:@{@"userID":@200} progress:nil decryptBlock:[[BGEEncrypt sharedInstance] dontNeedDecryptBlock] success:^(id  _Nullable responseObject) {
        //goodsList
        BGEGoodsList *goodsList = (BGEGoodsList *)responseObject;
        NSLog(@"%ld, %@, %ld", goodsList.meta.code, goodsList.meta.desc, goodsList.meta.count);
        NSLog(@"%ld, %@", goodsList.data.count, goodsList.data.firstObject);
        
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

