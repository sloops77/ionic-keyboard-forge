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
    
    _keyboardShowObserver = [nc addObserverForName:UIKeyboardWillShowNotification
                                            object:nil
                                             queue:[NSOperationQueue mainQueue]
                                        usingBlock:^(NSNotification* notification) {
                                            CGRect keyboardFrame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
                                            keyboardFrame = [_viewController.view convertRect:keyboardFrame fromView:nil];

                                            NSNumber* keyboardHeight = @(keyboardFrame.size.height);
                                            [[ForgeApp sharedApp] event:@"setProperty" withParam:@{@"name":  @"forge.ionic_keyboard.isVisible", @"value": [NSNumber numberWithBool:YES]}];
                                            [[ForgeApp sharedApp] event:@"fireWindowEvent" withParam:@{@"eventType": @"native.keyboardshow", @"keyboardHeight":  keyboardHeight}];
                                        }];
    
    _keyboardHideObserver = [nc addObserverForName:UIKeyboardWillHideNotification
                                            object:nil
                                             queue:[NSOperationQueue mainQueue]
                                        usingBlock:^(NSNotification* notification) {

                                            [[ForgeApp sharedApp] event:@"setProperty" withParam:@{@"name":  @"forge.ionic_keyboard.isVisible", @"value": [NSNumber numberWithBool:NO]}];
                                            [[ForgeApp sharedApp] event:@"fireWindowEvent" withParam:@{@"eventType":@"native.keyboardhide"}];
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

/* ------------------------------------------------------------- */

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [scrollView setContentOffset: CGPointMake(0, -scrollView.contentInset.top)];
}

/* ------------------------------------------------------------- */

- (void)dealloc {
    NSNotificationCenter* nc = [NSNotificationCenter defaultCenter];
    
    [nc removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [nc removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

/* ------------------------------------------------------------- */

@end

