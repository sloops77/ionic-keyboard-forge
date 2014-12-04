ionic-keyboard-forge
====================

Port of ionic-plugins-keyboard to trigger.io

Keyboard
======

The `ionic-keyboard-forge` module provides functions to make interacting with the keyboard easier, and fires events to indicate that the keyboard will hide/show.

Add it by uploading a private module using trigger.io

Methods
-------

- forge.ionic_keyboard.hideKeyboardAccessoryBar
- forge.ionic_keyboard.close
- forge.ionic_keyboard.disableScroll
- forge.ionic_keyboard.isVisible

Events
--------

These events are fired on the window (the module transparently forwards events sent to forge to window for compatibility with cordova reasons).

- native.keyboardshow
  * A number `keyboardHeight` is given on the event object, which is the pixel height of the keyboard.
- native.keyboardhide


Keyboard.hideKeyboardAccessoryBar
=================

Hide the keyboard accessory bar with the next, previous and done buttons. This offers similar functionality to damn_you_form_assist module

    forge.ionic_keyboard.hideKeyboardAccessoryBar(true);
    forge.ionic_keyboard.hideKeyboardAccessoryBar(false);

Supported Platforms
-------------------

- iOS


Keyboard.close
=================

Close the keyboard if it is open.

    forge.ionic_keyboard.close();

Supported Platforms
-------------------

- iOS (Android coming soon)


Keyboard.disableScroll
=================

Disable native scrolling, useful if you are using JavaScript to scroll

    forge.ionic_keyboard.disableScroll(true);
    forge.ionic_keyboard.disableScroll(false);

Supported Platforms
-------------------

- iOS

Keyboard.show (coming soon)
=================

Force keyboard to be shown on Android. This typically helps if autofocus on a text element does not pop up the keyboard automatically

    forge.ionic_keyboard.show();

Supported Platforms

- Android

native.keyboardshow
=================

This event fires when the keyboard will be shown

    window.addEventListener('native.keyboardshow', keyboardShowHandler);

    function keyboardShowHandler(e){
        alert('Keyboard height is: ' + e.keyboardHeight);
    }

Properties
-----------

keyboardHeight: the height of the keyboard in pixels


Supported Platforms
-------------------

- iOS, (Android coming soon)


native.keyboardhide
=================

This event fires when the keyboard will hide

    window.addEventListener('native.keyboardhide', keyboardHideHandler);

    function keyboardHideHandler(e){
        alert('Goodnight, sweet prince');
    }

Properties
-----------

None

Supported Platforms
-------------------

- iOS, (Android coming soon)
