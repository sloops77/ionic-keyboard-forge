#import "IonicKeyboard.h"
#import "UIWebViewExtension.h"

@implementation IonicKeyboard

@synthesize hideKeyboardAccessoryBar = _hideKeyboardAccessoryBar;
@synthesize disableScroll = _disableScroll;
//@synthesize styleDark = _styleDark;

static IonicKeyboard* ionicKeyboard = Nil;

+ (IonicKeyboard*) getIonicKeyboardWithWebView:(UIWebView*) theWebView AndViewController:(UIViewController*) theViewController{
    if (!ionicKeyboard) {
        ionicKeyboard = [[IonicKeyboard alloc] initWithWebView: theWebView AndViewController:theViewController ];
    }
    return ionicKeyboard;
}

- (IonicKeyboard*)initWithWebView:(UIWebView*) theWebView AndViewController:(UIViewController*) theViewController {
    self = [super init];
    _webView = theWebView;
    _viewController = theViewController;
    
    NSNotificationCenter* nc = [NSNotificationCenter defaultCenter];

    //set defaults
    self.hideKeyboardAccessoryBar = NO;
    self.disableScroll = NO;
    //self.styleDark = NO;
    
    _keyboardShowObserver = [nc addObserverForName:UIKeyboardWillShowNotification
                                            object:nil
                                             queue:[NSOperationQueue mainQueue]
                                        usingBlock:^(NSNotification* notification) {
                                            
                                            CGRect keyboardFrame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
                                            keyboardFrame = [_viewController.view convertRect:keyboardFrame fromView:nil];
                                            
                                            NSString* keyboardHeight = [@(keyboardFrame.size.height) stringValue];
                                            [[ForgeApp sharedApp] event:@"native.keyboardshow" withParam:@{@"keyboardHeight":  keyboardHeight}];
                                            
//                                            [weakSelf.commandDelegate evalJs:[NSString stringWithFormat:@"cordova.plugins.Keyboard.isVisible = true; cordova.fireWindowEvent('native.keyboardshow', { 'keyboardHeight': %@ }); ", [@(keyboardFrame.size.height) stringValue]]];
//                                            
//                                            //deprecated
//                                            [weakSelf.commandDelegate evalJs:[NSString stringWithFormat:@"cordova.fireWindowEvent('native.showkeyboard', { 'keyboardHeight': %@ }); ", [@(keyboardFrame.size.height) stringValue]]];
                                        }];
    
    _keyboardHideObserver = [nc addObserverForName:UIKeyboardWillHideNotification
                                            object:nil
                                             queue:[NSOperationQueue mainQueue]
                                        usingBlock:^(NSNotification* notification) {
                                            [[ForgeApp sharedApp] event:@"native.keyboardhide" withParam:nil];
                                             
//                                            [weakSelf.commandDelegate evalJs:@"cordova.plugins.Keyboard.isVisible = false; cordova.fireWindowEvent('native.keyboardhide'); "];
//                                            
//                                            //deprecated
//                                            [weakSelf.commandDelegate evalJs:@"cordova.fireWindowEvent('native.hidekeyboard'); "];
                                        }];
    return self;
}
                             
- (BOOL)disableScroll {
    return _disableScroll;
}

- (void)setDisableScroll:(BOOL)disableScroll {
    if (disableScroll == _disableScroll) {
        return;
    }
    if (disableScroll) {
        _webView.scrollView.scrollEnabled = NO;
        _webView.scrollView.delegate = self;
    }
    else {
        _webView.scrollView.scrollEnabled = YES;
        _webView.scrollView.delegate = nil;
    }
    
    _disableScroll = disableScroll;
}


- (BOOL)hideKeyboardAccessoryBar {
    return _hideKeyboardAccessoryBar;
}

- (void)setHideKeyboardAccessoryBar:(BOOL)hideKeyboardAccessoryBar {
    if (hideKeyboardAccessoryBar == _hideKeyboardAccessoryBar) {
        return;
    }
    if (hideKeyboardAccessoryBar) {
        _webView.hackishlyHidesInputAccessoryView = YES;
    }
    else {
        _webView.hackishlyHidesInputAccessoryView = NO;
    }

    _hideKeyboardAccessoryBar = hideKeyboardAccessoryBar;
}

/*
 - (BOOL)styleDark {
 return _styleDark;
 }
 
 - (void)setStyleDark:(BOOL)styleDark {
 if (styleDark == _styleDark) {
 return;
 }
 if (styleDark) {
 _webView.styleDark = YES;
 }
 else {
 _webView.styleDark = NO;
 }
 
 _styleDark = styleDark;
 }
 */


/* ------------------------------------------------------------- */

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [scrollView setContentOffset: CGPointZero];
}

/* ------------------------------------------------------------- */

- (void)dealloc {
    NSNotificationCenter* nc = [NSNotificationCenter defaultCenter];
    
    [nc removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [nc removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

/* ------------------------------------------------------------- */

//- (void) disableScroll:(CDVInvokedUrlCommand*)command {
//    if (!command.arguments || ![command.arguments count]){
//        return;
//    }
//    id value = [command.arguments objectAtIndex:0];
//    
//    self.disableScroll = [value boolValue];
//}
//
//- (void) hideKeyboardAccessoryBar:(CDVInvokedUrlCommand*)command {
//    if (!command.arguments || ![command.arguments count]){
//        return;
//    }
//    id value = [command.arguments objectAtIndex:0];
//    
//    self.hideKeyboardAccessoryBar = [value boolValue];
//}
//
//- (void) close:(CDVInvokedUrlCommand*)command {
//    [_webView endEditing:YES];
//}

@end

//@implementation IonicKeyboard
//
//@synthesize disableScroll = _disableScroll;
//@synthesize scrollView;
//
//- (id)initWithScrollView: (UIScrollView *) aScrollView {
//    self = [super init];
//    
//    if (self) {
//        self.disableScroll = NO;
//        self.scrollView = aScrollView;
//    }
//    
//    return self;
//}
//
////@synthesize styleDark = _styleDark;
//
//- (BOOL)disableScroll {
//    return _disableScroll;
//}
//
//- (void)setDisableScroll:(BOOL)disableScroll {
//    if (disableScroll == _disableScroll) {
//        return;
//    }
//    if (disableScroll) {
//        self.scrollView.scrollEnabled = NO;
//        self.scrollView.delegate = self;
//    }
//    else {
//        self.scrollView.scrollEnabled = YES;
//        self.scrollView.delegate = nil;
//    }
//    
//    _disableScroll = disableScroll;
//}

//@end
