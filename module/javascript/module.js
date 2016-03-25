// Expose the native API to javascript
forge.ionic_keyboard = {
    hideKeyboardAccessoryBar: function(hide, success, error) {
        // forge.internal.call('ionic_keyboard.hideKeyboardAccessoryBar', {val: hide}, success, error);
        console.warn('hideKeyboardAccessoryBar has been removed until a method is found that doesn\'t get rejected from the App Store.');
    },

    close: function(success, error) {
        forge.internal.call('ionic_keyboard.close', null, success, error);
    },

    show: function(success, error) {
        forge.internal.call('ionic_keyboard.show', null, success, error);
    },

    disableScroll: function(disable, success, error) {
        forge.internal.call('ionic_keyboard.disableScroll', {val: disable}, success, error);
    },

    isVisible: false
};
//
//borrowed from CORDOVA
forge.internal.addEventListener("fireWindowEvent", function (params) {
    forge.logging.log("fireWindowEvent: " + JSON.stringify(params));
    event = document.createEvent('Events');
    event.initEvent(params['eventType'], false, false);
    for(var key in params) {
        if (key != 'eventType' && params.hasOwnProperty(key))
            event[key] = params[key];
    }
    window.dispatchEvent(event);
});

forge.internal.addEventListener("setProperty", function (params) {
    forge.logging.log("setProperty: " + JSON.stringify(params));
    var keys = params['name'].split('.');
    var propertyHolder = window;
    if (keys.length >= 2)
        for(var i = 0; i < keys.length - 1; i++) {
            propertyHolder = propertyHolder[keys[i]];
        }
    propertyHolder[keys[keys.length - 1]] = params['value'];
});

