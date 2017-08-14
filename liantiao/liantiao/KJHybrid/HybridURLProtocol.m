//
//  HybridURLProtocol.m
//  liantiao
//
//  Created by jack on 2017/8/9.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "HybridURLProtocol.h"

NSString * webAppBaseUrl = @"10.144.104.210";
NSString * DogHybridURLProtocolHandled = @"DogHybridURLProtocolHandled";



@implementation HybridURLProtocol


+ (NSString *)findCache:(NSURLRequest *)request {
    BOOL closeSwitch = [[NSUserDefaults standardUserDefaults] boolForKey:@"HybridSwitchCacheClose"];
    if (closeSwitch) {
        NSLog(@"读取资源 关");
        return nil;
    }
    
    NSArray * types = @[@"js",@"css",@"jpg",@"png"];
    
    NSURL * url = request.URL;
    if ([url.host isEqualToString: webAppBaseUrl]) {
        if (![types containsObject:url.pathExtension]) {
            return nil;
        }
        
        NSString * documentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
        NSString * pathStr = [NSString stringWithFormat:@"%@%@",documentPath,url.path];
        if ([[NSFileManager defaultManager] fileExistsAtPath:pathStr]) {
            return pathStr;
        }
        
    }
    
    
    return nil;
}

+ (BOOL)canInitWithRequest:(NSURLRequest *)request {
    
    id hasHandled = [NSURLProtocol propertyForKey:DogHybridURLProtocolHandled inRequest:request];
    if (hasHandled) {
        return false;
    }
    
    if ([self findCache:request]) {
        return true;
    }
    return false;
}

+ (NSURLRequest *)canonicalRequestForRequest:(NSURLRequest *)request {
    
    return request;
}

- (void)startLoading {
    //标记请求  防止重复处理
    NSDictionary * contentTpye = @{@"html": @"text/html", @"js": @"application/javascript", @"css": @"text/css", @"jpg": @"image/jpeg", @"png": @"image/png"};
    
    NSMutableURLRequest * mutableReqeust = self.request.mutableCopy;
    [NSURLProtocol setProperty:@YES forKey:DogHybridURLProtocolHandled inRequest:mutableReqeust];
    if (self.request.URL.host == webAppBaseUrl) {
        NSString * cachePath = [HybridURLProtocol findCache:self.request];
        id<NSURLProtocolClient> client = self.client;
        if (cachePath) {
            NSURL * url = [NSURL fileURLWithPath:cachePath];
            NSString * type = url.pathExtension;
            NSData * fileData = [NSData dataWithContentsOfURL:[NSURL fileURLWithPath:cachePath]];
            NSURLResponse * response = [[NSURLResponse alloc] initWithURL:url MIMEType:contentTpye[type] expectedContentLength:[fileData length] textEncodingName:@"UTF-8"];
            [client URLProtocol:self didReceiveResponse:response cacheStoragePolicy:NSURLCacheStorageAllowed];
            [client URLProtocol:self didLoadData:fileData];
            [client URLProtocolDidFinishLoading:self];
            
        }
        
    }
    
    
}
- (void)stopLoading {
    
}


@end
