import ATAuthSDK
import Flutter
import UIKit

public class FlAliYunNumberAuthPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "fl_aliyun_number_auth", binaryMessenger: registrar.messenger())
        let instance = FlAliYunNumberAuthPlugin(registrar)
        registrar.addMethodCallDelegate(instance, channel: channel)
    }

    init(_ registrar: FlutterPluginRegistrar) {
        self.registrar = registrar
    }

    private let registrar: FlutterPluginRegistrar
    private var authHelper = TXCommonHandler.sharedInstance()
    private var authUiModel = TXCustomModel()

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "setAuthSDKInfo":
            let args = call.arguments as! [String: Any]
            authHelper.setAuthSDKInfo(args["secret"] as! String) { dict in
                result(dict)
            }
        case "setLoggerInfo":
            let args = call.arguments as! [String: Any]

            let reporter = authHelper.getReporter()
            reporter.setConsolePrintLoggerEnable(args["enable"] as! Bool)
            reporter.setUploadEnable(args["enableUpload"] as! Bool)
            if args["enableHandler"] as! Bool {}
        case "getLoginToken":
            getLoginToken(call, result)
        case "quitLoginPage":
            let args = call.arguments as! [String: Any]
            authHelper.cancelLoginVC(animated: args["animated"] as! Bool) {
                result(true)
            }
        case "accelerateLoginPage":
            let args = call.arguments as! [String: Any]
            authHelper.accelerateLoginPage(withTimeout: TimeInterval(args["timeout"] as! Int)) { dict in
                result(dict)
            }
        case "getVersion":
            result(authHelper.getVersion())
        case "checkEnvAvailable":
            let args = call.arguments as! [String: Any]
            authHelper.checkEnvAvailable(with: PNSAuthType(rawValue: args["authType"] as! Int)!) { dict in
                result(dict)
            }
        case "setCheckboxIsChecked":
            let args = call.arguments as! [String: Any]
            authHelper.setCheckboxIsChecked(args["isChecked"] as! Bool)
        case "queryCheckBoxIsChecked":
            result(authHelper.queryCheckBoxIsChecked())
        case "hideLoginLoading":
            result(authHelper.hideLoginLoading())
        case "getCurrentCarrierName":
            result(TXCommonUtils.getCurrentCarrierName())
        case "setAuthUI":
            setAuthUI(call, result)
        case "quitPrivacyAlert":
            authHelper.closePrivactAlertView()
            result(true)

        /// 以下为ios特有
        case "privacyAnimationStart":
            authHelper.privacyAnimationStart()
            result(true)
        case "checkboxAnimationStart":
            authHelper.checkboxAnimationStart()
            result(true)
        case "checkDeviceCellularDataEnable":
            result(TXCommonUtils.checkDeviceCellularDataEnable())
        case "isChinaUnicom":
            result(TXCommonUtils.isChinaUnicom())
        case "isChinaMobile":
            result(TXCommonUtils.isChinaMobile())
        case "isChinaTelecom":
            result(TXCommonUtils.isChinaTelecom())
        case "getNetworkType":
            result(TXCommonUtils.getNetworktype())
        case "isWWANOpen":
            result(TXCommonUtils.isWWANOpen())
        case "reachableViaWWAN":
            result(TXCommonUtils.reachableViaWWAN())
        case "getMobilePrivateIPAddress":
            let args = call.arguments as! [String: Any]
            result(TXCommonUtils.getMobilePrivateIPAddress(args["preferIPv4"] as! Bool))
        case "getUniqueID":
            result(TXCommonUtils.getUniqueID())
        default:
            result(FlutterMethodNotImplemented)
        }
    }

    func getLoginToken(_ call: FlutterMethodCall, _ result: @escaping FlutterResult) {
        if let controller = getCurrentViewController() {
            let args = call.arguments as! [String: Any]

            let isDebug = args["isDebug"] as! Bool
            if isDebug {
                authHelper.getLoginToken(withTimeout: TimeInterval(args["timeout"] as! Int), controller: controller, model: authUiModel) { dict in
                    result(dict)
                }
            } else {
                authHelper.debugLoginUI(with: controller, model: authUiModel) { dict in
                    result(dict)
                }
            }

        } else {
            result(nil)
        }
    }

    func setAuthUI(_ call: FlutterMethodCall, _ result: @escaping FlutterResult) {
        let args = call.arguments as! [String: Any]
        if let statusBar = args["statusBarUi"] as? [String: Any] {}
        if let navUi = args["navUi"] as? [String: Any] {}
        if let logoUi = args["logoUi"] as? [String: Any] {}
        if let sloganUi = args["sloganUi"] as? [String: Any] {}
        if let numberUi = args["numberUi"] as? [String: Any] {}
        if let privacyUi = args["privacyUi"] as? [String: Any] {}
        if let loginBtnUi = args["loginBtnUi"] as? [String: Any] {}
        if let switchUi = args["switchUi"] as? [String: Any] {}
        if let pageUi = args["pageUi"] as? [String: Any] {}
        if let privacyAlertUi = args["privacyAlertUi"] as? [String: Any] {}
    }

    // 获取当前的 UIViewController
    private func getCurrentViewController() -> UIViewController? {
        if let appDelegate = UIApplication.shared.delegate,
           let window = appDelegate.window,
           let rootViewController = window?.rootViewController
        {
            return rootViewController
        }
        return nil
    }
}
