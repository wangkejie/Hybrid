//
//  KJHybridModel.m
//  liantiao
//
//  Created by jack on 2017/8/9.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "KJHybridModel.h"

@implementation KJHybridModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.function = nil;
        self.args = nil;
        self.callbackId = nil;
    }
    return self;
}

+ (instancetype)hybridWithFunction:(NSString *)func args:(NSDictionary *)args callBackId:(NSString *)callbackId {
    KJHybridModel * model = [self new];
    model.function = func;
    model.args = args;
    model.callbackId = callbackId;
    return model;
}

@end
