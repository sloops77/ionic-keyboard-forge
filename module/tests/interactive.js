module("ionic_keyboard");

//// In this test we call the example showAlert API method with an example string
//asyncTest("Attempt to show an alert with no text", 1, function() {
//	forge.ionic_keyboard.showAlert("Hello, testing world!", function () {
//		askQuestion("Did you see an alert with the message 'Hello, testing world!'?", {
//			Yes: function () {
//				ok(true, "User claims success");
//				start();
//			},
//			No: function () {
//				ok(false, "User claims failure");
//				start();
//			}
//		});
//	}, function () {
//		ok(false, "API method returned failure");
//		start();
//	});
//});

function cleanUp () {
    $('.clean-me-up').remove();
}

asyncTest("Attempt to hide form assist bar", 1, function () {
    askQuestion("Tap on the input", {
        "Nothing happened": function () {
            ok(false, "User claims failure: nothing happened");
            start();
            cleanUp();
        }
    });
    var form = $('<form class="clean-me-up"><input type="text" placeholder="tap me"/></form>').insertBefore('#qunit');

    $('input', form).on('focus', function () {
        forge.ionic_keyboard.hideKeyboardAccessoryBar(true, function () {
            askQuestion("Is the form assist bar visible?", {
                Yes: function () {
                    ok(false, "User claims failure: form assist visible");
                    start();
                    cleanUp();
                },
                No: function () {
                    ok(true, "User claims success");
                    start();
                    cleanUp();
                }
            });
        }, function (e) {
            ok(false, "User claims failure: "+JSON.stringify(e));
            start();
            cleanUp();
        });
    });
});