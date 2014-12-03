#import "ionic_keyboard_API.h"

#import "IonicForgeUtil.h"
#import "IonicKeyboard.h"

@implementation ionic_keyboard_API
+ (void) disableScroll:(ForgeTask*)task val:(NSNumber *)val {
    IonicKeyboard* ionicKeyboard = [IonicKeyboard getIonicKeyboardWithWebView:(UIWebView*) [IonicForgeUtil getView] AndViewController:[[ForgeApp sharedApp] viewController]]; 
    ionicKeyboard.disableScroll = [val boolValue];
    [task success:@"Native scroll changed"];
}

+ (void) hideKeyboardAccessoryBar:(ForgeTask*)task val:(NSNumber *)val {
    IonicKeyboard *ionicKeyboard = [IonicKeyboard getIonicKeyboardWithWebView:(UIWebView *) [IonicForgeUtil getView] AndViewController:[[ForgeApp sharedApp] viewController]];
    ionicKeyboard.hideKeyboardAccessoryBar = [val boolValue];
    [task success:@"Keyboard accessory bar changed"];
}

+ (void) isKeyboardVisible:(ForgeTask*)task {
    IonicKeyboard* ionicKeyboard = [IonicKeyboard getIonicKeyboardWithWebView:(UIWebView *) [IonicForgeUtil getView] AndViewController:[[ForgeApp sharedApp] viewController]];

    [task success:[NSNumber numberWithBool:ionicKeyboard.keyboardVisible]];
}

+ (void)close:(ForgeTask*)task {
    [[IonicForgeUtil getView] endEditing:YES];
    [task success:nil];
}

@end
