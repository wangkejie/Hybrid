//
//  KJHybridViewController.m
//  liantiao
//
//  Created by jack on 2017/8/9.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "KJHybridViewController.h"
#import "KJHybridContentView.h"
#import "KJExtentsion.h"
#import "KJHybridTools.h"
#import "KJHybridModel.h"


@interface KJHybridViewController ()

@property (nonatomic, copy) NSString * URLPath;
@property (nonatomic, copy) NSString * Cookie;

@property (nonatomic, copy) NSString * onShowCallBack;
@property (nonatomic, copy) NSString * onHideCallBack;

@property (nonatomic, strong) KJHybridContentView * contentView;

@property (nonatomic, assign) BOOL naviBarHidden;

@end

@implementation KJHybridViewController

- (instancetype)init
{
    self = [super init];
    if (self) {

    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.URLPath = @"http://10.144.104.210:3000/index1.html?";

}

+ (instancetype)load:(NSString *)urlString sess:(NSString *)sess {
    NSURL * url = [NSURL URLWithString:[urlString hybridUrlPathAllowedString]];
    KJHybridViewController * webViewController = [KJHybridViewController new];
    webViewController.hidesBottomBarWhenPushed = YES;
    if ([url.scheme isEqualToString:@"lvka"]) {
        KJHybridModel * model = [[KJHybridTools new] contentResolver:urlString appendParams:nil];
        NSString * topageURL = model.args[@"topage"];
        webViewController.URLPath = topageURL;
        return webViewController;
    }else {
        webViewController.URLPath = url.absoluteString;
        return webViewController;
    }
    return nil;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self initContentView];
    // Do any additional setup after loading the view.
}
- (void)initUI {
    self.hidesBottomBarWhenPushed = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBar.hidden = self.naviBarHidden;
}
- (void)initContentView {
    
    self.contentView = [[KJHybridContentView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.contentView];
    
    self.contentView.translatesAutoresizingMaskIntoConstraints = false;
    NSLayoutConstraint * left = [NSLayoutConstraint constraintWithItem:self.contentView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0];
    NSLayoutConstraint * right = [NSLayoutConstraint constraintWithItem:self.contentView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1.0 constant:0];
    NSLayoutConstraint * top = [NSLayoutConstraint constraintWithItem:self.contentView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:64];
    NSLayoutConstraint * bottom = [NSLayoutConstraint constraintWithItem:self.contentView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0];
    
    
    [self.view addConstraints:@[left,right,top,bottom]];
    
    NSURLRequest * request = [self getRequest:self.URLPath];
    
    
    
    [self.contentView loadRequest:request ];
    
    
}

- (NSURLRequest *)getRequest:(NSString *)urlStr {
    NSString * urlStrPer = [urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
    NSURL * url = [NSURL URLWithString:urlStrPer];
    NSURLRequest * request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:20];
    return request;
}

@end
