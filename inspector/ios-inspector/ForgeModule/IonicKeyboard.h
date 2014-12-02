//
//  IonicKeyboard.h
//  ForgeModule
//
//  Created by Andres Olave on 06/11/2014.
//  Copyright (c) 2014 Trigger Corp. All rights reserved.
//

@interface IonicKeyboard : NSObject  <UIScrollViewDelegate> {
@protected
    id _keyboardShowObserver, _keyboardHideObserver;
    __weak UIViewController* _viewController;
    __weak UIWebView* _webView;
}

+ (IonicKeyboard*) getIonicKeyboardWithWebView:(UIWebView*) theWebView AndViewController:(UIViewController*) theViewController;

-(IonicKeyboard*)initWithWebView:(UIWebView*) theWebView AndViewController:(UIViewController*) theViewController;

@property (readwrite, assign) BOOL hideKeyboardAccessoryBar;
@property (readwrite, assign) BOOL disableScroll;
@property (readonly, assign) BOOL keyboardVisible;

@end
