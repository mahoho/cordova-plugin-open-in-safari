//
//  MySpeed.swift
//
//
//  Created by Oleksii on 11.01.2021.
//

import Foundation
import CoreLocation

@objc(MySpeed) class MySpeed : CDVPlugin, CLLocationManagerDelegate {
    var mLocationManager: CLLocationManager?
    var lastLocation: CLLocation?
    var currentCallbackId : String?

    /**
     * Check device for ApplePay capability
     */
    @objc(get:) func get(command: CDVInvokedUrlCommand){
       let callbackID = command.callbackId;
        currentCallbackId = callbackID

        if(mLocationManager == nil) {
            mLocationManager = CLLocationManager()
            mLocationManager!.delegate = self
            mLocationManager!.desiredAccuracy = kCLLocationAccuracyBest
            // Get Location Permission one time only
            mLocationManager!.requestWhenInUseAuthorization()
            // Need to update location and get location data in locationManager object with delegate
            mLocationManager!.startUpdatingLocation()
            mLocationManager!.startMonitoringSignificantLocationChanges()
            mLocationManager!.requestLocation()
        }

        if lastLocation != nil  {
                    // Get the speed in meters per second
            let speed = lastLocation!.speed < 0 ? 0 : lastLocation!.speed;
            // Convert the speed to kilometers per hour
            let speedInKmPerHour = speed * 3.6

            let locStruct = LocStuct(lat: lastLocation!.coordinate.latitude, lng: lastLocation!.coordinate.longitude, speed: speedInKmPerHour)

            do {
                let jsonData = try JSONEncoder().encode(locStruct)
                let jsonString = String(data: jsonData, encoding: .utf8)!

                let result = CDVPluginResult(status: CDVCommandStatus_OK, messageAs: jsonString)
                commandDelegate.send(result, callbackId: callbackID)

            } catch { print(error) }


        } else {
            failWithError("Location Not available")
        }


    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        lastLocation = locations[0]
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Swift.Error) {
        print(error)
    }

    private func failWithError(_ error: String){
        let result = CDVPluginResult(status: CDVCommandStatus_ERROR, messageAs: error)
        commandDelegate.send(result, callbackId: currentCallbackId)
    }
}


struct LocStuct : Encodable {
    var lat: Double
    var lng: Double
    var speed: Double
}
