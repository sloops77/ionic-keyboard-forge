package io.trigger.forge.android.modules.ionic_keyboard;

import android.content.Context;
import android.view.View;
import android.view.inputmethod.InputMethodManager;
import io.trigger.forge.android.core.ForgeApp;
import io.trigger.forge.android.core.ForgeTask;

public class API {
	public static void close(final ForgeTask task) {
		task.performAsync(new Runnable() {
			@Override
			public void run() {
				//http://stackoverflow.com/a/7696791/1091751
				InputMethodManager inputManager = (InputMethodManager) ForgeApp.getActivity().getSystemService(Context.INPUT_METHOD_SERVICE);
				View v = ForgeApp.getActivity().getCurrentFocus();

				if (v == null) {
					task.error("No current focus");
				} else {
					inputManager.hideSoftInputFromWindow(v.getWindowToken(), InputMethodManager.HIDE_NOT_ALWAYS);
					task.success(); // Thread-safe.
				}
			}
		});
	}

	public static void show(final ForgeTask task) {
		task.performAsync(new Runnable() {
			@Override
			public void run() {
				((InputMethodManager) ForgeApp.getActivity().getSystemService(Context.INPUT_METHOD_SERVICE)).toggleSoftInput(0, InputMethodManager.HIDE_IMPLICIT_ONLY);
				task.success(); // Thread-safe.
			}
		});
	}

	public static void hideKeyboardAccessoryBar(final ForgeTask task, final Boolean val) {
		// shim for iOS-only functionality
		task.success();
	}


	public static void disableScroll(final ForgeTask task, final Boolean val) {
		// shim for iOS-only functionality
		task.success();
	}
}
