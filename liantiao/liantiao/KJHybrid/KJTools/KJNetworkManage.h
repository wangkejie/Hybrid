//
//  KJNetworkManage.h
//  liantiao
//
//  Created by jack on 2017/8/10.
//  Copyright © 2017年 jack. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

typedef enum : NSUInteger {
    NetworkMethodPOST,
    NetworkMethodGET,
    NetworkMethodPUT,
} NetworkMethod;

typedef void(^KJRequestCallback)(id result, NSError * error);

@interface KJNetworkManage : AFHTTPSessionManager

/**
 登录状态
 */
@property (nonatomic, assign) BOOL isLogin;
/**
 用户信息
 */
@property (nonatomic, strong) NSDictionary * userInfo;


+ (instancetype)sharedManager;

- (void)requestDataWithURLString:(NSString *)URLString parameters:(id)parameters Method:(NetworkMethod)method finished:(KJRequestCallback)finished;


@end
