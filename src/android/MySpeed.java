package com.plugin.myspeed;

import android.location.Location;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.ObjectWriter;
import nz.apped.cartrack.MainActivity;
import org.apache.cordova.CallbackContext;
import org.apache.cordova.CordovaPlugin;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
//import java.util.concurrent.Executor;

/**
 * Google Pay implementation for Cordova
 */
public class MySpeed extends CordovaPlugin {

    @Override
    public boolean execute(String action, JSONArray args, CallbackContext callbackContext) throws JSONException {
        if (action.equals("get")) {
            this.get(args, callbackContext);
            return true;
        }
        return false;
    }

    private void get(JSONArray args, CallbackContext callbackContext) throws JSONException {
        MainActivity activity = (MainActivity)this.cordova.getActivity();
        Location loc = activity.locationListener.lastLocation;

        if(loc == null) {
            callbackContext.error("No Location");
            return;
        }

        com.plugin.myspeed.MySpeed.LocStuct object = new com.plugin.myspeed.MySpeed.LocStuct();
        object.lat = loc.getLatitude();;
        object.lng = loc.getLongitude();
        object.speed = activity.locationListener.lastLocation.getSpeed();
        object.speed = (int)((object.speed * 3600) / 1000);

        ObjectWriter ow = new ObjectMapper().writer().withDefaultPrettyPrinter();
        try {
            String json = ow.writeValueAsString(object);
            callbackContext.success(json);
        } catch (JsonProcessingException e) {
            callbackContext.error(e.getMessage());
        }
    }


    private String getParam(JSONObject args, String name) throws JSONException {
        String param = args.getString(name);

        if (param == null || param.length() == 0) {
            throw new JSONException(String.format("%s is required", name));
        }

        return param;
    }

    private class LocStuct {
        public Double lat;
        public Double lng;
        public float speed;
    }
}
