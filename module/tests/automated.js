module("ionic_keyboard");

// In this test we call the example showAlert API method with an empty string
// In the example API method an empty string will immediately call the error callback
asyncTest("Attempt to enable then disable scroll on scrollView", 1, function() {
    forge.ionic_keyboard.disableScroll(true, function () {
        ok(true, "Expected success");
        // ok(true, "Expected failure, got success");
        start();
    }, function () {
        ok(false, "Expected success");
        start();
    });
});

asyncTest("Attempt to hide the accessory bar", 1, function() {
    forge.ionic_keyboard.hideKeyboardAccessoryBar(true, function () {
        ok(true, "Expected success");
        start();
    }, function () {
        ok(false, "Expected success");
        start();
    });
});

asyncTest("Attempt to close the keyboard", 1, function() {
    forge.ionic_keyboard.close(function () {
        ok(true, "Expected success");
        start();
    }, function () {
        ok(false, "Expected success");
        start();
    });
});