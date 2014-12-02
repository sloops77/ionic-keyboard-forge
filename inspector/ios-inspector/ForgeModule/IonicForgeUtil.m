#import "IonicForgeUtil.h"

#import "IonicKeyboard.h"
#import <WebKit/WebKit.h>

@implementation IonicForgeUtil

+ (BOOL) isWkWebView {
    return NSClassFromString(@"WKWebView") && [[ForgeApp sharedApp] useWKWebView];
}

+ (UIView*) getView {
    if (NSClassFromString(@"WKWebView") && [[ForgeApp sharedApp] useWKWebView]) {
        return (WKWebView *) [[ForgeApp sharedApp] webView];
    } else {
        return (UIWebView *) [[ForgeApp sharedApp] webView];
    }
}

@end