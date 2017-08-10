//
//  KJHybridContentView.m
//  liantiao
//
//  Created by jack on 2017/8/9.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "KJHybridContentView.h"
#import "KJHybridTools.h"

@interface KJHybridContentView ()<UIWebViewDelegate>

@property (nonatomic, strong) KJHybridTools * tool;
@property (nonatomic, copy) NSString * htmlString;
@end

@implementation KJHybridContentView


- (void)setCookie:(NSString *)Cookie {
   
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
        self.tool = [KJHybridTools new];
    }
    return self;
}


- (void)initUI {
    self.backgroundColor = [UIColor whiteColor];
    self.delegate = self;
    self.scrollView.bounces = false;
    self.translatesAutoresizingMaskIntoConstraints = false;
    self.keyboardDisplayRequiresUserAction = false;
    self.scalesPageToFit = true;
}


#pragma mark - WEB delegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    
    if ([request.URL.scheme isEqualToString:@"lvka"]) {
        
        [self.tool analysis:request.URL.absoluteString webView:webView appendParams:nil];
        
        return false;
    }
    return YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    NSString * title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    [self.tool viewControllerOf:webView].title = title;
    
    NSString * htmlString = self.htmlString;
    if (htmlString) {
        [webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"document.body.innerHTML = document.body.innerHTML%@",htmlString]];
        self.htmlString = nil;
    }
    
}

@end
