//
//  KJNetworkManage.m
//  liantiao
//
//  Created by jack on 2017/8/10.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "KJNetworkManage.h"

@implementation KJNetworkManage

+ (instancetype)sharedManager {
    static KJNetworkManage * _sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedManager = [[self alloc] initWithBaseURL:[NSURL URLWithString:@""]];
    });
    return _sharedManager;
}
- (instancetype)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    if (self) {
        self.responseSerializer = [AFJSONResponseSerializer serializer];
        self.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/plain", @"text/javascript", @"text/json", @"text/html", nil];
        self.requestSerializer = [AFHTTPRequestSerializer serializer];
        self.requestSerializer.timeoutInterval = 15.f;
        self.securityPolicy.allowInvalidCertificates = YES;
        self.securityPolicy.validatesDomainName = NO;//不验证证书的域名

    }
    return self;
}

- (void)requestDataWithURLString:(NSString *)URLString parameters:(id)parameters Method:(NetworkMethod)method finished:(KJRequestCallback)finished {
    
    if (parameters == nil) {
        parameters = @{};
    }
    
    NSString *methodName;
    switch (method) {
        case NetworkMethodGET:
            methodName = @"GET";
            [self kjGetUrl:URLString parameters:parameters finished:finished];
            break;
        case NetworkMethodPOST:
            methodName = @"POST";
            [self kjPostUrl:URLString parameters:parameters finished:finished];
            break;
        case NetworkMethodPUT:
            methodName = @"PUT";
            break;
        default: methodName = @"POST";
            [self kjPostUrl:URLString parameters:parameters finished:finished];
            break;
    }

}

- (void)kjGetUrl:(NSString *)urlStr parameters:(id)parameters finished:(KJRequestCallback)finished {
    [self GET:urlStr parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (finished) {
            finished(responseObject, nil);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (finished) {
            finished(nil, error);
        }
    }];
}

- (void)kjPostUrl:(NSString *)urlStr parameters:(id)parameters finished:(KJRequestCallback)finished {
    [self POST:urlStr parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (finished) {
            finished(responseObject, nil);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (finished) {
            finished(nil,error);
        }
    }];
}

@end
