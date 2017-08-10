//
//  KJHybridViewController.h
//  liantiao
//
//  Created by jack on 2017/8/9.
//  Copyright © 2017年 jack. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    AnimateTypeNormal,
    AnimateTypePush,
    AnimateTypePop,
} AnimateType;


@interface KJHybridViewController : UIViewController

@property (nonatomic, copy) NSString * cookie;
@property (nonatomic, assign) AnimateType animateType;

+ (instancetype)load:(NSString *)urlString sess:(NSString *)sess;

@end
