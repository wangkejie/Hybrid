//
//  KJHybridModel.h
//  liantiao
//
//  Created by jack on 2017/8/9.
//  Copyright © 2017年 jack. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KJHybridModel : NSObject

@property (nonatomic, copy) NSString * function;
@property (nonatomic, copy) NSDictionary * args;
@property (nonatomic, copy) NSString * callbackId;

+ (instancetype)hybridWithFunction:(NSString *)func args:(NSDictionary *)args callBackId:(NSString *)callbackId;

@end
