import ATAuthSDK
import Flutter
import UIKit

public class FlAliYunNumberAuthPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "fl_aliyun_number_auth", binaryMessenger: registrar.messenger())
        let instance = FlAliYunNumberAuthPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }

    private var authHelper = TXCommonHandler()
    private var authUtils = TXCommonUtils()
    private var authModel = TXCustomModel()

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "setAuthSDKInfo":
            break

        default:
            result(FlutterMethodNotImplemented)
        }
    }
}
