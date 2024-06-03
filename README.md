# Cordova Current Speed Plugin
This plugin is built as unified method for getting current location along with current speed.

## Installation

```
cordova plugin add cordova-plugin-my-speed
```

## Usage

`cordova.plugins.MySpeed.get()` returns json string (iOS) or object (Android) with following props:

```
{
    lat: 0,
    lng: 0,
    speed: 0
}
```
On iOS, use JSON.parse() to get object from response.

