package io.trigger.forge.android.modules.ionic_keyboard;

import android.graphics.Rect;
import android.os.Bundle;
import android.util.DisplayMetrics;
import android.view.View;
import android.view.ViewTreeObserver;
import com.google.gson.JsonParser;
import io.trigger.forge.android.core.ForgeApp;
import io.trigger.forge.android.core.ForgeEventListener;

public class EventListener extends ForgeEventListener {
	@Override
	public void onCreate(Bundle savedInstanceState) {
		DisplayMetrics dm = new DisplayMetrics();
		ForgeApp.getActivity().getWindowManager().getDefaultDisplay().getMetrics(dm);
		final float density = dm.density;

		//http://stackoverflow.com/a/4737265/1091751 detect if keyboard is showing
		final View rootView = ForgeApp.getActivity().getWindow().getDecorView().findViewById(android.R.id.content).getRootView();
		ViewTreeObserver.OnGlobalLayoutListener list = new ViewTreeObserver.OnGlobalLayoutListener() {
			int previousHeightDiff = 0;
			@Override
			public void onGlobalLayout() {
				Rect r = new Rect();
				//r will be populated with the coordinates of your view that area still visible.
				rootView.getWindowVisibleDisplayFrame(r);

				int heightDiff = rootView.getRootView().getHeight() - (r.bottom);
				int pixelHeightDiff = (int)(heightDiff / density);
				if (pixelHeightDiff > 100 && pixelHeightDiff != previousHeightDiff) { // if more than 100 pixels, its probably a keyboard...
					ForgeApp.event("setProperty", new JsonParser().parse("{name: \"forge.ionic_keyboard.isVisible\", value: true}"));
					ForgeApp.event("fireWindowEvent", new JsonParser().parse("{eventType: \"native.keyboardshow\", keyboardHeight: " + pixelHeightDiff + ")}"));
				}
				else if ( pixelHeightDiff != previousHeightDiff && ( previousHeightDiff - pixelHeightDiff ) > 100 ){
					ForgeApp.event("setProperty", new JsonParser().parse("{name: \"forge.ionic_keyboard.isVisible\", value: false}"));
					ForgeApp.event("fireWindowEvent", new JsonParser().parse("{eventType: \"native.keyboardhide\"}"));
				}
				previousHeightDiff = pixelHeightDiff;
			}
		};

		rootView.getViewTreeObserver().addOnGlobalLayoutListener(list);

	}
}
