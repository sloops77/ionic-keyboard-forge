// Expose the native API to javascript
forge.ionic_keyboard = {
    disableScroll: function(disable, success, error) {
        forge.internal.call('ionic_keyboard.disableScroll', {val: disable}, success, error);
    },

    hideKeyboardAccessoryBar: function(hide, success, error) {
        forge.internal.call('ionic_keyboard.hideKeyboardAccessoryBar', {val: hide}, success, error);
    },

    close: function(success, error) {
        forge.internal.call('ionic_keyboard.close', null, success, error);
    },

    showAlert: function (text, success, error) {
        forge.internal.call('ionic_keyboard.showAlert', {text: text}, success, error);
    }
};

// Register for our native event
forge.internal.addEventListener("ionic_keyboard.resume", function () {
	alert("Welcome back!");
});
