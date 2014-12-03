// Expose the native API to javascript
forge.ionic_keyboard = {
    disableScroll: function(disable, success, error) {
        forge.internal.call('ionic_keyboard.disableScroll', {val: disable}, success, error);
    },

    hideKeyboardAccessoryBar: function(hide, success, error) {
        forge.internal.call('ionic_keyboard.hideKeyboardAccessoryBar', {val: hide}, success, error);
    },

    isKeyboardVisible: function(success, error) {
        forge.internal.call('ionic_keyboard.isKeyboardVisible', null, success, error);
    },

    close: function(success, error) {
        forge.internal.call('ionic_keyboard.close', null, success, error);
    }
};
//
//borrowed from CORDOVA
forge.ionic__createEvent = function(type, data) {
    var event = document.createEvent('Events');
    event.initEvent(type, false, false);
    if (data) {
        for (var i in data) {
            if (data.hasOwnProperty(i)) {
                event[i] = data[i];
            }
        }
    }
    return event;
};

// Register for our native event
forge.internal.addEventListener("native.keyboardshow", function (params) {
    forge.logging.log("native.keyboardshow: " + JSON.stringify(params));
    window.dispatchEvent(forge.ionic__createEvent('native.keyboardshow', params));
});

forge.internal.addEventListener("native.keyboardhide", function (params) {
    forge.logging.log("native.keyboardhide: " + JSON.stringify(params));
    window.dispatchEvent(forge.ionic__createEvent('native.keyboardhide', params));
});

