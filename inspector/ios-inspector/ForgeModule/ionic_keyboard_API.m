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
    IonicKeyboard* ionicKeyboard = [IonicKeyboard getIonicKeyboardWithWebView:(UIWebView *) [IonicForgeUtil getView] AndViewController:[[ForgeApp sharedApp] viewController]];
    ionicKeyboard.hideKeyboardAccessoryBar = [val boolValue];
    [task success:@"Keyboard accessory bar changed"];
}

+ (void)close:(ForgeTask*)task {
    [[IonicForgeUtil getView] endEditing:YES];
    [task success:nil];
}

+ (void)showAlert:(ForgeTask*)task text:(NSString *)text {
	if ([text length] == 0) {
		[task error:@"You must enter a message"];
		return;
	}
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert"
													message:text
												   delegate:nil
										  cancelButtonTitle:@"OK"
										  otherButtonTitles:nil];
	[alert show];
	[task success:nil];
}

@end
