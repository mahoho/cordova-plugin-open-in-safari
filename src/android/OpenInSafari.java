package com.plugin.OpenInSafari;

import android.content.Intent;
import android.net.Uri;
import org.apache.cordova.CallbackContext;
import org.apache.cordova.CordovaPlugin;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
//import java.util.concurrent.Executor;

/**
 * Google Pay implementation for Cordova
 */
public class OpenInSafari extends CordovaPlugin {

    @Override
    public boolean execute(String action, JSONArray args, CallbackContext callbackContext) throws JSONException {
        if (action.equals("open")) {
            this.open(args, callbackContext);
            return true;
        }
        return false;
    }

    private void open(JSONArray args, CallbackContext callbackContext) throws JSONException {
        JSONObject argss = args.getJSONObject(0);
        String url = this.getParam(argss, "url");

        if(url == null) {
            callbackContext.error("No URL Provided");
        }

        try {
            Intent intent = new Intent(Intent.ACTION_VIEW, Uri.parse(url));
            // Start the activity on the main thread using the Cordova context
            cordova.getActivity().startActivity(intent);
            callbackContext.success("Browser opened successfully");
        } catch (Exception e) {
            callbackContext.error("Failed to open browser: " + e.getMessage());
        }
    }


    private String getParam(JSONObject args, String name) throws JSONException {
        String param = args.getString(name);

        if (param == null || param.length() == 0) {
            throw new JSONException(String.format("%s is required", name));
        }

        return param;
    }
}
