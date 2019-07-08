import Flutter
import UIKit
import CoreTelephony

public class SwiftFlutterNetworkPlugin: NSObject, FlutterPlugin, FlutterStreamHandler {
    private var cellularData : CTCellularData
    private var eventSink: FlutterEventSink?
    
    public func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        eventSink = events;
        return nil
    }
    
    public func onCancel(withArguments arguments: Any?) -> FlutterError? {
        eventSink = nil
        return nil
    }
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "flutter_network", binaryMessenger: registrar.messenger())
        let eventChannel = FlutterEventChannel(name: "com_ethras_flutter_network/stream", binaryMessenger: registrar.messenger())
        let instance = SwiftFlutterNetworkPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
        eventChannel.setStreamHandler(instance)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        if (call.method == "isCellularDataRestricted") {
            result(getCellularDataRestricted())
        }
    }
    
    public override init() {
        cellularData = CTCellularData.init()
        eventSink = nil
        super.init()
        
        cellularData.cellularDataRestrictionDidUpdateNotifier = { state in
            if (self.eventSink != nil) {
                print("cellularState changed! " + String(describing: state) )
                let res = state == .restricted
                self.eventSink!(res)
            }
        }
    }
    
    private func getCellularDataRestricted()  -> Bool {
        print("CellularRestricted check : " + "\(cellularData.restrictedState == .restricted ? "restricted" : cellularData.restrictedState == .restrictedStateUnknown ? "unknown" : "unrestricted")")
        return  cellularData.restrictedState == .restricted
    }
}
