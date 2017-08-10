//
//  KJExtentsion.m
//  liantiao
//
//  Created by jack on 2017/8/9.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "KJExtentsion.h"

@implementation KJExtentsion

@end

@implementation NSURL (URL)

- (NSMutableDictionary *)hybridURLParamsDic {
    NSArray * paramArray = [self.query componentsSeparatedByString:@"&"];
    if (paramArray.count == 0) {
        return nil;
    }
    NSMutableDictionary * dic = [NSMutableDictionary dictionaryWithCapacity:paramArray.count];
    for (NSString * str in paramArray) {
        
        NSArray * tempArray = [str componentsSeparatedByString:@"="];
        if (tempArray.count == 2) {
            [dic setObject:tempArray[1] forKey:tempArray[0]];
        }
        
    }
    return dic;
}

@end

@implementation NSString (String)

- (NSString *)hybridDecodeURLString {
    return [self stringByRemovingPercentEncoding];
}
- (NSString *)hybridUrlPathAllowedString {
    NSString * tempStr = [self stringByRemovingPercentEncoding];
    
    return [tempStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
}
- (NSDictionary *)hybridDecodeJsonStr {
    NSData * jsonData = [self dataUsingEncoding:NSUTF8StringEncoding];
    if (jsonData && self.length) {
        
        return [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
    }
    return nil;
}
- (NSString *)hybridURLString:(NSDictionary *)appendParams {
    NSURL * topageURL = [NSURL URLWithString:self];
    NSMutableDictionary * paramsDic = [topageURL hybridURLParamsDic];
    for (NSString * key in appendParams.allKeys) {
        id value = appendParams[key];
        if (value) {
            [paramsDic setValue:value forKey:key];
        }
    }
    
    NSMutableArray * paramsArray = [NSMutableArray arrayWithCapacity:appendParams.allKeys.count];
    for (NSString * key in paramsDic.allKeys) {
        NSString * value = appendParams[key];
        if (value) {
            [paramsArray addObject:[NSString stringWithFormat:@"%@=%@",key,value]];
        }
    }
    NSString * paramsString = [paramsArray componentsJoinedByString:@"&"];
    NSString * host = topageURL.host;
    NSString * scheme = topageURL.scheme;
    if (host && scheme && paramsString.length) {
        NSString * newTopageURL = [NSString stringWithFormat:@"%@:///%@%@?%@",scheme,host,topageURL.path,paramsString];
        return newTopageURL;
    }
    return self;
}
@end

@implementation NSDictionary (HybridDictionary)

- (NSString *)hybridJSONString {
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:nil];
    NSString * strJson = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    if (strJson.length) {
        return strJson;
    }
    return @"";
}

@end
