import Foundation
import CoreLocation

@objc(OpenInSafari) class OpenInSafari : CDVPlugin {
    var currentCallbackId : String?
  
    @objc(open:) func open(command: CDVInvokedUrlCommand){
      let callbackID = command.callbackId;
      currentCallbackId = callbackID
      
      let targetUrl = try getFromRequest(fromArguments: command.arguments, key: "url") as! String
      
      if let url = URL(string: targetUrl) {
          UIApplication.shared.open(url)
      } else {
          failWithError("Wrong URL Provided")
      }
      

      let result = CDVPluginResult(status: CDVCommandStatus_OK, messageAs: targetUrl)
      commandDelegate.send(result, callbackId: callbackID)
    }

    private func failWithError(_ error: String){
        let result = CDVPluginResult(status: CDVCommandStatus_ERROR, messageAs: error)
        commandDelegate.send(result, callbackId: currentCallbackId)
    }

  private func getFromRequest(fromArguments arguments: [Any]?, key: String) -> Any {
        let val = (arguments?[0] as? [AnyHashable : Any])?[key]

        return val!
    }
}
