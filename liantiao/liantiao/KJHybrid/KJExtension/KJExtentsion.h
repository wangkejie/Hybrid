//
//  KJExtentsion.h
//  liantiao
//
//  Created by jack on 2017/8/9.
//  Copyright © 2017年 jack. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KJExtentsion : NSObject

@end


@interface NSURL (URL)

- (NSMutableDictionary *)hybridURLParamsDic;

@end

@interface NSString (String)

- (NSString *)hybridDecodeURLString;
- (NSString *)hybridUrlPathAllowedString;
- (NSDictionary *)hybridDecodeJsonStr;
- (NSString *)hybridURLString:(NSDictionary *)appendParams;

@end

@interface NSDictionary (HybridDictionary)

- (NSString *)hybridJSONString;

@end
