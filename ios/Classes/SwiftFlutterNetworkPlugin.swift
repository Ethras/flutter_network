import Flutter
import UIKit
import CoreTelephony

public class SwiftFlutterNetworkPlugin: NSObject, FlutterPlugin {
    private static var currentState = CTCellularDataRestrictedState.restrictedStateUnknown
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "flutter_network", binaryMessenger: registrar.messenger())
        let instance = SwiftFlutterNetworkPlugin()
        prepare()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        if (call.method == "isCellularDataRestricted") {
            result(SwiftFlutterNetworkPlugin.currentState == .restricted)
        }
    }
    
    
    private static func prepare() {
        if #available(iOS 9.0, *) {
            let cellState = CTCellularData.init()
            cellState.cellularDataRestrictionDidUpdateNotifier = { (dataRestrictedState) in
                if currentState != .restrictedStateUnknown { // State has changed - log to console
                    print("cellularDataRestrictedState: " + "\(dataRestrictedState == .restrictedStateUnknown ? "unknown" : dataRestrictedState == .restricted ? "restricted" : "not restricted")")
                }
                currentState = dataRestrictedState
            }
        }
    }
}
