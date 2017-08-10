//
//  KJHybridTools.h
//  liantiao
//
//  Created by jack on 2017/8/9.
//  Copyright © 2017年 jack. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class KJHybridModel;

@interface KJHybridTools : NSObject


- (void)analysis:(NSString *)urlString webView:(UIWebView *)webView appendParams:(NSDictionary *)appendParams;

- (KJHybridModel *)contentResolver:(NSString *)urlStr appendParams:(NSDictionary <NSString *,NSString *>*)appendParams;

- (UIViewController *)viewControllerOf:(UIView * )view;

@end
