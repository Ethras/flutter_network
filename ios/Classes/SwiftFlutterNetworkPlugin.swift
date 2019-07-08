import Flutter
import UIKit
import CoreTelephony

public class SwiftFlutterNetworkPlugin: NSObject, FlutterPlugin {
    private var cellState : CTCellularData
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "flutter_network", binaryMessenger: registrar.messenger())
        let instance = SwiftFlutterNetworkPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        if (call.method == "isCellularDataRestricted") {
            result(getCellularDataRestricted())
        }
    }
    
    public override init() {
        cellState = CTCellularData.init()
    }
    
    private func getCellularDataRestricted()  -> Bool {
            print("CellularRestricted check : " + "\(cellState.restrictedState == .restricted ? "restricted" : cellState.restrictedState == .restrictedStateUnknown ? "unknown" : "unrestricted")")
            return  cellState.restrictedState == .restricted
    }
}
