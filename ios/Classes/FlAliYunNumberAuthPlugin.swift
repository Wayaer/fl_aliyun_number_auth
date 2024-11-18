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
        if let statusBar = args["statusBarUi"] as? [String: Any] {
            if let value = statusBar["prefersStatusBarHidden"] as? Bool {
                authUiModel.prefersStatusBarHidden = value
            }
            if let value = statusBar["preferredStatusBarStyle"] as? Int {
                authUiModel.preferredStatusBarStyle = UIStatusBarStyle(rawValue: value)!
            }
        }
        if let navUi = args["navUi"] as? [String: Any] {
            if let value = navUi["navIsHidden"] as? Bool {
                authUiModel.navIsHidden = value
            }
            if let value = navUi["navColor"] as? Int {
                authUiModel.navColor = value.toColor()
            }
            if let value = navUi["navTitle"] as? [String: Any] {
                if let text = value.toNSAttributedString() { authUiModel.navTitle = text }
            }
            if let value = navUi["navBackImage"] as? String {
                if let image = value.toUIImage(registrar) {
                    authUiModel.navBackImage = image
                }
            }
            if let value = navUi["hideNavBackItem"] as? Bool {
                authUiModel.hideNavBackItem = value
            }
            if let value = navUi["navMoreView"] as? [String: Any] {
                if let view = value.toUIView() {
                    authUiModel.navMoreView = view
                }
            }
//            if let value = navUi["navBackButtonFrameBlock"] as? Any {
//                authUiModel.navBackButtonFrameBlock=
//            }
//            if let value = navUi["navTitleFrameBlock"] as? Any {
//                authUiModel.navTitleFrameBlock = value
//            }
//            if let value = navUi["navMoreViewFrameBlock"] as? Any {
//                authUiModel.navMoreViewFrameBlock = value
//            }
            if let value = navUi["privacyNavColor"] as? Int {
                authUiModel.privacyNavColor = value.toColor()
            }
            if let value = navUi["privacyNavTitleFont"] as? [String: Any] {
                if let uiFont = value.toUIFont() {
                    authUiModel.privacyNavTitleFont = uiFont
                }
            }
            if let value = navUi["privacyNavTitleColor"] as? Int {
                authUiModel.privacyNavTitleColor = value.toColor()
            }
            if let value = navUi["privacyNavBackImage"] as? String {
                if let image = value.toUIImage(registrar) {
                    authUiModel.privacyNavBackImage = image
                }
            }
        }
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

extension [String: Any] {
    func toNSAttributedString() -> NSAttributedString? {
        if let text = self["text"] as? String {
            return NSAttributedString(string: text)
        }
        return nil
    }

    func toUIView() -> UIView? {
        return nil
    }

    func toUIFont() -> UIFont? {
        return nil
    }
}

extension String {
    // 资源路径转 Bundle
    func toBundle(_ registrar: FlutterPluginRegistrar) -> String? {
        Bundle.main.path(forResource: registrar.lookupKey(forAsset: self), ofType: nil)
    }

    // to ui image
    func toUIImage() -> UIImage? {
        UIImage(contentsOfFile: self)
    }

    // to ui image
    func toUIImage(_ registrar: FlutterPluginRegistrar) -> UIImage? {
        toBundle(registrar)?.toUIImage()
    }
}

extension Int {
    // 从整数转换为UIColor（支持透明度）
    func toColor() -> UIColor {
        let alpha = CGFloat((self >> 24) & 0xFF) / 255.0 // 获取透明度部分
        let red = CGFloat((self >> 16) & 0xFF) / 255.0 // 获取红色部分
        let green = CGFloat((self >> 8) & 0xFF) / 255.0 // 获取绿色部分
        let blue = CGFloat(self & 0xFF) / 255.0 // 获取蓝色部分
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
}
